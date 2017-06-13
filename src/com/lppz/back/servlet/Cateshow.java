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


@WebServlet("/cateshow.action")
public class Cateshow extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf8");
        resp.setCharacterEncoding("utf8");
        resp.setContentType("text/html;charset=utf8");
        StringBuilder sb = new StringBuilder();
        PrintWriter out = resp.getWriter();
        int p =req.getParameter("param").equals("null")?1:Integer.parseInt(req.getParameter("param"));
        MyUtil mu = new MyUtil();
        mu.setCurrpage(p);
        sb.append("<thead>");
        sb.append("<tr>");
        sb.append("<th>编号</th>");
        sb.append("<th>小分类名称</th>");
        sb.append("<th>所属大分类</th>");
        sb.append("<th>操作</th>");
        sb.append("</tr>");
        sb.append("</thead>");
        sb.append("<tbody>");
        if(mu.count("cate")<1){
            sb.append("<tr><td colspan=100><b>暂时还没有小分类</b></td></tr>");
        }else {
            List<Map<String, Object>> list = mu.page("cate", "*", "where 1=1", "order by id desc");
            for (Map<String, Object> m : list) {
                sb.append("<tr>");
                sb.append("<td>" + m.get("id") + "</td>");
                sb.append("<td>" + m.get("cname") + "</td>");
                sb.append("<td>" + mu.queryBy("bigcate", "bname", "where id=" + m.get("b_id")) + "</td>");
                sb.append("<td><a onclick=\"return confirm('确定删除   " + m.get("cname") + "?')\" href=\"../del.action?id=" + m.get("id") + " &p=" + mu.getCurrpage() + " &do=cate\">删除</a>&nbsp;<a href=\"updatecate.jsp?id=" + m.get("id") + "&p=" + mu.getCurrpage() + "&b_id=" + m.get("b_id") + "\">修改</a>\n</td>");
                sb.append("</tr>");
            }
        }
        sb.append("</tbody>");
        sb.append("<tr><td colspan=20>共［"+mu.getRecordcount()+"］条&nbsp;［"+mu.getPagecount()+"］页&nbsp;&nbsp;当前第［"+mu.getCurrpage()+"］页</td></tr>");
        sb.append("<tr><td colspan=20>"+mu.pageInfo()+"</td></tr>");
        out.print(sb);
        out.flush();
        out.close();
    }
}
