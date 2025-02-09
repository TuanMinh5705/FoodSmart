package com.example.foodSmart.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDB {
    private static final String url = "jdbc:oracle:thin:@localhost:1521:orcl";
    private static final String user = "root";
    private static final String pass = "1209";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url,user,pass);
    }
}
