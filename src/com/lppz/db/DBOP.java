package com.lppz.db;



import java.sql.*;
import java.util.*;


public class DBOP {
    private PreparedStatement pst = null;
    private DBLink dBOP = new DBLink();

    private static Connection conn;
    private int currPage = 0;
    private int pageCount = 0;
    private int pageSize = 0;

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public void setCurrPage(int currPage) {
        this.currPage = currPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public int getPagecount() {
        return pageCount;
    }

    public int getCurrpage() {
        return currPage;
    }

//    static {
//        try {
//            Context context = new InitialContext();
//            DataSource ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
//
//            conn = ds.getConnection();
//        } catch (NamingException e) {
//            e.printStackTrace();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
    public Object queryBy(String fields,String tablename, String where) {
        Object obj = null;
        String sql = String.format("select %s from %s %s", fields, tablename, where);
        try {
            PreparedStatement pst = dBOP.getConn().prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.isBeforeFirst()) {
                rs.next();
                obj = rs.getObject(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return obj;
    }
    public List<Map<String, Object>> Query(String select, String tableName, String where) {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql = String.format("select %s from %s %s", select, tableName, where);
        return pst(sql, list);
    }

    public List<Map<String, Object>> Query(String select, String tableName) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = String.format("select %s from %s", select, tableName);
        return pst(sql, list);
    }

    private List<Map<String, Object>> pst(String sql, List<Map<String, Object>> list) {
        try {
            pst = dBOP.getConn().prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                ResultSetMetaData rsmd = rs.getMetaData();
                for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                    String labelName = rsmd.getColumnLabel(i);
                    map.put(labelName, rs.getObject(labelName));
                }
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /*
    public List<Student> Query(String sql){
        Student s = new Student();
        try {
            pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while(rs.next()){
                s.setName(rs.getString);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    */

    public int insert(String sql, Object[] param) {
        int num = 0;
        try {
            pst = dBOP.getConn().prepareStatement(sql);
            for (int i = 1; i <= param.length; i++) {
                pst.setObject(i, param[i - 1]);
            }
            num = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return num;
    }
    public int update(String s){
        int count = 0;
        try {
            pst = dBOP.getConn().prepareStatement(s);
            count = pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int allCount(String tableName) {
        String sql = String.format("select count(*) from %s", tableName);
        int count = 0;
        try {
            pst = dBOP.getConn().prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        dBOP.close();
        return count;
    }

    public int allCount(String tableName, String where) {
        String sql = String.format("select count(*) from %s %s", tableName,where);
        int count = 0;
        try {
            pst = dBOP.getConn().prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Map<String, Object>> pageResult(String tablename, int pageSize, String p) {
        List<Map<String, Object>> list = new ArrayList<>();

        int datacount = allCount("users");
        dBOP.open();
        this.pageSize = pageSize;
        pageCount = datacount % this.pageSize == 0 ? datacount / this.pageSize : datacount / this.pageSize + 1;
        currPage = p == null ? 1 : Integer.parseInt(p);
        if (currPage < 1)
            currPage = 1;
        if (currPage > pageCount)
            currPage = pageCount;
        String limit = "limit " + (currPage * this.pageSize - this.pageSize) + "," + this.pageSize;
        return Query("uname,upwd", tablename, limit);
    }

    public String pageUtil() {
        StringBuilder sbr = new StringBuilder();
        currPage = getCurrpage();
        int start = 1;
        int end = 10;
        sbr.append("<ul>");
        sbr.append(String.format("<li class=\"backpage\"><a href=\"?p=%d\">%s</a></li>", 1, "首页"));
        if (currPage > 1) {
            sbr.append(String.format("<li class=\"backpage\"><a href=\"?p=%d\">%s</a></li>", getCurrpage() - 1, "上一页"));
        }
        if (currPage >= end - 4) {
            start = currPage - 5;
            end = currPage + 4;
        }
        if (currPage >= pageCount - 4) {
            start = pageCount - 9;
            end = pageCount;
        }
        for (int i = start; i <= end; i++) {
            if (i >= pageCount)
                break;
            if (i == currPage) {
                sbr.append(String.format("<li class=\"curr_page\"><span>%d</span></li>", i));
            } else {
                sbr.append(String.format("<li class=\"page\"><a href=\"?p=%d\">%d</a></li>", i, i));
            }
        }
        if (currPage < getPagecount())
            sbr.append(String.format("<li class=\"nextpage\"><a href=\"?p=%d\">%s</a></li>", getCurrpage() + 1, "下一页"));
        sbr.append(String.format("<li class=\"nextpage\"><a href=\"?p=%d" +
                "\">%s</a></li>", pageCount, "末页"));
        sbr.append("</ul>");
        return sbr.toString();
    }

}
