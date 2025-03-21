package com.example.foodSmart.controller.admin;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.model.user.Order;
import com.example.foodSmart.service.AccountService;
import com.example.foodSmart.service.IAccountService;
import com.example.foodSmart.service.admin.IMerchantService;
import com.example.foodSmart.service.admin.MerchantService;
import com.example.foodSmart.service.user.IOrderService;
import com.example.foodSmart.service.user.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/orderAdmin")
public class ManageOrder extends HttpServlet {
    IMerchantService merchantService = new MerchantService();
    IOrderService orderService = new OrderService();
    IAccountService accountService = new AccountService();
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
                listOrderAdmin(req,resp);
                break;
        }
    }

    private void listOrderAdmin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Merchant> merchantList = merchantService.getListMerchants();
        List<Order> orders = new ArrayList<>();

        for (Merchant merchant : merchantList) {
            List<Order> orderList = orderService.getOrdersByUser("store_id", merchant.getStore_id());

            for (Order order : orderList) {
                Account orderAccount = accountService.getAccount(order.getUserId());
                if (orderAccount != null) {
                    order.setUsername(orderAccount.getUsername());
                }

                Merchant orderMerchant = merchantService.getMerchantById(order.getStoreId());
                if (orderMerchant != null) {
                    order.setStoreName(orderMerchant.getStore_name());
                }

                orders.add(order);
            }
        }

        req.setAttribute("orderList", orders);
        req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageOrders").forward(req, resp);
    }

}
