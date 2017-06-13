package com.lppz.user;

import com.alibaba.fastjson.JSONObject;
import com.lppz.db.DBOP;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/showaddr")
public class ShowAddr extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        String user = req.getParameter("username");
        String action = req.getParameter("action");
        DBOP db = new DBOP();
        int id=0;
        List<Map<String,Object>> listId = db.Query("id","user_info","where username='"+user+"'");
        for (Map<String,Object> map : listId) {
            id= (int) map.get("id");
        }
        StringBuilder sbr;
        List<Map<String,Object>> lt = new ArrayList<>();
        Map<String,Object> mapss = new HashMap<>();
        String receiverAddr = null;
        String showconsignee = null;
        int addrid =0;
        List<Map<String,Object>> list = db.Query("address.id as addrid,name,province,city,area,address,address.phone","user_info,address","where address.us_id=user_info.id and address.us_id="+id);
        if(!"oaddr".equalsIgnoreCase(action)){
            sbr = new StringBuilder();
            for (Map<String,Object> map : list) {
                sbr.append("<div class=\"addr-item\" id=\""+id+"\">");
                sbr.append("<div class=\"addr-info\">");
                sbr.append("<dl>");
                sbr.append("<dt>"+map.get("name")+"</dt>");
                sbr.append("<dd><div class=\"lab\">收&nbsp;&nbsp;货&nbsp;&nbsp;人：</div><div class=\"intr\">"+map.get("name")+"</div></dd>");
                sbr.append("<dd><div class=\"lab\">所在地区：</div><div class=\"intr\">"+map.get("province")+map.get("city")+map.get("area")+"</div></dd>");
                sbr.append("<dd><div class=\"lab\">地　　址：</div><div class=\"intr\">"+map.get("address")+"</div></dd>");
                sbr.append("<dd><div class=\"lab\">手　　机：</div><div class=\"intr\">"+map.get("phone")+"</div></dd>");
                sbr.append("</dl>");
                sbr.append("</div>");
                sbr.append("<a href=\"javascript:void(0)\" receiverId=\""+map.get("addrid")+"\" id=\"addr-del\">删除</a>");
                sbr.append("</div>");
            }
        }else{
            sbr = new StringBuilder();
            int i = 0;
//            if(list.size()==0){
//                req.getSession().removeAttribute("addrId");
//            }
            for (Map<String,Object> map : list) {
                if(i==0){
                    sbr.append("<li class=\"myadd current\" id=\""+map.get("addrid")+"\" receiverid=\""+map.get("addrid")+"\" showreceiver=\""+map.get("province")+map.get("city")+map.get("area")+map.get("address")+"\" showconsignee=\""+map.get("name")+" "+map.get("phone")+"\">");
//                    req.getSession().setAttribute("addrId",map.get("addrid"));
                    receiverAddr =""+map.get("province")+map.get("city")+map.get("area")+" "+map.get("address");
                    showconsignee = ""+map.get("name")+" "+map.get("phone");
                    addrid = (int) map.get("addrid");

                    mapss.put("receiverAddr",receiverAddr);
                    mapss.put("showconsignee",showconsignee);
                    mapss.put("id",addrid);
                    mapss.put("user",id);
                }else{
                    sbr.append("<li class=\"myadd\" id=\""+map.get("addrid")+"\" receiverid=\""+map.get("addrid")+"\" showreceiver=\""+map.get("province")+map.get("city")+map.get("area")+map.get("address")+"\" showconsignee=\""+map.get("name")+" "+map.get("phone")+"\">");
                }
                sbr.append("<dl name=\""+map.get("addrid")+"\">");
                sbr.append("<dt><span class=\"tit\">"+map.get("name")+"</span></dt>");
                sbr.append("<dd>"+map.get("phone")+"<br>"+map.get("province")+map.get("city")+map.get("area")+"<br>"+map.get("address")+"</dd>");
                sbr.append("<dd class=\"ubtn\">");
                sbr.append("<b class=\"del\" onclick=\"del("+map.get("addrid")+")\">删除</b>");
                sbr.append("</dd>");
                sbr.append("</dl></li>");
                i++;
            }
        }



        mapss.put("addrInfo",sbr);

        lt.add(mapss);
        //写入输出流
        PrintWriter out = resp.getWriter();
        out.print(JSONObject.toJSONString(lt));
        out.flush();
        out.close();
    }

}
