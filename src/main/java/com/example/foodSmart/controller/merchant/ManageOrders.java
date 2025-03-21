package com.example.foodSmart.controller.merchant;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.Notification;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.user.CartItem;
import com.example.foodSmart.model.user.Order;
import com.example.foodSmart.service.AccountService;
import com.example.foodSmart.service.IAccountService;
import com.example.foodSmart.service.NotificationDAO;
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
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/manageOrder")
public class ManageOrders extends HttpServlet {
    IOrderService orderService = new OrderService();
    IAccountService accountService = new AccountService();
    IMerchantService merchantService = new MerchantService();
    IFoodService foodService = new FoodService();
NotificationDAO notificationDAO = new NotificationDAO();
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
            case "showOrderDetail":
                showOrderDetail(req, resp);
                break;
            default:
                showListOrder(req, resp);
                break;
        }
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
        req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=orderDetail").forward(req, resp);
    }

    private void showListOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account loggedInUser = (Account) req.getSession().getAttribute("loggedInAccount");
        int accountId = loggedInUser.getAccountID();
        Merchant merchant = merchantService.getMerchantByMerchantId(accountId);
        List<Order> orderList = orderService.getOrdersByUser("store_id", merchant.getStore_id());

        for (Order order : orderList) {
            Account orderAccount = accountService.getAccount(order.getUserId());
            order.setUsername(orderAccount.getUsername());
            Merchant orderMerchant = merchantService.getMerchantById(order.getStoreId());
            order.setStoreName(orderMerchant.getStore_name());
        }
        req.setAttribute("orderList", orderList);
        req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=manageOrders").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        String newStatus = req.getParameter("status");
        Order order = orderService.getOrder(orderId);
        PrintWriter out = resp.getWriter();
        if (orderId == 0 || newStatus == null) {
            out.write("{\"status\":\"error\",\"message\":\"Invalid Request\"}");
            out.flush();
            return;
        }
        boolean success = false;
        switch (newStatus) {
            case "Đang giao":
                success = orderService.updateStatus("shipping_date", newStatus,order.getPaymentStatus(), orderId);
                notificationDAO.insertNotification(new Notification("Đơn hàng đang giao.", "orderAccepted", accountService.getAccount(order.getUserId())));
                break;
            case "Đã hủy" :
                success = orderService.updateStatus("shipping_date", newStatus,order.getPaymentStatus(), orderId);
                notificationDAO.insertNotification(new Notification("Đơn hàng bị hủy.", "canceledOrder", accountService.getAccount(order.getUserId())));
                break;
            case "Hoàn thành":
                success = orderService.updateStatus("delivery_date", newStatus,true, orderId);
                int total = 0;
                List<CartItem> cartItems = order.getCartItems();
                for (CartItem cartItem : cartItems) {
                    total += cartItem.getPriceAtTime() * cartItem.getQuantity();
                }
                int shippingCost = 25000;
                int discount = 10000;
                notificationDAO.insertNotification(new Notification("Đơn hàng đã đến.", "orderDone", accountService.getAccount(order.getUserId())));
                orderService.addInvoices(orderId,total + shippingCost - discount);
                break;
        }

        if (success) {
            out.write("{\"status\":\"success\",\"message\":\"Cập nhật đơn hàng thành công\"}");
        } else {
            out.write("{\"status\":\"error\",\"message\":\"Có lỗi khi xử lý\"}");
        }
        out.flush();

    }
}
