package com.example.foodSmart.controller.user;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.merchant.FoodImages;
import com.example.foodSmart.model.user.CartItem;
import com.example.foodSmart.model.user.Complaint;
import com.example.foodSmart.model.user.Order;
import com.example.foodSmart.service.AccountService;
import com.example.foodSmart.service.IAccountService;
import com.example.foodSmart.service.admin.IMerchantService;
import com.example.foodSmart.service.admin.MerchantService;
import com.example.foodSmart.service.merchant.FoodService;
import com.example.foodSmart.service.merchant.IFoodService;
import com.example.foodSmart.service.user.IOrderService;
import com.example.foodSmart.service.user.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    IOrderService orderService = new OrderService();
    IMerchantService merchantService = new MerchantService();
    IFoodService foodService = new FoodService();
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
            case "showOrderDetail" :
                showOrderDetail(req,resp);
                break;
            case "showComplaint" :
                showComplaint(req,resp);
                break;
            case "cancelOrder" :
                cancelOrder(req,resp);
                break;

            default:
                showOrder(req,resp);
                break;
        }
    }

    private void cancelOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        orderService.updateStatus("shipping_date", "Đã hủy",false, orderId);
        showOrder(req,resp);
    }

    private void showComplaint(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        Order order = orderService.getOrder(orderId);
        Account orderAccount = accountService.getAccount(order.getUserId());
        order.setUsername(orderAccount.getUsername());
        Merchant orderMerchant = merchantService.getMerchantById(order.getStoreId());
        order.setStoreName(orderMerchant.getStore_name());
        int total = 0;
        for (CartItem item : order.getCartItems()) {
            Food food = foodService.getFoodByID(item.getProductId());
            item.setFood(food);
            total += item.getQuantity()*item.getPriceAtTime();
        }
        int shippingCost = 25000;
        int discount = 10000;
        req.setAttribute("total",total + shippingCost - discount);
        req.setAttribute("order", order);
        Complaint complaint = orderService.getComplaint(orderId);
        req.setAttribute("complaint", complaint);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=showComplaint").forward(req, resp);
    }

    private void showOrderDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Order order = orderService.getOrder(id);
        Account orderAccount = accountService.getAccount(order.getUserId());
        order.setUsername(orderAccount.getUsername());
        Merchant orderMerchant = merchantService.getMerchantById(order.getStoreId());
        order.setStoreName(orderMerchant.getStore_name());
        for (CartItem item : order.getCartItems()) {
            Food food = foodService.getFoodByID(item.getProductId());
            item.setFood(food);
        }
        req.setAttribute("order", order);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=showOrderDetail").forward(req, resp);
    }
    private void showOrder(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Account loggedInUser = (Account) req.getSession().getAttribute("loggedInAccount");
        int accountId = loggedInUser.getAccountID();
        List<Order> allOrders = orderService.getOrdersByUser("user_id",accountId);
        Map<Integer, Merchant> merchantMap = new HashMap<>();
        for (Order order : allOrders) {
            Merchant store = merchantService.getMerchantById(order.getStoreId());
            merchantMap.put(order.getOrderId(), store);
        }

        req.setAttribute("orders", allOrders);
        req.setAttribute("merchantMap", merchantMap);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=showOrder").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "complaint" :
                complaint(req,resp);
                break;
        }
    }
    private void complaint(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        String complaint = req.getParameter("complaint");
        Complaint complaint1 = new Complaint(complaint, orderId);
        boolean success = orderService.addComplaints(complaint1);

        if (success) {
            req.getSession().setAttribute("success", "Khiếu nại thành công!");
        } else {
            req.getSession().setAttribute("error", "Khiếu nại thất bại. Vui lòng thử lại!");
        }

        resp.sendRedirect(req.getContextPath() + "/order?action=showOrders");
    }

}
