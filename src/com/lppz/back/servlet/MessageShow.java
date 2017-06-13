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


@WebServlet("/message.show")
public class MessageShow extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf8");
        resp.setCharacterEncoding("utf8");
        resp.setContentType("text/html;charset=utf8");
        String p = req.getParameter("page");
        String action=req.getParameter("action");
        StringBuilder sb = new StringBuilder();
        PrintWriter out = resp.getWriter();
        MyUtil mu = new MyUtil();
      if("show".equals(action)){
          sb.append("<thead>");
          sb.append("<tr>");
          sb.append("<th>留言编号</th>");
          sb.append("<th>留言人</th>");
          sb.append("<th>留言内容</th>");
          sb.append("<th>留言日期</th>");
          sb.append("<th>基本操作</th>");
          sb.append("</tr>");
          sb.append("</thead>");
          sb.append("<tbody>");
          mu.setCurrpage("null".equals(p) ? 1 : Integer.parseInt(p));
          mu.setPagesize(5);
          if(mu.count("message")<1){
              sb.append("<tr><td colspan=100><b>暂时还没有留言</b></td></tr>");
          }else {
              List<Map<String, Object>> list = mu.page("message", "*", "", "order by id desc");
              for(Map<String,Object> m:list){
               sb.append("<tr>");
               sb.append("<td>"+m.get("id")+"</td>");
               sb.append("<td>"+m.get("name")+"</td>");
               sb.append("<td>"+m.get("econtent")+"</td>");
               sb.append("<td>"+m.get("time")+"</td>");
               sb.append("<td><a onclick=\"return confirm('确定删除"+m.get("name")+"的留言吗?')\" href=\"../del.action?id="+m.get("id")+"&do=message&p="+mu.getCurrpage()+"\">删除</a></td>");
               sb.append("</tr>");
           }
           sb.append("<tr><td colspan=100>共&nbsp;["+mu.getPagecount()+"]&nbsp;页["+mu.getRecordcount()+"]条&nbsp;&nbsp;当前第&nbsp;["+mu.getCurrpage()+"]&nbsp;页</td></tr>");
            sb.append("<tr><td colspan=100>"+mu.pageInfo()+"</td></tr>");
          }

          sb.append("</tbody>");
          out.print(sb);
          out.flush();
          out.close();

      }
    }
}
