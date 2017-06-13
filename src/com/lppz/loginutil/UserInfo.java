package com.lppz.loginutil;

import com.alibaba.fastjson.JSONObject;
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


@WebServlet("/userinfo")
public class UserInfo extends HttpServlet{
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        String user = req.getParameter("username");
        DBOP db = new DBOP();
        List<Map<String,Object>> list = db.Query("uname,realname,gender,birthday","user_info","where username='"+user+"'");
        PrintWriter out = resp.getWriter();
        out.print(JSONObject.toJSONString(list));
        out.flush();
        out.close();
    }
}
