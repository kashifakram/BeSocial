package elec5619.group3.besocialos.service;

import com.github.scribejava.apis.GoogleApi20;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import elec5619.group3.besocialos.model.User;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Random;
import java.util.concurrent.ExecutionException;

@Service
public class GoogleService {
    @Autowired
    UserService userService;

    @Autowired
    CipherService cipherService;

    final String clientId = "488598562191-7a4alsqvmi81bhpk5pu752e73k02fg7r.apps.googleusercontent.com";
    final String clientSecret = "H8HpMfvAmbb-sZU0vI6xavXy";
    final String secretState = "secret" + new Random().nextInt(999_999);

    final OAuth20Service service = new ServiceBuilder(clientId)
            .apiSecret(clientSecret)
            .scope("profile email")
            .state(secretState)
            .callback("http://localhost:8080/google/callback")
            .build(GoogleApi20.instance());

    public String getLoginURL() {
        return service.getAuthorizationUrl();
    }

    public String authorize(String code) throws InterruptedException, ExecutionException, IOException, ParseException {
        OAuth2AccessToken accessToken = service.getAccessToken(code);
        final OAuthRequest request = new OAuthRequest(Verb.GET, "https://www.googleapis.com/oauth2/v2/userinfo");
        service.signRequest(accessToken, request);
        final Response response = service.execute(request);

        System.out.println("response: " + response.getBody());

        JSONParser parser = new JSONParser();
        JSONObject jsonObject = (JSONObject) parser.parse(response.getBody());
        String id = (String) jsonObject.get("id");
        String name = (String) jsonObject.get("name");
        String email = (String) jsonObject.get("email");

        System.out.println("id: " + id + "\nname: " + name + "\nemail: " + email);

        User newUser = new User();
        newUser.setGoogleId(id);
        newUser.setName(name);
        newUser.setEmail(email);
        newUser.setGoogleToken(accessToken.getAccessToken());
        userService.saveIfNotExist(newUser);

        return cipherService.encrypt(accessToken.getAccessToken());
    }
}
