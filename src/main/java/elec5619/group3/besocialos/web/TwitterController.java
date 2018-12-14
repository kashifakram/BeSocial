package elec5619.group3.besocialos.web;

import elec5619.group3.besocialos.service.TwitterService;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Controller
@RequestMapping("/twitter")
public class TwitterController {
    @Autowired
    TwitterService twitterService;

    @GetMapping("/login")
    public String login() throws InterruptedException, ExecutionException, IOException {
        return "redirect:" + twitterService.getLoginURL();
    }

    @GetMapping("/callback")
    public String loginCallback(@RequestParam("oauth_token") String token,
                              @RequestParam("oauth_verifier") String verifier,
                              HttpServletRequest request)
            throws InterruptedException, ExecutionException, IOException, ParseException {
        twitterService.authorize(token, verifier, (String) request.getSession(false).getAttribute("key"));
        return "redirect:/";
    }

    @GetMapping("/timeline")
    public String timeline(HttpServletRequest request, Model model)
            throws InterruptedException, ExecutionException, IOException, ParseException {
        List<Map<String, String>> timeline = twitterService.getTimeLine((String) request.getSession(false).getAttribute("key"));
        model.addAttribute("timeline", timeline);
        System.out.println(timeline);
        return "twitterTimeline";
    }
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        twitterService.logout((String) request.getSession(false).getAttribute("key"));
        return "redirect:/";
    }

}
