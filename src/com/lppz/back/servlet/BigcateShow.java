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


@WebServlet("/showbigcate")
public class BigcateShow extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf8");
        req.setCharacterEncoding("utf8");
        resp.setContentType("text/html;charset=utf8");
        StringBuilder sb = new StringBuilder();
        PrintWriter out = resp.getWriter();
        int p = "null".equals(req.getParameter("param"))?1:Integer.parseInt(req.getParameter("param"));
        MyUtil mu = new MyUtil();
        mu.setCurrpage(p);
        if(mu.count("bigcate")<1){
            sb.append("<tr><td colspan=100><b>暂时还没有大分类</b></td></tr>");
        }else {
            List<Map<String, Object>> list = mu.page("bigcate", "*", "where 1=1", "order by id desc");
            sb.append("<thead>");
            sb.append("<tr>");
            sb.append("<th>编号</th>");
            sb.append("<th>分类名称</th>");
            sb.append("<th>分类样图</th>");
            sb.append("<th>操作</th>");
            sb.append("</tr>");
            sb.append("</thead>");
            sb.append("<tbody>");
            for (Map<String, Object> m : list) {
                sb.append("<tr>");
                sb.append("<td>" + m.get("id") + "</td>");
                sb.append("<td>" + m.get("bname") + "</td>");
                sb.append("<td><img src=\"http://localhost:8080/bigcate_upload2/" + m.get("advs") + "\"></td>");
                sb.append("<td><a onclick=\"return confirm('删除大分类相应的小分类也会一起删除，确定删除   " + m.get("bname") + "大分类吗?')\" href=\"../del.action?p=" + p + "&id=" + m.get("id") + "&do=bigcate&path=" + m.get("advs") + "\">删除</a>&nbsp;&nbsp;<a href=\"update_bigcate.jsp?p=" + p + "&id=" + m.get("id") + "&do=updatebigcate\">修改</a></td>");
                sb.append("</tr>");
            }
        }
        sb.append("</tbody>");
        sb.append("<tr>");
        sb.append("<td colspan=10>共　["+mu.getPagecount()+"]　页　["+mu.getRecordcount()+"]　条　　当前第　["+mu.getCurrpage()+"]　页</td>");
        sb.append("</tr>");
        sb.append("<tr><td colspan=10>"+mu.pageInfo()+"</td></tr>");


        out.print(sb);
        out.flush();
        out.close();
    }
}
