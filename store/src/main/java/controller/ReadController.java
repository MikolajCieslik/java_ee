package controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import dao.UserDAO;
import model.User;

@Controller
public class ReadController {
    @Autowired
    private UserDAO userDAO;

    @RequestMapping(value = "/read")
    public ModelAndView readUser(ModelAndView model) throws IOException{

        List<User> listUser = userDAO.read();
        model.addObject("listUser", listUser);
        model.setViewName("read");

        return model;
    }
}
