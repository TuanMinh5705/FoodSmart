package com.example.foodSmart.controller.user;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.model.user.CartItem;
import com.example.foodSmart.model.user.Order;
import com.example.foodSmart.service.admin.IMerchantService;
import com.example.foodSmart.service.admin.MerchantService;
import com.example.foodSmart.service.user.IOrderService;
import com.example.foodSmart.service.user.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    IOrderService orderService = new OrderService();
    IMerchantService merchantService = new MerchantService();
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
            case "showOrderDetail" :
                showOrderDetail(req,resp);
                break;
            default:
                showOrder(req,resp);
                break;
        }
    }

    private void showOrderDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderIdParam = req.getParameter("id");
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            resp.sendRedirect("/homeUser");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);
            Order order = orderService.getOrder(orderId);
            if (order == null) {
                resp.sendRedirect("/homeUser");
                return;
            }
            req.setAttribute("order", order);
            req.getRequestDispatcher("view/user/orderDetail.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect("/homeUser");
        }
    }


    private void showOrder(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Order> allOrders = orderService.getOrders();
        Map<Integer, Merchant> merchantMap = new HashMap<>();
        for (Order order : allOrders) {
            Merchant store = merchantService.getMerchantById(order.getStoreId());
            merchantMap.put(order.getOrderId(), store);
        }

        req.setAttribute("orders", allOrders);
        req.setAttribute("merchantMap", merchantMap);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=showOrder")
                .forward(req, resp);
    }




}
