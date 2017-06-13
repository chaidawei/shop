package com.lppz.back.servlet;

import com.lppz.back.db.MyUtil;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

@WebServlet("/del.action")
public class Delete extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String d = req.getParameter("do");
        MyUtil mu = new MyUtil();
        if ("lunbo".equals(d)) {
            String i = req.getParameter("id");
            String p = req.getParameter("p");
            mu.deleteById("lunbo", i);
            String name=req.getParameter("path");
            String lunbopath = req.getServletContext().getRealPath("/lunbo/")+name;
            String soulunpath=req.getServletContext().getRealPath("/suolun/")+name;
            String lunbo1path=req.getServletContext().getRealPath("/lunbo1/")+name;
            File f = new File(lunbopath);
            File f1 = new File(soulunpath);
            File f2 = new File(lunbo1path);
            /*if(f.exists()){
                f.delete();
            }
            if(f1.exists()){
                f1.delete();
            }
            if(f2.exists()){
                f2.delete();
            }*/
            del(f);
            del(f1);
            del(f2);
            resp.sendRedirect("back/lunbo.jsp?p=" + p);
        }

        if("bigcate".equals(d)){
            String i = req.getParameter("id");
            String p = req.getParameter("p");
            String name= req.getParameter("path");
            String path = req.getServletContext().getRealPath("/bigcate_upload/")+name;
            String path2 = req.getServletContext().getRealPath("/bigcate_upload2/")+name;
            File f = new File(path);
            File f1 = new File(path2);
            del(f);
            del(f1);
            mu.delete("cate","where b_id="+i);
            mu.deleteById("bigcate",i);
            resp.sendRedirect("back/bigcate.jsp?p="+p);
        }
        if("cate".equals(d)){
            String i = req.getParameter("id");
            String p = req.getParameter("p");
            mu.deleteById("cate",i);
            resp.sendRedirect("back/cate.jsp?p="+p);
        }
        if("member".equals(d)){
            String id = req.getParameter("id");
            String p = req.getParameter("p");
            mu.deleteById("user_info",id);
            resp.sendRedirect("back/member.jsp?p="+p);
        }
        if("order_info".equals(d)){
            String id = req.getParameter("id");
            String p = req.getParameter("p");
            mu.deleteById("order_info",id);
            resp.sendRedirect("back/order.jsp?p="+p);
        }
        if("message".equals(d.trim())){
            String id = req.getParameter("id");
            String p = req.getParameter("p");
            mu.deleteById("message",id);
            resp.sendRedirect("back/message.jsp?p="+p);
        }

    }
    public void del(File f){
        if(f.exists()){
            f.delete();
        }
    }
}
