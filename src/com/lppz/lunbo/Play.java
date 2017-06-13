package com.lppz.lunbo;

import com.lppz.db.DBOP;


import java.util.List;
import java.util.Map;


public class Play {

       public static String createPlay(){
           DBOP db = new DBOP();
           List<Map<String,Object>> list = db.Query("name,byname","lunbo","where statu=0");
           StringBuilder sbr = new StringBuilder();
           for (Map<String,Object> map : list) {
               sbr.append("<li><a href=\"#\"><img src=\"lunbo/"+map.get("name")+"\" alt=\"\" width=\"800\" height=\"440\"></a></li>");
               //sbr.append("<li><a href=\"search?id="+map.get("byname")+"\"><img src=\"lunbo/"+map.get("name")+"\" alt=\"\" width=\"800\" height=\"440\"></a></li>");
           }
            return sbr.toString();
       }
}
