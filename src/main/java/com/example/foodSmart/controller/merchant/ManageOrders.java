package com.example.foodSmart.controller.merchant;

import com.example.foodSmart.model.user.Order;
import com.example.foodSmart.service.user.IOrderService;
import com.example.foodSmart.service.user.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageOrder")
public class ManageOrders extends HttpServlet {
    IOrderService orderService = new OrderService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            default:
                showListOrder(req,resp);
                break;
        }
    }

    private void showListOrder(HttpServletRequest req, HttpServletResponse resp) {
        List<Order> orderList = orderService.getOrders();
        req.setAttribute("orderList", orderList);

    }
}
