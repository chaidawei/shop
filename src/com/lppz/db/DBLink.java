package com.lppz.db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBLink {
    private String driver = "com.mysql.jdbc.Driver";
    private String url = "jdbc:mysql://localhost:3306/lppz?useUnicode=true&characterEncoding=utf8&useSSL=true";
    private String user = "root";
    private String password = "";
    private Connection conn  = null;

    public Connection getConn() {
        return conn;
    }

    public DBLink() {
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url,user,password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void open(){
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url,user,password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void close(){
        if(conn != null){
            try {
                if(!conn.isClosed()){
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
