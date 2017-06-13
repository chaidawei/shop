package com.lppz.back.servlet;

import com.lppz.back.db.ImgUtil;
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
import java.util.UUID;


@WebServlet("/addbigcate") @MultipartConfig
public class Addbigcate extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf8");
        resp.setCharacterEncoding("utf8");
        resp.setContentType("text/html;charset=utf8");
        String cate = req.getParameter("name");
        MyUtil mu = new MyUtil();
        ImgUtil im = new ImgUtil();
        String a = getServletContext().getRealPath("bigcate_upload");
        String a2 = getServletContext().getRealPath("bigcate_upload2");
        File f = new File(a);
        File f2 = new File(a2);
        Part uf = req.getPart("file");
        String name ="";
        if(!f.exists()){
            f.mkdir();
        } if(!f2.exists()){
            f2.mkdir();
        }
        String n = uf.getSubmittedFileName();
        if(!"".equals(n)) {
            String ext = uf.getSubmittedFileName().substring(uf.getSubmittedFileName().lastIndexOf("."));
           name = UUID.randomUUID() + ext;
            if (!"".equals(cate)) {
                if(".jpg".equals(ext)||".png".equals(ext)) {
                    int i = mu.insert("insert into bigcate values(null,?,?)", new Object[]{cate, name});
                    if (i >= 1) {
                        uf.write(a + "/" + name);
                        im.thumb(a + "/" + name, 50, a2 + "/" + name);
                        req.getSession().setAttribute("bigcate", "ok");
                    } else {
                        req.getSession().setAttribute("bigcate", "no");
                    }
                }else {
                    req.getSession().setAttribute("bigcate", "wrong");
                }
            } else {
                req.getSession().setAttribute("bigcate", "empty");
            }
        }else {
            req.getSession().setAttribute("bigcate","fempty");
        }
       // System.out.println(req.getSession().getAttribute("bigcate"));
       resp.sendRedirect("back/addbigcate.jsp");

    }
}
