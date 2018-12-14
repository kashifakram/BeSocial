package elec5619.group3.besocialos.web;

import elec5619.group3.besocialos.model.Post;
import elec5619.group3.besocialos.service.PostService;
import elec5619.group3.besocialos.service.TwitterService;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;


@Controller
@RequestMapping(value = "/post")
public class PostController {

    @Autowired
    private PostService postService;

    @Autowired
    private TwitterService twitterService;

    @PostMapping(consumes = APPLICATION_JSON_VALUE)
    public Object post(HttpEntity<String> httpEntity, HttpServletRequest request) throws ParseException, InterruptedException, ExecutionException, IOException {
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("key") == null){
            return new RedirectView("/login");
        }

        String json = httpEntity.getBody();
        JSONParser parser = new JSONParser();

        JSONObject jsonObject = (JSONObject) parser.parse(json);
        String googleId = (String) jsonObject.get("googleId");
        String text = (String) jsonObject.get("text");
        boolean twitter = (boolean) jsonObject.get("twitter");

        Post newPost = new Post();
        newPost.setText(text);
//        newPost.setTwitter(true);
        postService.save(newPost, googleId);

        if(twitter){
            twitterService.post((String) session.getAttribute("key"), text);
        }

        return new ResponseEntity<Void>(HttpStatus.CREATED);
    }
}