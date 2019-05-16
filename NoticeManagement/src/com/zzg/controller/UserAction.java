package com.zzg.controller;

import com.zzg.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.apache.shiro.subject.Subject;
import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserAction {

    @Autowired
    private UserService userService;

    @RequestMapping("/home")
    public String showLogin(){

        return "Login";
    }

    @RequestMapping("/print")
    public String printStu(){


        return "print";

    }

    @RequestMapping("/login")
    public String login(String userName, String passWord, HttpSession session) {

        Subject subject=SecurityUtils.getSubject();


        AuthenticationToken token=new UsernamePasswordToken(userName,passWord);


        try{

            subject.login(token);

            Map userMap = (Map)subject.getPrincipal();

            session.setAttribute("loginUser",userMap);

        }catch (Exception e){

            e.printStackTrace();

            return "Login";


        }

        //可以不用写这个返回值 因为在xml中配置了 成功后返回的页面
        return  "redirect:/user/print.action";

    }

}
