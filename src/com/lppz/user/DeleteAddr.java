package com.lppz.user;

import com.lppz.db.DBOP;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/deladdr")
public class DeleteAddr extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf8");
        resp.setContentType("text/html;charset=utf8");
        resp.setCharacterEncoding("utf8");
        String id = req.getParameter("id");
        PrintWriter out = resp.getWriter();

        DBOP db = new DBOP();
        int result = db.insert("delete from address where id=?",new Object[]{id});
        if(result>0){
            out.print("删除成功");
        }
        out.flush();
        out.close();
    }
}
