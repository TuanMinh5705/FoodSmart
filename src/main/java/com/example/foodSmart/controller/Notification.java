package com.example.foodSmart.controller;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.service.NotificationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/notifications")
public class Notification extends HttpServlet {
    NotificationDAO notificationDAO = new NotificationDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Account account = (Account) session.getAttribute("loggedInAccount");
        List<com.example.foodSmart.model.Notification> notifications =  notificationDAO.selectAllNotification(account.getAccountID());
        System.out.println(notifications);
    }
}
