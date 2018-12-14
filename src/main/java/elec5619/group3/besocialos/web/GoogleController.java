package elec5619.group3.besocialos.web;

import elec5619.group3.besocialos.service.GoogleService;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.concurrent.ExecutionException;

@Controller
@RequestMapping("/google")
public class GoogleController {
    @Autowired
    GoogleService googleService;

    @GetMapping("/login")
    public String login(HttpServletRequest request) {
        if(request.getSession(false) != null){
            System.out.println("Google Login: session id: " + request.getSession(false).getId());
        }
        return "redirect:" + googleService.getLoginURL();
    }

    @GetMapping("/callback")
    public String loginCallback(@RequestParam("code") String code, HttpServletRequest request) throws InterruptedException, ExecutionException, ParseException, IOException {
        String key = googleService.authorize(code);
        System.out.println("Google callback: session id: " + request.getSession(false).getId());
        request.getSession().setAttribute("key", key);
        return "redirect:/";
    }
}