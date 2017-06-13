package com.lppz.user;

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


@WebServlet("/saveaddr")
public class SaveAddr extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        String user = req.getParameter("username");
        String name = req.getParameter("consignee");
        String province = req.getParameter("province");
        String city = req.getParameter("city");
        String area = req.getParameter("area");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        int id = 0;
        PrintWriter out = resp.getWriter();
        DBOP db = new DBOP();
        List<Map<String,Object>> list= db.Query("id","user_info","where username='"+user+"'");
        for(Map<String,Object> map : list){
             id = (int) map.get("id");
        }
        Object[] p = new Object[]{name,province,city,area,address,phone,id};
        int result = db.insert("insert into address values(null,?,?,?,?,?,?,?)",p);
        if(result>0){
            out.print("保存成功");
        }else{
            out.print("保存失败");
        }
    }
}
