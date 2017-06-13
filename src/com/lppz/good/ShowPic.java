package com.lppz.good;


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


@WebServlet("/showpic")
public class ShowPic extends HttpServlet{
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String id = req.getParameter("gid");
        String action = req.getParameter("action");
        PrintWriter out = resp.getWriter();
        DBOP db = new DBOP();
        if("img".equalsIgnoreCase(action)){
            List<Map<String,Object>> list =  db.Query("pname","goodspic","where goodspic.go_id="+id);
            StringBuilder sbr = new StringBuilder();

            for(int i=0;i<list.size();i++){
                if (i == 0) {
                    sbr.append("<li class=\"current curr\" style=\"float: left; width: 72px;\">");
                    sbr.append("<img class=\"lazy img-hover\" alt=\"\" src=\"../goodsgroup/"+list.get(i).get("pname")+"\"  large=\"../goodsgroup/"+list.get(i).get("pname")+"\" width=\"60\" height=\"60\" style=\"display: inline;\">");
                    sbr.append("</li>");
                }
                if(i==list.size()-1){
                    sbr.append("<li class=\"curr\" style=\"float: left; width: 72px;\">");
                    sbr.append("<img class=\"lazy img-hover\" alt=\"\" src=\"../goodsgroup/"+list.get(i).get("pname")+"\"  large=\"../goodsgroup/"+list.get(i).get("pname")+"\" width=\"60\" height=\"60\" style=\"display: inline;\">");
                    sbr.append("</li>");
                }
                sbr.append("<li style=\"float: left; width: 72px;\">");
                sbr.append("<img class=\"lazy img-hover\" alt=\"\" src=\"../goodsgroup/"+list.get(i).get("pname")+"\"  large=\"../goodsgroup/"+list.get(i).get("pname")+"\" width=\"60\" height=\"60\" style=\"display: inline;\">");
                sbr.append("</li>");

            }
            out.print(sbr);
        }
        if("bigimg".equalsIgnoreCase(action)){
            out.print("../goodsgroup/"+db.queryBy("pname","goodspic","where goodspic.go_id="+id));
        }
        out.flush();
        out.close();
    }
}
