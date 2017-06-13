package com.lppz.back.servlet;

import com.lppz.back.db.MyUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/login.action")
public class Login extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf8");
        String a = req.getParameter("account");
        String p = req.getParameter("pass");
        MyUtil mu = new MyUtil();
       if(mu.exists("vip","where account ='"+a+"'")){
           if(mu.queryBy("vip","pass","where account='"+a+"'").toString().equals(p)){
            req.getSession().setAttribute("account",a);
               resp.sendRedirect("back/index.jsp");
          }else {
               resp.sendRedirect("back/login.jsp");
           }
       }else {
           resp.sendRedirect("back/login.jsp");
       }
    }
}
