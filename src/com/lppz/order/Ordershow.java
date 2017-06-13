package com.lppz.order;

import com.lppz.back.db.MyUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;


@WebServlet("/ordershow.action")
public class Ordershow extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf8");
        resp.setContentType("text/html;charset=utf8");
        MyUtil mu = new MyUtil();
        PrintWriter out = resp.getWriter();
        StringBuilder sb = new StringBuilder();
        String action = req.getParameter("action");
        String name = req.getParameter("name");
        int id = (int)mu.queryBy("user_info","id","where username = '"+name+"'");
        sb.append("  <tr class=\"ol-select\">\n" /*+
               "                            <td>&nbsp;</td>\n" +
               "                            <td>&nbsp;</td>\n" +
               "                            <td>&nbsp;</td>\n" +
               "                            <td>\n" +
               "                                <select class=\"slt-opt\" name=\"orderDate\" id=\"orderDate\" onchange=\"selectValue();\">\n" +
               "                                    <option value=\"1\">最近一个月</option>\n" +
               "                                    <option value=\"3\">最近三个月</option>\n" +
               "                                    <option value=\"12\">最近一年</option>\n" +
               "                                </select>\n" +
               "                            </td>\n" +
               "                            <td>\n" +
               "                                <select class=\"slt-opt\" name=\"orderType\" id=\"orderType\" onchange=\"selectValue();\">\n" +
               "                                    <option value=\"waitPay\" selected=\"selected\">待付款</option>\n" +
               "                                    <!-- <option value=\"waitShip\" >待发货</option>\n" +
               "                                    <option value=\"waitReceipt\" >已发货</option> -->\n" +
               "                                    <option value=\"tobeReceipt\" >待收货</option>\n" +
               "                                    <option value=\"completed\" >已完成</option>\n" +
               "                                    <option value=\"cancelled\" >已取消</option>\n" +
               "                                </select>\n" +
               "                            </td>\n" +
               "                            <td >\n" +
               "                                <select class=\"slt-opt\" name=\"platform\" id=\"platform\" onchange=\"selectValue();\">\n" +
               "                                    <option value=\"0000\">普通订单</option>\n" +
               "                                </select>\n" +
               "                            </td>\n" +
               "                            <td>&nbsp;</td>\n" +
               "                        </tr>\n"*/ +
               "                        <tr>\n" +
               "                            <th width=\"240\">订单信息</th>\n" +
               "                            <th>收货人</th>\n" +
               "                            <th>订单金额</th>\n" +
               "                            <th>订单时间</th>\n" +
               "                            <th>状态</th>\n" +
               "                            <th>操作</th>\n" +
               "                        </tr>");

        if("all".equalsIgnoreCase(action)){
            if(mu.exists("order_info","where us_id ="+id)){

                List<Map<String, Object>> list = mu.query("order_info", "*", "where us_id ="+id, "order by statu desc", "");
              for(Map<String,Object> m:list){
                sb.append("<tr rowspan=\"100\" class=\"tt\">");
                  sb.append("<td>"+m.get("number")+"<br></td>");
                  sb.append("<td>"+mu.queryBy("address","name","where id="+m.get("addr_id"))+"</td>");
                  sb.append("<td>"+m.get("money")+"</td>");
                  sb.append("<td>"+m.get("date")+"</td>");
                  if((int)m.get("statu")==1){
                      sb.append("<td><span class=\"state red\">待付款<span></td>");
                  }else if((int)m.get("statu")==2){
                      sb.append("<td><span class=\"state red\">待收货<span></td>");
                  }else if((int)m.get("statu")==3){
                      sb.append("<td><span class=\"state red\">已完成<span></td>");
                  }
                  sb.append("<td><a href=\"\">立即支付</a><br><a href=\"\">取消订单</a></td>");
                    sb.append("</tr>");
              }
            }else {
                sb.append("<td  colspan=\"100\" style=\"text-align:center\"><span>LP暂时还没有符合要求的订单</span></td>");
            }
        }
        if("m".equalsIgnoreCase(action)){
            if(mu.exists("order_info","where us_id ="+id)){

                List<Map<String, Object>> list = mu.query("order_info", "*", "where statu = 1 and us_id="+id, "order by id desc", "");
                for(Map<String,Object> m:list){
                    sb.append("<tr rowspan=\"100\" class=\"tt\">");
                    sb.append("<td>"+m.get("number")+"<br></td>");
                    sb.append("<td>"+mu.queryBy("address","name","where id="+m.get("addr_id"))+"</td>");
                    sb.append("<td>"+m.get("money")+"</td>");
                    sb.append("<td>"+m.get("date")+"</td>");
                    sb.append("<td><span class=\"state red\">待付款<span></td>");
                    sb.append("<td><a href=\"\">立即支付</a><br><a href=\"\">取消订单</a></td>");
                    sb.append("</tr>");
                }
            }else {
                sb.append("<td colspan=\"100\"><span>LP暂时还没有符合要求的订单aa</span></td>");
            }
        }

        if("w".equalsIgnoreCase(action)){
            if(mu.exists("order_info","where us_id ="+id)){

                List<Map<String, Object>> list = mu.query("order_info", "*", "where statu = 2 and us_id="+id, "order by id desc", "");
                for(Map<String,Object> m:list){
                    sb.append("<tr rowspan=\"100\" class=\"tt\">");
                    sb.append("<td>"+m.get("number")+"<br></td>");
                    sb.append("<td>"+mu.queryBy("address","name","where id="+m.get("addr_id"))+"</td>");
                    sb.append("<td>"+m.get("money")+"</td>");
                    sb.append("<td>"+m.get("date")+"</td>");
                    sb.append("<td><span class=\"state red\">待收货<span></td>");
                    sb.append("<td><a href=\"\">立即支付</a><br><a href=\"\">取消订单</a></td>");
                    sb.append("</tr>");
                }
            }else {
                sb.append("<td colspan=\"100\"><span>LP暂时还没有符合要求的订单aa</span></td>");
            }
        }
        if("d".equalsIgnoreCase(action)){
            if(mu.exists("order_info","where us_id ="+id)){
                List<Map<String, Object>> list = mu.query("order_info", "*", "where statu = 3 and us_id="+id, "order by id desc", "");
                for(Map<String,Object> m:list){
                    sb.append("<tr rowspan=\"100\" class=\"tt\">");
                    sb.append("<td>"+m.get("number")+"<br></td>");
                    sb.append("<td>"+mu.queryBy("address","name","where id="+m.get("addr_id"))+"</td>");
                    sb.append("<td>"+m.get("money")+"</td>");
                    sb.append("<td>"+m.get("date")+"</td>");
                    sb.append("<td><span class=\"state red\">已完成<span></td>");
                    sb.append("<td><a href=\"\">立即支付</a><br><a href=\"\">取消订单</a></td>");
                    sb.append("</tr>");
                }
            }else {
                sb.append("<td colspan=\"100\"><span>LP暂时还没有符合要求的订单aa</span></td>");
            }
        }
        out.print(sb);
        out.flush();
        out.close();

    }
}
