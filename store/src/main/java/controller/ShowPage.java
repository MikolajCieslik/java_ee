package controller;

import javax.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import model.User;

@Controller
@RequestMapping(value = "wyswietl")
public class ShowPage {

    @RequestMapping(method = RequestMethod.GET, params = "nowy")
    public String viewNewForm(Model model){
        model.addAttribute("user",new User());
        return "show";
    }

    @RequestMapping(method = RequestMethod.GET)
    public String viewForm(Model model) {
        model.addAttribute("user", new User( "Michał", "Jędrzejewski"));
        return "show";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String postThis(@Valid User user, BindingResult br){
        System.out.println(user.toString());
        return  "show";
    }
}
