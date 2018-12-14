package elec5619.group3.besocialos.web;

import elec5619.group3.besocialos.service.LinkedInService;
import elec5619.group3.besocialos.service.TwitterService;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Controller
@RequestMapping("/linkedIn")
public class LinkedInController {
    @Autowired
    LinkedInService linkedInService;

    @GetMapping("/login")
    public String login() throws InterruptedException, ExecutionException, IOException {
        return "redirect:" + linkedInService.getLoginURL();
    }

    @GetMapping("/callback")
    public String loginCallback(@RequestParam("code") String code,
                              HttpServletRequest request)
            throws InterruptedException, ExecutionException, IOException, ParseException {
        linkedInService.authorize(code, (String) request.getSession(false).getAttribute("key"));
        return "redirect:/";
    }

    @GetMapping("/activities")
    public String activities(HttpServletRequest request, Model model)
            throws InterruptedException, ExecutionException, IOException, ParseException {
        List<Map<String, String>> activities = linkedInService.getActivities((String) request.getSession(false).getAttribute("key"));
        model.addAttribute("activities", activities);
        System.out.println(activities);
        return "linkedInActivities";
    }
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        linkedInService.logout((String) request.getSession(false).getAttribute("key"));
        return "redirect:/";
    }

}
