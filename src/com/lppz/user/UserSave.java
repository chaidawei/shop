package com.lppz.user;

import com.lppz.db.DBOP;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/savedata")
public class UserSave extends HttpServlet{
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        String username = req.getParameter("username");
        String uname = req.getParameter("uname");
        String realname = req.getParameter("realname");
        String gender = req.getParameter("gender");
        String birthday = req.getParameter("birthday");

        DBOP db = new DBOP();
        int result = db.update("update user_info set uname='"+uname+"',realname='"+realname+"',gender='"+gender+"',birthday='"+birthday+"' where username='"+username+"'");
        PrintWriter out = resp.getWriter();
        if(result>0){
            out.print("保存成功");
        }else{
            out.print("保存失败");
        }

        out.flush();
        out.close();
    }
}
