package com.lppz.back.servlet;




import com.lppz.back.db.MyUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/message.action")
public class Message extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        MyUtil mu = new MyUtil();
        String n = req.getParameter("na");
        String time= req.getParameter("date");
        String content = req.getParameter("content");
        int t = mu.insert("insert into message (name,time,econtent) values(?,?,?)",new Object[]{n,time,content});
        if(t>0){
            resp.sendRedirect("back/edit.jsp?do=\"ok\"");
        }else {
            resp.sendRedirect("back/edit.jsp?do=\"no\"");
        }

    }
}
