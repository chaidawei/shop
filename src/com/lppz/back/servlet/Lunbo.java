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


@WebServlet("/lunbo")
public class Lunbo extends HttpServlet{
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf8");
        resp.setContentType("text/html;charset=utf8");
        MyUtil mu = new MyUtil();
        StringBuilder sb = new StringBuilder();
        String p = req.getParameter("pa");
        mu.setPagesize(2);
        mu.setCurrpage("null".equals(p) ? 1 : Integer.parseInt(p));
        sb.append("<thead>");
        sb.append("<tr>");
        sb.append("<th>ID</th>");
        sb.append("<th>名称</th>");
        sb.append("<th>别名</th>");
        sb.append("<th>图片</th>");
        sb.append("<th>状态</th>");
        sb.append("<th>操作</th>");
        sb.append("</tr>");
        sb.append("</thead>");
        sb.append("<tbody>");
        if(mu.count("lunbo")<1){
            sb.append("<tr><td colspan=100><b>暂时还没有轮播广告</b></td></tr>");
        }else {
            List<Map<String, Object>> list = mu.page("lunbo", "*", "where 1=1", "order by id desc");
            for (Map<String, Object> m : list) {
                sb.append("<tr>");
                sb.append("<td>" + m.get("id") + "</td>");
                sb.append("<td>" + m.get("name") + "</td>");
                sb.append("<td>" + m.get("byname") + "</td>");
                sb.append("<td><img src=\"../suolun/" + m.get("name") + "\"/></td>");
                if ("0".equals(m.get("statu").toString())) {
                    sb.append("<td>显示</td>");
                } else {
                    sb.append("<td>不显示</td>");
                }
                sb.append("<td><a onclick=\"return confirm('确定删除  " + m.get("byname") + "?')\" href=\"../del.action?id=" + m.get("id") + "&p=" + mu.getCurrpage() + "&do=lunbo&path=" + m.get("name") + "\" class=\"del\">删除</a>　<a href=\"updatelunbo.jsp?id=" + m.get("id") + "\">修改</a></td>");
                sb.append("</tr>");
            }
            sb.append("<tr>");
            sb.append("<td colspan=\"6\">共［" + mu.getPagecount() + "］页&nbsp;共［" + mu.getRecordcount() +
                    "］条&nbsp;&nbsp;当前第［" + mu.getCurrpage() + "］页</td>");
            sb.append("</tr>");
            sb.append("<tr>");
            sb.append("<td colspan=\"6\">" + mu.pageInfo() + "</td>");
            sb.append("</tr>");
        }
        sb.append("</tbody>");
        PrintWriter out = resp.getWriter();
        out.print(sb);
        out.flush();
        out.close();

    }

}
