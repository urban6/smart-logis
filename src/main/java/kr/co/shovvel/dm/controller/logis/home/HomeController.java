package kr.co.shovvel.dm.controller.logis.home;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping(value = "/user/home")
public class HomeController {

    @RequestMapping(value = "/home")
    public ModelAndView home(HttpServletResponse response, HttpServletRequest request, Model model) {
        response.setHeader("Cache-Control", "no-cache");

        ModelAndView mav = new ModelAndView();
        mav.setViewName("logis/home/home");
        return mav;
    }
}
