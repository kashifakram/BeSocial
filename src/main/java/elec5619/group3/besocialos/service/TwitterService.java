package elec5619.group3.besocialos.service;

import com.github.scribejava.apis.TwitterApi;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.*;
import com.github.scribejava.core.oauth.OAuth10aService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Service
public class TwitterService {
    @Autowired
    UserService userService;

    @Autowired
    CipherService cipherService;

    private String consumerKey = "Dp8GQJApYyNwmbUCpQVTpR575"; // The application's consumer key
    private String consumerSecret = "TxHQe1MtsBqKBfRiZGWoMuDJ8mPGf6DxCoXfEEyxi5ClWSRTpq"; // The application's consumer secret

    private final OAuth10aService service = new ServiceBuilder(consumerKey)
            .apiSecret(consumerSecret)
            .callback("http://localhost:8080/twitter/callback")
            .build(TwitterApi.instance());

    private OAuth1RequestToken requestToken;

    public String getLoginURL() throws InterruptedException, ExecutionException, IOException {
        requestToken = service.getRequestToken();
        return service.getAuthorizationUrl(requestToken);
    }

    public void authorize(String token, String verfier, String googleCipher) throws InterruptedException, ExecutionException, IOException, ParseException {
        final OAuth1AccessToken accessToken = service.getAccessToken(requestToken, verfier);

        final OAuthRequest request = new OAuthRequest(Verb.GET, "https://api.twitter.com/1.1/account/verify_credentials.json");
        service.signRequest(accessToken, request);
        final Response response = service.execute(request);

        System.out.println("response: " + response.getBody());

        JSONParser parser = new JSONParser();
        JSONObject jsonObject = (JSONObject) parser.parse(response.getBody());
        String id = (String) jsonObject.get("id_str");
        System.out.println("id: " + id);

        userService.addTwitter(id, accessToken.getToken(), accessToken.getTokenSecret(), cipherService.decrypt(googleCipher));
    }

    public List<Map<String, String>> getTimeLine(String googleCipher) throws InterruptedException, ExecutionException, IOException, ParseException {
        String googleToken = cipherService.decrypt(googleCipher);

        final OAuthRequest request = new OAuthRequest(Verb.GET, "https://api.twitter.com/1.1/statuses/home_timeline.json");
        OAuth1AccessToken twitterToken = new OAuth1AccessToken(
                userService.getUserTwitterToken(googleToken),
                userService.getUserTwitterSecret(googleToken));
        service.signRequest(twitterToken, request);
        final Response response = service.execute(request);

        System.out.println(response.getHeaders());
        System.out.println(response.getBody());

        JSONParser parser = new JSONParser();
        JSONArray jsonArray = (JSONArray) parser.parse(response.getBody());

        System.out.println(jsonArray);

        List<Map<String, String>> ret = new ArrayList<>();
        for (Object o: jsonArray) {
            Map<String, String> attrs = new HashMap<>();
            attrs.put("name", (String)((JSONObject)((JSONObject) o).get("user")).get("name"));
            attrs.put("text", (String)((JSONObject) o).get("text"));
            attrs.put("time", (String)((JSONObject) o).get("created_at"));
            attrs.put("image", (String)((JSONObject)o).get("profile_image_url"));
            ret.add(attrs);
        }

        return ret;
    }

    public void post(String googleCipher, String post) throws InterruptedException, ExecutionException, IOException {
        String googleToken = cipherService.decrypt(googleCipher);

        final OAuthRequest request = new OAuthRequest(Verb.POST, "https://api.twitter.com/1.1/statuses/update.json");
        request.addQuerystringParameter("status", post);
        OAuth1AccessToken twitterToken = new OAuth1AccessToken(
                userService.getUserTwitterToken(googleToken),
                userService.getUserTwitterSecret(googleToken));
        service.signRequest(twitterToken, request);
        final Response response = service.execute(request);

        System.out.println(response.getHeaders());
        System.out.println(response.getBody());
    }

    public void logout(String googleCipher){
        String googleToken = cipherService.decrypt(googleCipher);
        userService.removeTwitter(googleToken);
    }
}
