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


@WebServlet("/addlunbo.action") @MultipartConfig
public class Addlunbo extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      //  String name= req.getParameter("name");
        req.setCharacterEncoding("utf8");
        resp.setContentType("text/html;charset=utf8");
        String byname = req.getParameter("byname");
        String s = req.getParameter("statu");
        MyUtil mu = new MyUtil();
        Part uf = req.getPart("file");
        //接单个文件文件
        String name = uf.getSubmittedFileName();
        String pa = getServletContext().getRealPath("/lunbo1");
        String pa1 = getServletContext().getRealPath("/lunbo");
        String pa2= getServletContext().getRealPath("/suolun");
        File f = new File(pa);
        File f1 = new File(pa2);
        File f2 = new File(pa1);
        if(!f2.exists()){
            f2.mkdir();
        }
        if(!f1.exists()){
            f1.mkdir();
        }
        if(!f.exists()){
            f.mkdir();
        }
        String ext="";
        String name1="";
        ImgUtil im = new ImgUtil();
        if(!uf.getSubmittedFileName().equals("")) {
            ext = uf.getSubmittedFileName().substring(uf.getSubmittedFileName().lastIndexOf("."));
            name1 = UUID.randomUUID().toString()+ext;
            if (".jpg".equalsIgnoreCase(ext)||".png".equalsIgnoreCase(ext)) {
                uf.write(getServletContext().getRealPath("/lunbo1/") + name1);
                im.thumb(getServletContext().getRealPath("/lunbo1/") + name1,800,getServletContext().getRealPath("/lunbo/") + name1);
                int i = mu.insert("insert into lunbo values(null,?,?,?)",new Object[]{name1,byname,s});
                req.getSession().setAttribute("aa","添加成功,是否继续添加?");
            }else {
                req.getSession().setAttribute("aa","添加失败，文件格式不支持,是否继续添加?");
            }
        }else {
            req.getSession().setAttribute("aa","文件名不能为空,是否继续添加?");
        }

        im.thumb(getServletContext().getRealPath("/lunbo/") + name1,60,getServletContext().getRealPath("/suolun/")+name1);


        resp.sendRedirect("back/addlunbo.jsp");
    }
}
