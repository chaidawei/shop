package com.lppz.back.servlet;
import com.lppz.back.db.MyUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
@WebServlet("/Xg.action") @MultipartConfig
public class Xg extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         request.setCharacterEncoding("utf-8");
         response.setCharacterEncoding("utf-8");
         response.setContentType("text;html;charset=utf-8");
        PrintWriter out=response.getWriter();
        HttpSession session=request.getSession();
           Object o=session.getAttribute("my");
     String pname=request.getParameter("pname");
      String cc=request.getParameter("cc");
      String pric=request.getParameter("pric");
        String num= request.getParameter("num");
        String statu = request.getParameter("st");
        MyUtil mu = new MyUtil();
        String sql=String.format("update goods set gname='"+pname+"',c_id='"+cc+"',gprice='"+pric+"',gnum='"+num+"',statu='"+statu+"' where id='"+o+"'");
       try {
           PreparedStatement pre=mu.getConn().prepareStatement(sql);
           int i=pre.executeUpdate();
           if(i>0){
               response.sendRedirect("back/shangpin.jsp");
           }
       }catch (Exception e){
           e.printStackTrace();
       }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
