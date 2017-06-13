package com.lppz.shopcar;

import com.lppz.db.DBOP;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;


@WebServlet("/create")
public class CreateOrder extends HttpServlet{
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String userId = req.getParameter("userId");
        String addrId = req.getParameter("receiverId");
        String cartItems = req.getParameter("cartItems");

        String[] quantitys = req.getParameterValues("quantitys");
        String[] prices = req.getParameterValues("productPrice");
        Random r = new Random();
        String count =""+r.nextInt(9)+r.nextInt(9)+r.nextInt(9)+r.nextInt(9);
        String number = "DW"+ new SimpleDateFormat("yyyyMMdd").format(new Date())+count;
        double money = 0;
        for(int p = 0 ;p<prices.length;p++){
            money+=Double.parseDouble(prices[p])*Integer.parseInt(quantitys[p]);
        }
        //System.out.println(userId);
        Object [] obj = new Object[]{number,money+10,new SimpleDateFormat("yyyy-MM-dd HH-mm-ss").format(new Date()),userId,cartItems,addrId};
        DBOP db = new DBOP();
        int result = db.insert("insert into order_info values(null,?,?,?,?,?,?,1)",obj);
        if(result>0){
            out.print("{\"type\":\"success\"}");
        }else{
            out.print("{\"type\":\"field\"}");
        }
    }
}
