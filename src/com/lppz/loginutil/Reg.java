package com.lppz.loginutil;

import com.lppz.back.db.MyUtil;
import com.lppz.db.DBOP;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;


@WebServlet("/reg")
public class Reg extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        resp.setCharacterEncoding("utf-8");
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

            String username = req.getParameter("username");
            String password = req.getParameter("password");

            DBOP db = new DBOP();
            int n = db.allCount("user_info","where username='"+username+"'");
            if(n>0){
                out.print("false");
            }
            if("reg".equals(action)){
                String date = new SimpleDateFormat("YYYY-MM-dd").format(new Date());
                MyUtil mu = new MyUtil();
                String hashPass = mu.getpass(password,username);
                int isInsert = db.insert("insert into user_info(username,password,uname,ustime) values(?,?,?,?)",new Object[]{username,hashPass,username,date});
                if(isInsert > 0){
                    out.print("注册成功");
                }
        }

        out.flush();
        out.close();
    }
}
