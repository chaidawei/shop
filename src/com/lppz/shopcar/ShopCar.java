package com.lppz.shopcar;

import com.lppz.db.DBOP;
import org.omg.DynamicAny._DynAnyFactoryStub;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;


@WebServlet("/car")
public class ShopCar extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        PrintWriter out = resp.getWriter();
        DBOP db = new DBOP();
        int userId = 0;
        String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        if ("query".equalsIgnoreCase(action)) {
            String user = req.getParameter("username");
            List<Map<String, Object>> Id = db.Query("id", "user_info", "where username='" + user + "'");

            for (Map<String, Object> map : Id) {
                userId = (int) map.get("id");
            }
            //查询
            List<Map<String, Object>> list = db.Query("goods.id,gname,gprice,num,ordmny", "`order`,goods,user_info", "where goods.id=`order`.go_id and `order`.us_id=user_info.id and `order`.us_id=" + userId);
            StringBuilder sbr = new StringBuilder();
            if (list.size() == 0) {
                sbr.append("<p class=\"go-stroll\"><a href=\"../index.jsp\">您的购物车是空的，立即去商城逛逛</a></p>");
            } else {
                sbr.append("<div class=\"cart-area\">");
                sbr.append("<table><tbody><tr><th width=\"18\"><input type=\"checkbox\" class=\"allselect\" checked=\"\">&nbsp;</th><th class=\"cent\" width=\"60\">全选</th><th>商品名称</th><th width=\"80\">单价</th><th width=\"60\">数量</th><th width=\"100\">小计</th><th width=\"90\">操作</th></tr>");
                double totalPrice =0;
                for (Map<String, Object> maps : list) {
                    int id = (int) maps.get("id");
                    double om= (double) maps.get("ordmny");
                    totalPrice +=om;
                    String imgName = (String) db.queryBy("pname","goods,goodspic","where goods.id = goodspic.go_id and goods.id="+id);
                    String name = (String) maps.get("gname");
                    sbr.append("<tr class=\"\"><td>");
                    sbr.append("<input type=\"checkbox\" value=\"" + id + "\" itemid=\"" + id + "\" checked=\"\">");
                    sbr.append("</td><td>");
                    sbr.append("<input type=\"hidden\" name=\"id\" value=\"" + id + "\">");
                    sbr.append("<a href=\"../product/list.jsp?id=" + id + "\" class=\"pic\" target=\"_blank\"><img src=\"../goodsgroup/"+imgName+"\" alt=\"" + name + "\"></a>");
                    sbr.append("</td><td class=\"commodity\">");
                    sbr.append("<a href=\"../product/list.jsp?id=" + id + "\" title=\"" + name + "\" target=\"_blank\">" + name + "</a>");
                    sbr.append("</td><td>￥" + maps.get("gprice") + "</td><td class=\"purchase quantity\">");
                    sbr.append("<div class=\"shoping-num\">");
                    sbr.append("<span class=\"decrease\">&nbsp;</span>");
                    sbr.append("<input type=\"text\" name=\"quantity\" value=\""+maps.get("num")+"\" oldvalue=\""+maps.get("num")+"\" maxlength=\"4\" onpaste=\"return false;\">");
                    sbr.append("<input type=\"hidden\" name=\"productCategory\" value=\"c51fe57124aa44978e9f0eec46240c0b\">");
                    sbr.append("<span class=\"increase\">&nbsp;</span></div></td>");
                    sbr.append("<td><span class=\"subtotal\"><b>￥" + maps.get("ordmny") + "</b></span></td>");
                    sbr.append("<td><a href=\"javascript:;\" class=\"delete\">删除</a><br></td></tr>");
                }
                sbr.append("</tbody></table>");
                sbr.append("<table class=\"order-pref\"><tbody></tbody></table>");
                sbr.append("<dl id=\"giftItems\" class=\"hidden\"></dl>");
                sbr.append("<div class=\"total\">");
                sbr.append("<div class=\"tot-op\">");
                sbr.append("<input type=\"checkbox\" class=\"allselect\" checked=\"\">&nbsp;&nbsp;全选");
                sbr.append("<a class=\"delete\" href=\"javascript:;\" name=\"deleteall\">删除</a>");
                sbr.append("<a class=\"continue\" href=\"../index.jsp\">继续购物</a>");
                sbr.append("</div></div>");
                sbr.append("<div class=\"bottom\">");
                sbr.append("<div class=\"clearing-area\">");
                sbr.append("<div class=\"ca-item amount\">商品金额: <strong id=\"effectivePrice\">￥<i>"+totalPrice+"</i></strong></div>");
                sbr.append("</div><div class=\"clearing-btn\">");
                sbr.append("<form id=\"toSettleCenter\" action=\"#\" method=\"post\"> ");
                sbr.append("<a href=\"javascript:;\" id=\"clear\" class=\"clear\" style=\"display:none\">清空购物车</a>");
                sbr.append("<a href=\"javascript:;\" id=\"submit\" class=\"submit\">结算</a>");
                sbr.append("<input type=\"hidden\" id=\"allSelect\" name=\"allSelect\">");
                sbr.append("<input type=\"hidden\" id=\"cartItems\" name=\"cartItems\">");
                sbr.append("</form></div></div></div>");
            }
            out.print(sbr);
        }
        if ("add".equalsIgnoreCase(action)) {
            String username = req.getParameter("user");
            String gid = req.getParameter("id");
            int num = Integer.parseInt(req.getParameter("num"));

            double price;
            price = (double) db.queryBy("gprice", "goods", "where id=" + gid);
            userId = (int) db.queryBy("id", "user_info", "where username='" + username + "'");
            int isInsert;
            int count = db.allCount("`order`","where `order`.go_id="+gid+"  and `order`.us_id="+userId);
            int addrCount = db.allCount("address","where us_id="+userId);
            int addrId = 0;
            if(addrCount>0){
                addrId = (int) db.queryBy("id","address","where us_id="+userId);
            }
            if(count>0){
//                Object[] param = new Object[]{num,price*num,date};
                isInsert = db.update("update `order` set num=num+"+num+",ordmny=ordmny+"+price*num+",date='"+date+"' where `order`.go_id="+gid+" and `order`.us_id="+userId);
            }else{
                if(addrId!=0){
                    isInsert = db.insert("insert into `order` values(null,?,?,?,?,?,?,1)", new Object[]{num, price * num, date, userId, gid,addrId});
                }else{
                    isInsert = db.insert("insert into `order` values(null,?,?,?,?,?,null,1)", new Object[]{num, price * num, date, userId, gid});
                }
            }
            if (isInsert > 0) {
                out.print("操作成功");
            } else {
                out.print("操作失败");
            }
        }
        if("count".equalsIgnoreCase(action)){
            String username = req.getParameter("username");
            userId = (int) db.queryBy("id", "user_info", "where username='" + username + "'");
            Object count = db.queryBy("count(*)","`order`,user_info","where `order`.us_id=user_info.id and `order`.us_id="+userId);
            out.print(count);
        }
        if("total".equalsIgnoreCase(action)){
            String id =req.getParameter("id");
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            double gprice = (double) db.queryBy("gprice","goods","where goods.id="+id);
            double total = gprice*quantity;
            int n = db.update("update `order` set num="+quantity+",ordmny="+total+",date='"+date+"' where `order`.go_id="+id);
            if(n>0){
                out.print("{\"type\":\"success\"}");
            }else{
                out.print("{\"type\":\"fail\"}");
            }
        }
        if("delete".equalsIgnoreCase(action)){
            String id = req.getParameter("id");
            int n = db.update("delete from `order` where `order`.go_id="+id);
            if(n>0){
                out.print("{\"type\":\"success\"}");
            }else{
                out.print("{\"type\":\"fail\"}");
            }
        }
        out.flush();
        out.close();
    }

}
