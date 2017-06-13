package com.lppz.back.db;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * Created by webrx on 2017/5/17.
 */
public class Dbutil {
    private String driver="com.mysql.jdbc.Driver";
    private String url="jdbc:mysql://192.168.0.182:3306/lppz?useUnicode=true&characterEncoding=utf8&useSSL=true";
    private String user="admin";
    private String password="admin";
    private Connection conn=null;
    public Dbutil() {
        try {
            Class.forName(driver);
            conn= DriverManager.getConnection(this.url,this.user,this.password);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public Connection getConn(){
        return conn;
    }
    //查询当前表的主键
    public String getpk(String tablename){
        String pk=null;
        try {
            String sql=String.format("show full columns from %s",tablename);
            PreparedStatement pre=this.conn.prepareStatement(sql);
            ResultSet res=pre.executeQuery();
            if(res.isBeforeFirst()){
                while (res.next()){
                    if(res.getString("Key").equals("PRI")){
                        pk=res.getString("Field");
                        break;
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return pk;
    }

    //查询最后插入那条数据的id
    public int getid(){
        int num=0;
        try {
            String pp="select last_insert_id()";
            PreparedStatement pre=this.conn.prepareStatement(pp);
            ResultSet res=pre.executeQuery();
            if(res.isBeforeFirst()){
                while(res.next()){
                  num=(int)res.getInt("last_insert_id()");
                }
            }
         }catch (Exception e){
            e.printStackTrace();
        }
        return num;
    }
    //查询表中有多少条数据
    public int getcount(String tablename){
        int num=0;
        try{
            String sql=String.format("select count(*) from %s",tablename);
            PreparedStatement pre=this.conn.prepareStatement(sql);
            ResultSet res=pre.executeQuery();
            if(res.isBeforeFirst()){
                while (res.next()){
                    num=res.getInt(1);
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return num;
    }
    public int getcounta(String tablename,String where){
        int num=0;
        try{
            String sql=String.format("select count(*) from %s where %s",tablename,where);
            PreparedStatement pre=this.conn.prepareStatement(sql);
            ResultSet res=pre.executeQuery();
            if(res.isBeforeFirst()){
                while (res.next()){
                    num=res.getInt(1);
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return num;
    }
    //分页查询
    public List<Map<String,Object>> limit(String tablename,int num,int dqy,String where){
        List<Map<String,Object>> list=null;
        try {
            //得到表中的总条数
            int sum=getcount(tablename);
            //要分的页数
            int yy=sum%num==0?sum/num:sum/num+1;

            if(dqy<1) dqy=1;
            if(dqy>yy) dqy=yy;

            String sql=String.format("select * from %s where %s limit %s,%s",tablename,where,dqy*num-num,num);
            PreparedStatement pre;
            pre = this.conn.prepareStatement(sql);
            ResultSet res=pre.executeQuery();
            if(res.isBeforeFirst()){
                list=new ArrayList<Map<String,Object>>();
                while(res.next()){
                    Map<String,Object> map=new HashMap<String,Object>();
                    ResultSetMetaData rem=res.getMetaData();
                    int le= rem.getColumnCount();
                    for(int i=1;i<=le;i++){
                        String f=rem.getColumnLabel(i);
                        map.put(f,res.getObject(f));

                    }
                    list.add(map);
                }
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }
    //增加语句
    public int insert(String sql,Object[] param){
        int num=0;
        try {
            PreparedStatement pre;
            pre = this.conn.prepareStatement(sql);
            for(int i=1;i<=param.length;i++){
                pre.setObject(i,param[i-1]);
            }
            num=pre.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        return num;
    }

    //删除语句
    public int delete(String tablename,String where){
        int num=0;
        try {
            String sql=String.format("delete from %s where %s",tablename,where);
            PreparedStatement pre=this.conn.prepareStatement(sql);
            num=pre.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        return num;
    }
    //修改语句
    public  int update(String tablename,String column,Object columnz,String where){
        int num=0;
        try {
            String sql=String.format("update %s set %s=? where %s",tablename,column,where);
            PreparedStatement pre=this.conn.prepareStatement(sql);
            pre.setObject(1,columnz);
            num=pre.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        return num;
    }
    //查询语句
    public List<Map<String,Object>> query(String tablename,String where){
        List<Map<String,Object>> list;
        list = null;
        try{
            String sql=String.format("select * from %s where %s",tablename,where);
            PreparedStatement pre=this.conn.prepareStatement(sql);
            ResultSet res=pre.executeQuery();
            if(res.isBeforeFirst()) {
                list=new ArrayList<Map<String,Object>>();
                while (res.next()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    ResultSetMetaData rem = res.getMetaData();
                    int m = rem.getColumnCount();
                    for (int i = 1; i <= m; i++) {
                        String s = rem.getColumnLabel(i);
                        map.put(s, res.getObject(s));
                    }
                    list.add(map);
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }
    public List<Map<String,Object>> querya(String tablename,String column,String where){
        List<Map<String,Object>> list=null;
        try{
            String sql=String.format("select %s from %s where %s",column,tablename,where);
            PreparedStatement pre=this.conn.prepareStatement(sql);
            ResultSet res=pre.executeQuery();
            if(res.isBeforeFirst()) {
                list=new ArrayList<Map<String,Object>>();
                while (res.next()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    ResultSetMetaData rem = res.getMetaData();
                    int m = rem.getColumnCount();
                    for (int i = 1; i <= m; i++) {
                        String s = rem.getColumnLabel(i);
                        map.put(s, res.getObject(s));
                    }
                    list.add(map);
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }

    public  void close(){
        if (this.conn!=null){
            try {
                this.conn.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        }

    }
}
