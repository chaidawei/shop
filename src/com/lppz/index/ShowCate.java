package com.lppz.index;

import com.lppz.db.DBOP;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


public class ShowCate {
    private static DBOP db = new DBOP();
    HttpServletRequest request ;
    public static String show(){

        StringBuilder sbr = new StringBuilder();
        List<Map<String, Object>> blist =db.Query("id,bname","bigcate");

        int bid =0;
        String[] woff = new String[]{"&#xe610;","&#xe613;","&#xe60b;","&#xe608;","&#xe60f;","&#xe611;","&#xe601;","&#xe604;","&#xe600;"};
        int i = 0;
        for (Map<String,Object> map : blist) {
            bid= (int) map.get("id");
            List<Map<String,Object>> list = db.Query("cname","cate,bigcate","where cate.b_id=bigcate.id and cate.b_id="+bid);
            sbr.append("<li class=\"\">");
            sbr.append("<div class=\"top-sort\"><h3><a href=\"../search.jsp?keyword=&ckeyword=&tkeyword="+map.get("bname")+"\">");
            sbr.append("<i class=\"iconfont\">"+woff[i]+"</i>"+map.get("bname")+"</a></h3></div>");
            sbr.append("<div class=\"sub-sort\">");
            sbr.append("<ul class=\"sub-sort-list\">");
            for(Map<String,Object> maps : list){
                    sbr.append("<li><a target=\"_blank\" href=\"../search.jsp?keyword=&tkeyword=&ckeyword="+maps.get("cname")+"\">"+maps.get("cname")+"</a></li>");
            }
            sbr.append("</ul>");
            sbr.append("</div>");
            sbr.append("</li>");
            i++;
            if(i==woff.length){
                i=woff.length-1;
            }
        }
        return sbr.toString();
    }

    public static String tabCate(){
        StringBuilder tab = new StringBuilder();
        List<Map<String,Object>> bigCate = db.Query("id,bname,advs","bigcate","limit 6");
        int i =1;
        for (Map<String,Object> bigMap:bigCate) {
            int bigId = (int) bigMap.get("id");
            List<Map<String,Object>> cate = db.Query("cate.id,cname","cate,bigcate","where cate.b_id=bigcate.id and cate.b_id="+bigId);
            tab.append("<div id=\""+bigId+"\" class=\"storey-food\">");
            tab.append("<div class=\"stor-top\">");
            tab.append("<div class=\"stor-title\"><span>"+i+"F</span>");
            tab.append("<h2>"+bigMap.get("bname")+"</h2></div>");
            tab.append("<div class=\"stor-slide of-slide\">");
            tab.append("<ul class=\"stor-list oslide\">");
            tab.append("<li><a title=\"首页类目楼层-"+bigMap.get("bname")+"\" href=\"\" target=\"_blank\"><img class=\"lazy\" src=\"bigcate_upload/"+bigMap.get("advs")+"\" alt=\"首页类目楼层-"+bigMap.get("bname")+"\" style=\"display: block;\"></a></li>");
            tab.append("</ul>");
            tab.append("</div>");
            tab.append("</div>");
            tab.append("<div class=\"storey-cont\">");
            tab.append("<div class=\"sc-title jk\">");
            tab.append("<ul class=\"sct-tabs\">");
            for(Map<String,Object> map : cate){
                tab.append("<li class=\"active\"><a href=\"javascript:void(0);\">"+map.get("cname")+"</a></li>");
            }
            tab.append("</ul>");
            tab.append("<div class=\"sct-hot\">");
            tab.append("<a href=\"search.jsp?keyword=&ckeyword=&tkeyword="+bigMap.get("bname")+"\" target=\"_blank\" class=\"more\">更多商品&gt;</a>");
            tab.append("</div>");
            tab.append("</div>");
            //商品内容
            tab.append("<div class=\"sc-info\">");
            for(Map<String,Object> map : cate){
                List<Map<String,Object>> goods = db.Query("goods.id,gname,gprice","cate,goods","where goods.statu=1 and cate.id=goods.c_id and goods.c_id="+(int)map.get("id")+" limit 8");
                tab.append("<div class=\"sin-node\" style=\"display: block;\">");
                tab.append("<ul class=\"node-list\">");
                for (Map<String,Object> goodMap : goods) {
                    Object name = goodMap.get("gname");
                    Object id = goodMap.get("id");
                    String imgName = (String) db.queryBy("pname","goodspic","where go_id="+id);
                    tab.append("<li>");
                    tab.append("<div class=\"p-img\"><a title=\""+name+"\" href=\"product/list.jsp?id="+id+"\" target=\"_blank\">");
                    tab.append("<img class=\"lazy\" src=\"goodsgroup/"+imgName+"\" alt=\""+name+"\" style=\"display: block;\"></a>");
                    tab.append("</div>");
                    tab.append("<div class=\"p-bg\"></div>");
                    tab.append("<div class=\"p-info\">");
                    tab.append("<a class=\"name\" href=\"product/list.jsp?id="+id+"\" target=\"_blank\" title=\""+name+"\">"+name+"</a>");
                    tab.append("<span class=\"price\"><small>￥</small>"+goodMap.get("gprice")+"</span>");
                    tab.append("</div>");
                    tab.append("</li>");
                }
                tab.append("</ul>");
                tab.append("</div>");
            }
            tab.append("</div>");
            //------------------------------
            tab.append("</div>");
            tab.append("</div>");

            i++;
        }
        return tab.toString();
    }
}
