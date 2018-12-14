package elec5619.group3.besocialos.service;

import com.github.scribejava.apis.LinkedInApi;
import com.github.scribejava.apis.LinkedInApi20;
import com.github.scribejava.apis.TwitterApi;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.*;
import com.github.scribejava.core.oauth.OAuth10aService;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.github.scribejava.core.oauth.OAuthService;
import elec5619.group3.besocialos.model.User;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.ExecutionException;

@Service
public class LinkedInService {
    @Autowired
    UserService userService;

    @Autowired
    CipherService cipherService;

    private String clientId = "86nvxlniw8o5l3";
    private String clientSecret = "mmdBjDBS4o5U9VmP";
    final String secretState = "secret" + new Random().nextInt(999_999);

    final OAuth20Service service = new ServiceBuilder(clientId)
            .apiSecret(clientSecret)
            .scope("r_basicprofile r_emailaddress")
            .state(secretState)
            .callback("http://localhost:8080/linkedIn/callback")
            .build(LinkedInApi20.instance());

    public String getLoginURL() throws InterruptedException, ExecutionException, IOException {
        return service.getAuthorizationUrl();
    }

    public void authorize(String code, String googleCipher) throws InterruptedException, ExecutionException, IOException, ParseException {
        OAuth2AccessToken accessToken = service.getAccessToken(code);
        final OAuthRequest request = new OAuthRequest(Verb.GET, "https://api.linkedin.com/v2/me");
        service.signRequest(accessToken, request);
        final Response response = service.execute(request);

        System.out.println("response: " + response.getBody());

        JSONParser parser = new JSONParser();
        JSONObject jsonObject = (JSONObject) parser.parse(response.getBody());
        String id = (String) jsonObject.get("id");

        System.out.println("id: " + id);

        userService.addLinkedIn(id, accessToken.getAccessToken(), cipherService.decrypt(googleCipher));
    }

    public List<Map<String, String>> getActivities(String googleCipher) throws InterruptedException, ExecutionException, IOException, ParseException {
        String googleToken = cipherService.decrypt(googleCipher);

        final OAuthRequest request = new OAuthRequest(Verb.GET, "https://api.linkedin.com/v2/activityFeeds?q=networkShares");
        OAuth2AccessToken linkedInToken = new OAuth2AccessToken(
                userService.getUserLinkedInToken(googleToken));
        service.signRequest(linkedInToken, request);
        final Response response = service.execute(request);

        System.out.println(response.getHeaders());
        System.out.println(response.getBody());

        JSONParser parser = new JSONParser();
        JSONObject jsonObject = (JSONObject) parser.parse(response.getBody());
        String before = (String)((JSONObject)jsonObject.get("metadata")).get("before");

        final OAuthRequest request2 = new OAuthRequest(Verb.GET, "https://api.linkedin.com/v2/activityFeeds?q=networkShares&after="
                + before + "projection=(paging,elements*(reference~(content,text,created,owner~(id,pictureInfo,localizedFirstName,localizedLastName))))");
        service.signRequest(linkedInToken, request2);
        final Response response2 = service.execute(request2);

        jsonObject = (JSONObject) parser.parse(response2.getBody());
        JSONArray jsonArray = (JSONArray) jsonObject.get("elements");
        System.out.println(jsonArray);

        List<Map<String, String>> ret = new ArrayList<>();
        for (Object o: jsonArray) {
            Map<String, String> attrs = new HashMap<>();
            attrs.put("firstName", (String)((JSONObject)((JSONObject)((JSONObject) o).get("reference~")).get("owner~")).get("localizedFirstName"));
            attrs.put("lastName", (String)((JSONObject)((JSONObject)((JSONObject) o).get("reference~")).get("owner~")).get("localizedLastName"));
            attrs.put("time", (String)((JSONObject)((JSONObject)((JSONObject) o).get("reference~")).get("created")).get("time"));
            attrs.put("text", (String)((JSONObject)((JSONObject)((JSONObject) o).get("reference~")).get("text")).get("text"));
            ret.add(attrs);
        }

        return ret;
    }

    public void post(String googleCipher, String post) throws InterruptedException, ExecutionException, IOException {
        String googleToken = cipherService.decrypt(googleCipher);

        final OAuthRequest request = new OAuthRequest(Verb.POST, "https://api.linkedin.com/v1/people/~/shares?format=json");
        request.addBodyParameter("comment", post);
        request.addBodyParameter("visibility", "{'code': 'anyone'}");
        OAuth2AccessToken linkedInToken = new OAuth2AccessToken(
                userService.getUserLinkedInToken(googleToken));
        service.signRequest(linkedInToken, request);
        final Response response = service.execute(request);

        System.out.println(response.getHeaders());
        System.out.println(response.getBody());
    }

    public void logout(String googleCipher){
        String googleToken = cipherService.decrypt(googleCipher);
        userService.removeTwitter(googleToken);
    }
}
