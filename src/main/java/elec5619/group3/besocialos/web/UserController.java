package elec5619.group3.besocialos.web;

import elec5619.group3.besocialos.service.CipherService;
import elec5619.group3.besocialos.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping(value="/")
public class UserController {
    @Autowired
    UserService userService;

    @Autowired
    CipherService cipherService;

    @GetMapping
    public String index(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        if(session == null){
            return "redirect:/login";
        }
        List<String> flags = userService.getSocialFlags(
                cipherService.decrypt((String)session.getAttribute("key")));
        model.addAttribute("flags", flags);
        System.out.println(flags);
        return "index";
    }

    @GetMapping("login")
    public String login(HttpServletRequest request) {
        if(request.getSession(false) != null){
            System.out.println("Login: session id: " + request.getSession(false).getId());
        }
        return "login";
    }

    @GetMapping("logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login";
    }

}