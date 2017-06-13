package com.lppz.code;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by Lxy on 2017/5/18.
 */
@WebServlet("/checkcode")
public class CheckCode extends HttpServlet{
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = (String) req.getSession().getAttribute("code");
        String inCode = req.getParameter("data");

        PrintWriter out = resp.getWriter();
        if(code.equalsIgnoreCase(inCode)){
            out.print("true");
        }else{
            out.print("false");
        }

        out.flush();
        out.close();
    }
}
