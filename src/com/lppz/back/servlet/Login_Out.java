package com.lppz.back.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/loginout.action")
public class Login_Out extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (req.getSession().getAttribute("account")!=null){
            req.getSession().removeAttribute("account");
            resp.sendRedirect("back/login.jsp");
        }else {
            resp.sendRedirect("back/login.jsp");
        }
    }
}
