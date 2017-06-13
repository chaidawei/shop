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

@WebServlet("/membershow.action")
public class Member extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf8");
        resp.setCharacterEncoding("utf8");
        resp.setContentType("text/html;charset=utf8");
        StringBuilder sb = new StringBuilder();
        PrintWriter out = resp.getWriter();
        MyUtil mu = new MyUtil();
        String p = req.getParameter("page");;
        int p1 ="null".equals(p)?1:Integer.parseInt(p);
        mu.setCurrpage(p1);
        sb.append("<thead>");
        sb.append("<tr>");
        sb.append("<th>ID</th>");
        sb.append("<th>用户名</th>");
        sb.append("<th>昵称</th>");
        sb.append("<th>真实姓名</th>");
        sb.append("<th>性别</th>");
        sb.append("<th>出生日期</th>");
        sb.append("<th>状态</th>");
        sb.append("<th>操作</th>");
        sb.append("</tr>");
        sb.append("</thead>");
        sb.append("<tbody>");
        List<Map<String,Object>> list = mu.page("user_info","*","where 1=1","order by id desc");
        for(Map<String,Object> m :list){
            sb.append("<tr>");
            sb.append("<td>"+m.get("id")+"</td>");
            sb.append("<td>"+m.get("username")+"</td>");
            sb.append("<td>"+m.get("uname")+"</td>");
            sb.append("<td>"+m.get("realname")+"</td>");
            sb.append("<td>"+m.get("gender")+"</td>");
            sb.append("<td>"+m.get("birthday")+"</td>");
            if("1".equals(m.get("statu").toString())){
                sb.append("<td>活跃</td>");
            }else {
                sb.append("<td>冻结</td>");
            }
            sb.append("<td><a onclick=\"return confirm('确定删除"+m.get("username")+"'?)\" href=\"../del.action?id="+m.get("id")+"&p="+mu.getCurrpage()+"&do=member\">删除</a>&nbsp;<a href=\"updatemember.jsp?id="+m.get("id")+"\">修改</a></td>");
            sb.append("</tr>");
        }
        sb.append("<tr><td colspan=10>共［"+mu.getPagecount()+"］页［"+mu.getRecordcount()+"］条&nbsp;&nbsp;当前第［"+mu.getCurrpage()+"］页</td></tr>");
        sb.append("<tr><td colspan=10>"+mu.pageInfo()+"</td></tr>");



        sb.append("</tbody>");
        out.print(sb);
        out.flush();
        out.close();
    }
}
