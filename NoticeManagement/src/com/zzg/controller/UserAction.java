package com.zzg.controller;
import com.google.gson.Gson;
import com.zzg.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.apache.shiro.subject.Subject;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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

    @RequestMapping("/showRegist")
    public String showRegist(){

        return "regist";

    }

    @RequestMapping("/getuserName")
    @ResponseBody
    public String getUserName(String username, Model model){


        Map userMap = userService.getUserName(username);

        if (userMap.get("USERNAME")!=null&&!userMap.get("USERNAME").equals("")){

            return "error";

        }

        return "success";

    }

    @RequestMapping("/registUser")
    @ResponseBody
    public String registUser(String userMessage,Model model){

        Map map = new Gson().fromJson(userMessage, Map.class);

        String uuid = UUID.randomUUID().toString();

        uuid.replaceAll("-", "");

        map.put("ID", uuid);

        try {

            userService.registUser(map);

            return "success";

        }catch (Exception e){

            e.printStackTrace();

            return "error";

        }

    }

    @RequestMapping("/login")
    @ResponseBody
    public String login(String userName, String passWord, HttpSession session) {

        Subject subject=SecurityUtils.getSubject();

        AuthenticationToken token=new UsernamePasswordToken(userName,passWord);

        try{

            subject.login(token);

            Map userMap = (Map)subject.getPrincipal();

            session.setAttribute("loginUser",userMap);


        }catch (Exception e){

           // e.printStackTrace();

            return "error";

        }

        //可以不用写这个返回值 因为在xml中配置了 成功后返回的页面
        return  "success";//redirect:/user/print.action

    }

    @RequestMapping("/getUsers")
    @ResponseBody
    public Map getUsers(){

        List userList=userService.getUsers();


        Map resMap=new HashMap();

        resMap.put("userList",userList);

        return resMap;
    }

    @RequestMapping("/permissions")
    @ResponseBody
    public String givePer(String checkStr){

        userService.givePer(checkStr);

        return "success";

    }

    @RequestMapping("/logout")
    public  String logOut(HttpSession session){

        //清除session
        session.removeAttribute("loginUser");

        return "Login";

    }
    @RequestMapping("checkPass")
    @ResponseBody
    public  String checkPass(String oldPass,HttpSession session ){


        Map userMap = (Map)session.getAttribute("loginUser");

        Map uMap = userService.getUserName((String) userMap.get("USERNAME"));

        String password=(String) uMap.get("PASSWORD");

        if (oldPass!=null&&!password.equals(oldPass)){

            return "error";

        }

        return "success";

    }

    @RequestMapping("/updatePass")
    @ResponseBody
    public String updatePass(String newPass,HttpSession session){

        Map userMap = (Map)session.getAttribute("loginUser");

        userMap.put("PASSWORD",newPass);

        userService.updatePass(userMap);

        return "success";
    }


}
