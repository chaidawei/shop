package com.lppz.shopcar;

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


@WebServlet("/loadlist")
public class Order extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        String items = req.getParameter("ids");
        DBOP db = new DBOP();
        String id ="";
        String[] ids;
        StringBuilder sbr = new StringBuilder();
        PrintWriter out = resp.getWriter();
        if(items.indexOf(",")!=-1){
             ids = items.split(",");
             for(int i = 0 ; i<ids.length;i++){
                String imgName = (String) db.queryBy("pname","goodspic","where goodspic.go_id="+ids[i]);
                List<Map<String,Object>> list = db.Query("goods.id,goods.gname,goods.gprice,num,ordmny","goods,`order`","where goods.id=`order`.go_id and `order`.go_id = "+ids[i]);
                createLabel(sbr,list,imgName);
             }
        }else{
            id=items;
            String imgName = (String) db.queryBy("pname","goodspic","where goodspic.go_id="+id);
            List<Map<String,Object>> list = db.Query("goods.id,goods.gname,goods.gprice,num,ordmny","goods,`order`","where goods.id=`order`.go_id and `order`.go_id = "+id);
            createLabel(sbr,list,imgName);
        }
        out.print(sbr);

    }

    private void createLabel(StringBuilder sbr,List<Map<String,Object>> list,String imgName){
        for (Map<String,Object> map : list){
            sbr.append("<input type=\"hidden\" name=\"quantitys\" value=\""+map.get("num")+"\" />");
            sbr.append("<input type=\"hidden\" name=\"cartItemId\" value=\""+map.get("id")+"\" />");
            sbr.append("<input type=\"hidden\" name=\"productPrice\" value=\""+map.get("gprice")+"\" />");

            sbr.append("<tr><td>");
            sbr.append("<a href=\"../product/list.jsp?id="+map.get("id")+"\" class=\"pic\" target=\"_blank\">");
            sbr.append("<img src=\"../goodsgroup/"+imgName+"\" alt=\""+map.get("gname")+"\">");
            sbr.append("</a></td><td>");
            sbr.append("<div class=\"name\">");
            sbr.append("<a href=\""+map.get("id")+"\" title=\""+map.get("gname")+"\" target=\"_blank\">"+map.get("gname")+"</a>");
            sbr.append("</div>");
            sbr.append("<div class=\"cdc-list\"></div><div class=\"belt-list\"></div></td>");
            sbr.append("<td>--</td>");
            sbr.append("<td>￥"+map.get("gprice")+"</td>");
            sbr.append("<td>"+map.get("num")+"</td>");
            sbr.append("<td>￥"+map.get("ordmny")+"</td></tr>");
        }
    }
}
