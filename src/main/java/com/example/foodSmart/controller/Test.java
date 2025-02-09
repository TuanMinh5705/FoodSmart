package com.example.foodSmart.controller;

import com.example.foodSmart.dao.ConnectDB;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet("/test")
public class Test extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Connection conn = ConnectDB.getConnection();
            Statement stmt = conn.createStatement();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
