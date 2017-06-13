package com.lppz.good;

import com.lppz.db.DBOP;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@WebServlet("/selectgood")
public class SelectGoods extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=UTF-8");
        String name = req.getParameter("name");
        String tablename = req.getParameter("tablename");
        String action = req.getParameter("action");
        int line = req.getParameter("currPage") != null ? Integer.parseInt(req.getParameter("currPage")) : 1;
        int size=12;
        DBOP db = new DBOP();
        PrintWriter out = resp.getWriter();
        StringBuilder sbr;
        //查询得到商品总数量
        List<Map<String,Object>> list;
        int counts = 0;
        if("bigcate".equals(tablename)){
            list = db.Query("goods.*","cate,goods,bigcate","where bigcate.id=cate.b_id and cate.id=goods.c_id and goods.statu=1 and bigcate.bname like '%"+name+"%' limit "+(line*size-size)+","+size);
            counts=db.allCount("cate,goods,bigcate","where bigcate.id=cate.b_id and cate.id=goods.c_id and goods.statu=1 and bigcate.bname like '%"+name+"%'");
        }else if ("cate".equals(tablename)){
            list = db.Query("goods.*","cate,goods","where cate.id=goods.c_id and goods.statu=1 and cate.cname like '%"+name+"%' limit "+(line*size-size)+","+size);
            counts = db.allCount("cate,goods","where cate.id=goods.c_id and goods.statu=1 and cate.cname like '%"+name+"%'");
        }else{
            list =  db.Query("*","goods","where statu=1 and gname like '%"+name+"%' limit "+(line*size-size)+","+size);
            counts = db.allCount("goods","where statu=1 and gname like '%"+name+"%'");
        }
        if("page".equals(action)){
//            <input type="hidden" name="line" id="line" value="0">
//					<li><span class="prev">上页</span></li>
//					<li><span class="next">下页</span></li>
//					<li>
//						<small class="sum">共0页</small>
//						<i>到第</i><input class="pg_txt" type="text" value="1" name="curPage" id="turnPage"><i>页</i>
//						<input class="pg_btn" type="button" value="确定">
//					</li>
            sbr = new StringBuilder();
            int pageCount = counts%size==0?counts/size:counts/size+1;
            if(counts<size){
                pageCount=1;
            }
            if(line>counts){
                line=counts;
            }
            if(line<=0){
                line=1;
            }
//            int currPage = line*size-size;
//            sbr.append("<input type=\"hidden\" name=\"line\" id=\"line\" value=\""+currPage+"\">");
//            var n = $(this).attr("receivePage");
//            paSelect(n);
//            showPaging(n);
            if(line==1){
                sbr.append("<li><span class=\"prev\">上页</span></li>");
            }else{
                sbr.append("<li><a class=\"prev\" href=\"javascript:;\" receivePage=\""+(line-1)+"\" onclick=\"paSelect("+(line-1)+");showPaging("+(line-1)+");\">上页</a></li>");
            }
            for(int i=1;i<=pageCount;i++){
               if(line==i){
                   sbr.append("<li><span class=\"current\">"+i+"</span></li>");
                   continue;
               }
               sbr.append("<li><a class=\"skip\" href=\"javascript:void(0);\" receivePage=\""+i+"\" onclick=\"paSelect("+i+");showPaging("+i+");\">"+i+"</a></li>");
            }
            if(line!=pageCount){
                sbr.append("<li><a class=\"next\" href=\"javascript:void(0);\" receivePage=\""+(line+1)+"\" onclick=\"paSelect("+(line+1)+");showPaging("+(line+1)+");\">下页</a></li>");
            }else{
                sbr.append("<li><span class=\"next\">下页</span></li>");
            }
            sbr.append("<li><small class=\"sum\">共<b>"+pageCount+"</b>页</small>");
            sbr.append("<i>到第</i><input class=\"pg_txt\" type=\"text\" value=\""+line+"\" name=\"curPage\" id=\"turnPage\"><i>页</i>");
            sbr.append("<input class=\"pg_btn\" type=\"button\" value=\"确定\" onclick=\"paSelect(document.getElementsByName('curPage')[0].value);showPaging(document.getElementsByName('curPage')[0].value);\"></li>");
        }else if("count".equals(action)){
            sbr = new StringBuilder();
            sbr.append(counts);

        }else {
            sbr = new StringBuilder();
            if(list.size()>0){
                sbr.append("<ul class=\"producrt-list clearfix\" id=\"content_ul\">");
                for (Map<String,Object> map : list) {
                    //处理图片
                    String imgName = (String) db.queryBy("pname","goodspic","where go_id="+map.get("id")+" limit 1");
                    String nameWeight = map.get("gname")+"("+map.get("spec")+"g)";
                    sbr.append("<li><div class=\"pt\">");
                    sbr.append("<a href=\"product/list.jsp?id="+map.get("id")+"\" title=\""+nameWeight+"\" class=\"pic\" target=\"_blank\">");
                    sbr.append("<img src=\"goodsgroup/"+imgName+"\"></a>");
                    sbr.append(" <a href=\"product/list.jsp?id="+map.get("id")+"\" title=\""+nameWeight+"\" class=\"tit\" target=\"_blank\">"+nameWeight+"</a>");
                    sbr.append("<p class=\"prom\" title=\"与享受慢时光的幸福相遇\">与享受慢时光的幸福相遇</p></div>");
                    sbr.append("<div class=\"price\"><span>￥<i>"+map.get("gprice")+"</i></span></div>");
                    sbr.append("<div class=\"part\">");
//                    sbr.append("<div class=\"cart\">");
//                    sbr.append("<a class=\"add\" href=\"javascript:addCart('"+map.get("id")+"');\">加购物车</a></div>");
                    sbr.append("<div class=\"meta\">");
                    sbr.append("<span class=\"sale\">已售：<i>"+map.get("gnum")+"</i></span>");
                    sbr.append("<div class=\"comm\"><span class=\"tx\">评分：</span><span class=\"score-star\"><i class=\"star05\">"+map.get("gscore")+"分</i></span></div>");
                    sbr.append(" </div></div></li>");
                }
                sbr.append("</ul>");
            }else{
                sbr.append("empty");
            }
        }

        out.print(sbr.toString());

        out.flush();
        out.close();
    }

}
