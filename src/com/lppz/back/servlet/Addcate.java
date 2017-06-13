package com.lppz.back.servlet;

import com.lppz.back.db.MyUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/addcate.action")
public class Addcate extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf8");
        resp.setCharacterEncoding("utf8");
        resp.setContentType("text/html;charset=utf8");
        PrintWriter out =resp.getWriter();
        MyUtil mu = new MyUtil();
        String id = req.getParameter("i");
        String name = req.getParameter("nam");
        int i =mu.insert("insert into cate values(null,?,?)",new Object[]{name,id});
        if(i>0){
            out.print("添加成功，是否继续添加？");
        }else {
            out.print("添加失败，错误未知，是否继续添加？");
        }



        out.flush();
        out.close();
    }
}
