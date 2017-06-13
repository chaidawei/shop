package com.lppz.good;

import com.alibaba.fastjson.JSON;
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


@WebServlet("/showgood")
public class ShowGood extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        String id = req.getParameter("id");
        DBOP db = new DBOP();
        List<Map<String,Object>> list =  db.Query("id,gname,gprice","goods","where statu=1 and id="+id);

        PrintWriter out = resp.getWriter();
        out.print(JSONObject.toJSONString(list));
        out.flush();
        out.close();
    }

    public static String GetKey(List<String> l){
        for (String key : l) {
           if(key.length()>0){
               return key;
           }
        }
        return "";
    }
}
