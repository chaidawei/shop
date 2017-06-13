package com.lppz.good;

import com.lppz.db.DBOP;

import java.util.List;
import java.util.Map;


public class ShowType {
    private static DBOP db = new DBOP();

    public static String ShowPack(){
        StringBuilder sb1 = new StringBuilder();
        List<Map<String,Object>> list =  db.Query("paname","pack");
        for (Map<String,Object> map : list){
            sb1.append("<li><a href=\"javascript:;\">"+map.get("paname")+"</a></li>");
        }
        return sb1.toString();
    }

    public static String ShowSource(){
        StringBuilder sb2 = new StringBuilder();
        List<Map<String,Object>> list =  db.Query("soname","source");
        for (Map<String,Object> map : list){
            sb2.append("<li><a href=\"javascript:;\">"+map.get("soname")+"</a></li>");
        }
        return sb2.toString();
    }
}
