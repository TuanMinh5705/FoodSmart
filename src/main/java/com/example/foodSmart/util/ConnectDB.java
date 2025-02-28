package com.example.foodSmart.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDB {
    private static final String URL = "jdbc:mysql://localhost:3306/foodsmart";
//  private static final String USER = System.getenv("DB_USERNAME") ;
//  private static final String PASSWORD = System.getenv("DB_PASSWORD");

      private static final String USER = "root";
    private static final String PASSWORD = "Mot2ba4nam";


    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            return conn;
        } catch (SQLException e) {
            System.err.println("Lỗi kết nối database: " + e.getMessage());
            return null;
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}

