package com.lppz.back.servlet;

import com.lppz.back.db.MyUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.Collection;

@WebServlet("/aa.action")
@MultipartConfig
public class Sp extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf8");
        String spname = request.getParameter("spname");
      /*  Part p=request.getPart("file");
            String s="";
            if(!p.getSubmittedFileName().equals("")){
                p.write(getServletContext().getRealPath("upload/")+p.getSubmittedFileName());
                //out.print(getServletContext().getRealPath("upload/")+p.getSubmittedFileName());
                s=p.getSubmittedFileName();
                Mysl my=new Mysl();
                my.getPhoto(getServletContext().getRealPath("upload/")+p.getSubmittedFileName(),50,getServletContext().getRealPath("smallup/")+p.getSubmittedFileName());
                HttpSession session=request.getSession();
                session.setAttribute("os","http://localhost:8080/smallup/");
            }*/

        String bz = request.getParameter("bz");
        String cy = request.getParameter("cy");
        String spec = request.getParameter("spec");
        String pric = request.getParameter("pric");
        String pscore = request.getParameter("pscore");
        String pnum = request.getParameter("pnum");
        String cc = request.getParameter("modules");
        String on = "";
        // Dbutil db=new Dbutil();
        MyUtil db = new MyUtil();
        int i = db.insert("insert into goods values(null,?,'良品铺子',?,?,?,?,?,?,null,?,1)", new Object[]{spname, spec, bz, cy, pric, pscore, pnum, cc});
        //System.out.print(i);
        int m = 0;
        if (i > 0) {
            m = db.getid();
            on = "ok";
        } else {
            on = "no";
        }
        File f = new File(getServletContext().getRealPath("goodsgroup/"));
        if (!f.exists()) {
            f.mkdir();
        }

        Collection<Part> pp = request.getParts();
        int oo = 0;
        for (Part so : pp) {
            if (so.getHeader("content-type") == null) {
                continue;
            } else {
                if (!so.getSubmittedFileName().equals("")) {
                    so.write(getServletContext().getRealPath("goodsgroup/") + so.getSubmittedFileName());
                    oo = db.insert("insert into goodspic values(null,?,?)", new Object[]{so.getSubmittedFileName(), m});
                }
            }
        }
        if (oo > 0) {
            response.sendRedirect("back/add_shangpin.jsp?ok=" + on);
        } else {
            response.sendRedirect("back/add_shangpin.jsp?ok=" + on);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
