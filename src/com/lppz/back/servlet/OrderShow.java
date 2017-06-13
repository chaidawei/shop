package com.lppz.back.servlet;

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


@WebServlet("/order.action")
public class OrderShow extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf8");
        PrintWriter out = resp.getWriter();
        StringBuilder sb = new StringBuilder();
        String action = req.getParameter("action");
        String p = req.getParameter("page");
        sb.append("<thead>");
        sb.append("<tr>");
        sb.append("<th>订单编号</th>");
        sb.append("<th>用户名</th>");
        sb.append("<th>订单金额</th>");
        sb.append("<th>订单时间</th>");
        sb.append("<th>订单状态</th>");
        sb.append("<th>操作</th>");
        sb.append("</tr>");
        sb.append("</thead>");
        sb.append("<tbody>");
        if ("all".equals(action)) {
            MyUtil mu = new MyUtil();
            mu.setCurrpage("null".equals(p) ? 1 : Integer.parseInt(p));
            mu.setPagesize(5);
            if (mu.count("order_info") < 1) {
                sb.append("<tr><td colspan=100><b>暂时还没有订单</b></td></tr>");
            } else {
                List<Map<String, Object>> list = mu.page("order_info", "*", "where statu not in (4,5)", "");
                if (list == null) {
                    sb.append("<tr><th colspan=100><b>暂时没有订单</b></th></tr>");
                } else {
                    for (Map<String, Object> m : list) {
                        sb.append("<tr>");
                        sb.append("<td>" + m.get("number") + "</td>");
                        sb.append("<td>" + mu.queryBy("user_info", "username", "where id=" + m.get("us_id")) + "</td>");
                        sb.append("<td>" +m.get("money")+ "</td>");
                        sb.append("<td>" + m.get("date") + "</td>");
                        if (1 == (int) m.get("statu")) {
                            sb.append("<td>待付款</td>");
                        } else if (2 == (int) m.get("statu")) {
                            sb.append("<td>待收货</td>");
                        } else if (3 == (int) m.get("statu")) {
                            sb.append("<td>已完成</td>");
                        }
                        sb.append("<td><a onclick=\"return confirm('确定删除  " + mu.queryBy("user_info", "username", "where id=" + m.get("us_id")) + "的订单吗?')\" href=\"../del.action?id=" + m.get("id") + "&p=" + mu.getCurrpage() + "&do=order_info\">删除</a>&nbsp;<a>修改</a></td>");
                        sb.append("</tr>");
                    }
                    sb.append("<tr><td colspan=100>共&nbsp;[" + mu.getPagecount() + "]&nbsp;页 [" + mu.count("`order`", "where statu not in (4,5)") + "]&nbsp;条&nbsp;&nbsp;当前第&nbsp;[" + mu.getCurrpage() + "]&nbsp;页</td></tr>");


                    sb.append("<tr><td colspan=100>" + mu.pageInfo() + "</td></tr>");
                }
            }
        }
        sb.append("</tbody>");
        out.print(sb);
        out.flush();
        out.close();
    }
}
