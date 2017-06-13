package com.lppz.back.db;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.security.MessageDigest;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class MyUtil {
    private String driver = "com.mysql.jdbc.Driver";
    private String url = "jdbc:mysql://localhost:3306/lppz?useUnicode=true&characterEncoding=utf8&useSSL=true";
    private String user = "root";
    private String password = "";
    private Connection conn = null;
    private int pagesize = 2;
    private int pagecount = 0;
    private int recordcount = 0;
    private int currpage = 1;
    public static DataSource ds;

    public int getPagesize() {
        return pagesize;
    }

    public void setPagesize(int pagesize) {
        this.pagesize = pagesize;
    }

    public int getPagecount() {
        return pagecount;
    }

    public void setPagecount(int pagecount) {
        this.pagecount = pagecount;
    }

    public int getRecordcount() {
        return recordcount;
    }

    public void setRecordcount(int recordcount) {
        this.recordcount = recordcount;
    }

    public int getCurrpage() {
        return currpage;
    }

    public void setCurrpage(int currpage) {
        this.currpage = currpage;
    }

    //加载驱动
    public MyUtil() {
        try {
            if (this.ds == null) {
                Context ctx = new InitialContext();
                this.ds = (DataSource) ctx.lookup("java:comp/env/mysql");
            }
            this.conn = ds.getConnection();
        } catch (Exception e) {
            try {
                Class.forName(driver);
                this.conn = DriverManager.getConnection(this.url, this.user, this.password);
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
    }

    public Connection getCon(){
        return conn;
    }
    //链接数据库
    public Connection getConn() {
        try {
            if (this.ds == null) {
                Context ctx = new InitialContext();
                this.ds = (DataSource) ctx.lookup("java:comp/env/mysql");
            }
            this.conn = ds.getConnection();
        } catch (Exception e) {
            try {
                Class.forName(driver);
                this.conn = DriverManager.getConnection(this.url, this.user, this.password);
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        return this.conn;
    }

    //查询表中的数据条数
    public int count(String tablename) {
        int sum = 0;
        String sql = String.format("select count(*) from %s ", tablename);
        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                sum = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sum;
    }
    //查询表中某个行是否存在数据
    public int count(String tablename,String where) {
        int sum = 0;
        String sql = String.format("select count(*) from %s %s", tablename,where);
        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                sum = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sum;
    }

    //判断数据是否存在
    public boolean exists(String tablename, String where) {
        boolean flog = false;
        String sql = String.format("select count(*) from %s %s", tablename, where);
        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                if (rs.getInt(1) > 0) {
                    flog = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flog;
    }

    //修改数据(1)
    public int update(String sql) {
        int num = 0;
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            num = ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return num;
    }

    //修改数据
    public int update(String sql, Object[] data) {
        int num = 0;
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            for (int i = 0; i < data.length; i++) {
                ps.setObject(i + 1, data[i]);
            }
            num = ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return num;
    }

    //查询学生表
  /*  public List<Student> query(String sql) {
        List<Student> stus = new ArrayList<Student>();
        try {
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Student stu = new Student();
                stu.setId(rs.getInt("id"));
                stu.setName(rs.getString("name"));
                stu.setBirthday(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("birthday")));
                stus.add(stu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return stus;
    }*/

    //查询主键
    public String getpk(String tablename) {
        String pk = null;
        String sql = String.format("show full columns from %s", tablename);
        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                if ("PRI".equals(rs.getString("key"))) {
                    pk = rs.getString(1);
                    break;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pk;
    }
//查询数据

    /**
     * tablename    表名
     * fields       需要显示的字段名
     * where        条件
     * order         排序
     * limit        限制行数
     */
    public List<Map<String, Object>> query(String tablename, String fields, String where, String order, String limit) {
        List<Map<String, Object>> list = null;
        String sql = String.format("select %s from %s %s %s %s", fields, tablename, where, order, limit);
        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.isBeforeFirst()) {
                list = new ArrayList<Map<String, Object>>();
              while (rs.next()){
                  ResultSetMetaData rsmd = rs.getMetaData();
                  Map<String,Object> mm = new HashMap<String,Object>();
                  for (int i = 1; i<=rsmd.getColumnCount();i++){
                      String f = rsmd.getColumnLabel(i);
                      mm.put(f,rs.getObject(f));

                  }
              }

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //查询最后插入那条数据的id
    public int getid(){
       int num=0;
       try {
            String pp = "select last_insert_id";
            PreparedStatement pre = this.conn.prepareStatement(pp);
            ResultSet res = pre.executeQuery();
            if (res.isBeforeFirst()){
                while (res.next()){
                    num=(int)res.getInt("last_insert_id()");
                }
            }
       }catch (Exception e){

       }
       return num;

    }

    //查询某个字段的值
    public Object queryBy(String tablename, String fields, String where) {
        Object obj = null;
        String sql = String.format("select %s from %s %s", fields, tablename, where);
        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
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

    //添加数据
   public int insert(String sql, Object[] param) {
        int num = 0;
        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            for (int i = 1; i <= param.length; i++) {
                pst.setObject(i, param[i - 1]);
            }
            num = pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return num;
    }




    //删除数据
    public int delete(String tablename, String where) {
        int num = 0;
        String sql = String.format("delete from %s %s", tablename, where);
        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            num = pst.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return num;
    }

    public int deleteById(String tablename, Object id) {
        int num = 0;
        String sql = String.format("delete from %s where %s=?", tablename, getpk(tablename));
        try {
            PreparedStatement pst = this.conn.prepareStatement(sql);
            pst.setObject(1, id);
            num = pst.executeUpdate();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return num;
    }

    //分页的封装
    public List<Map<String, Object>> page(String tablename, String fields, String where, String order) {
        List<Map<String, Object>> list = null;
        this.recordcount = this.count(tablename,where);
        this.pagecount = this.recordcount % this.pagesize == 0 ? this.recordcount / this.pagesize : this.recordcount / this.pagesize + 1;
        if (this.currpage < 1) {
            this.currpage = 1;
        }
        if (this.currpage > this.pagecount) {
            this.currpage = this.pagecount;
        }
        try {
            String sql = String.format("select %s from %s %s %s limit ?,?", fields, tablename, where, order);
            PreparedStatement pst = this.conn.prepareStatement(sql);
            pst.setInt(1, this.currpage * this.pagesize - this.pagesize);
            pst.setInt(2, this.pagesize);
            ResultSet rs = pst.executeQuery();
            list = new ArrayList<Map<String, Object>>();
            while (rs.next()) {
                ResultSetMetaData rsmd = rs.getMetaData();
                Map<String, Object> mm = new HashMap<String, Object>();
                for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                    String f = rsmd.getColumnLabel(i);
                    mm.put(f, rs.getObject(f));
                }
                list.add(mm);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }


    //百度分页 效果
    public String pageInfo() {
        StringBuilder s = new StringBuilder();
        s.append("<div class=\"page\">");
        int start = 1;
        int end = 0;
        if (pagecount < 3) {
            end=this.pagecount;
        }else{
            end=3;
        }
        if (this.currpage > 1) {
            s.append(String.format("<a href=\"?p=%d\">上页&nbsp;</a>", this.currpage - 1));
        }
        if (this.currpage > 2) {
            if (this.currpage <= this.pagecount - 3) {
                start = this.currpage-1;
            } else {
                start = this.pagecount-2 ;
            }

            if (this.currpage < pagecount - 2) {
                end = this.currpage + 1;
            } else {
                end = this.pagecount;
            }
        }
        for (int i = start; i <= end; i++) {
            if (this.currpage == i) {
                if (i > this.pagecount) {
                    break;
                }
                s.append(String.format("<span>&nbsp;%d&nbsp;</span>", i, i));
                continue;
            }
            s.append(String.format("<a href=\"?p=%d\">&nbsp;%d&nbsp;</a>", i, i));

        }
        if(this.currpage==this.pagecount){
            s.append("</div>");
        }else {
            s.append(String.format("<a href=\"?p=%d\">&nbsp;下页&nbsp;</a>", this.currpage + 1));
            s.append("</div>");
        }
        return s.toString();
    }

    //关闭链接
    public void close() {
        if (this.conn != null) {
            try {
                this.conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    //加密
    public String getpass(String pass, String name) {
        String p = pass + name;
        StringBuilder ps1 = new StringBuilder();
        StringBuilder ps2 = new StringBuilder();
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(p.getBytes());
            for (byte b : md.digest()) {
                ps1.append(String.format("%x", b));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            MessageDigest md = MessageDigest.getInstance("SHA1");
            md.update(p.getBytes());
            for (byte b : md.digest()) {
                ps2.append(String.format("%x", b));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        StringBuilder ps = new StringBuilder();
        ps.append(ps1.subSequence(0, 5));
        ps.append(ps2.subSequence(0, 5));
        ps.append(ps1.subSequence(10, 15));
        ps.append(ps2.subSequence(10, 15));
        ps.append(ps1.subSequence(20, 26));
        ps.append(ps2.subSequence(20, 26));

        return ps.toString();
    }

}