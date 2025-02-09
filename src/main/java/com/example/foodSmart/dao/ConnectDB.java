package com.example.foodSmart.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDB {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/SmartFood";
    private static final String DB_USERNAME = System.getenv("DB_USERNAME");
    private static final String DB_PASSWORD = System.getenv("DB_PASSWORD");

    public static Connection getConnection() throws SQLException {
        Connection conn = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            if(DB_USERNAME != null && DB_PASSWORD != null){
                conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
                System.out.println("Connected to database");
            }else {
                System.out.println("Tên hoặc mật khẩu database sai");
            }
        }catch (SQLException e){
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Tải driver lỗi",e);
        }
        return conn;
    }
}
