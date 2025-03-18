package com.example.foodSmart.controller.merchant;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.Notification;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.user.CartItem;
import com.example.foodSmart.model.user.Complaint;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/manageComplaint")
public class ManageComplaint extends HttpServlet {
    IOrderService orderService = new OrderService();
    IMerchantService merchantService = new MerchantService();
    IAccountService accountService = new AccountService();
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
            case "showComplaintDetail":
                showComplaintDetail(req,resp);
                break;
            default:
                showComplaint(req,resp);
                break;
        }
    }

    private void showComplaintDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
        req.setAttribute("customer", orderAccount);
        req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=complaintDetail").forward(req, resp);
    }

    private void showComplaint(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account loggedInUser = (Account) req.getSession().getAttribute("loggedInAccount");
        int accountId = loggedInUser.getAccountID();
        Merchant merchant = merchantService.getMerchantByMerchantId(accountId);
        List<Order> orderList = orderService.getOrdersByUser("store_id", merchant.getStore_id());
        List<Complaint> complaintList = new ArrayList<>();

        for (Order order : orderList) {
            Complaint complaint = orderService.getComplaint(order.getOrderId());
            if (complaint.getComplaint_id() > 0) {
                complaintList.add(complaint);
            }
        }

        req.setAttribute("complaintList", complaintList);
        req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=manageComplaint").forward(req, resp);
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
            case "feedback" :
                String feedback = req.getParameter("feedback");
                int orderId = Integer.parseInt(req.getParameter("orderId"));
                Order order = orderService.getOrder(orderId);
                Account account1 = accountService.getAccount(order.getUserId());
                notificationDAO.insertNotification(new Notification("Trả lời khiếu nại", "feedbackComplaint", account1));
                orderService.updateComplaints(orderId,feedback);
                break;
        }
    }
}
