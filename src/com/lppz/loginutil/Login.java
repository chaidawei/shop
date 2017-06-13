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
import java.util.List;
import java.util.Map;



@WebServlet("/login")
public class Login extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //用户名
        MyUtil mu = new MyUtil();
        String user = req.getParameter("username");
        String password = req.getParameter("password");
        String pwd = mu.getpass(password,user);
        //用户昵称
        String uname ="";
        String action = req.getParameter("action");
        PrintWriter out = resp.getWriter();

        DBOP db = new DBOP();
        int n = db.allCount("user_info","where username='"+user+"' and password='"+pwd+"'");
//        int sock = db.allCount("user_info","where username='"+user+"' and password='"+pwd+"' where statu=1");
        List<Map<String,Object>> list  = db.Query("uname","user_info","where username='"+user+"'");
            for (Map<String,Object> map : list) {
                uname = (String) map.get("uname");
            }
//        if("person".equals(action)){
            req.getSession().setAttribute("u",user);
//        }
        req.getSession().setAttribute("username",uname);
        out.print(n);
        out.flush();
        out.close();
    }
}
