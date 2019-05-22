package com.zzg.controller.filter;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {

        HttpSession session=httpServletRequest.getSession();

        String url = httpServletRequest.getRequestURL().toString();

        Map userMap = (Map)session.getAttribute("loginUser");

        if (userMap==null){

           // httpServletRequest.getRequestDispatcher("user/home.action").forward(httpServletRequest,httpServletResponse);

            httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/user/home.action");


            return false;

        }

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }

}
