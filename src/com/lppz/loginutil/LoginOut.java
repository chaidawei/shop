package com.lppz.loginutil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/loginOut")
public class LoginOut extends HttpServlet{
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = (String) req.getSession().getAttribute("username");
        if(username != null){
            req.getSession().removeAttribute("username");
            resp.sendRedirect("login/login.html");
        }else{
            resp.sendRedirect("login/login.html");
        }
    }
}
