package com.example.foodSmart.controller.merchant;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.user.CartItem;
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
import java.io.IOException;
import java.util.List;

@WebServlet("/manageOrder")
public class ManageOrders extends HttpServlet {
    IOrderService orderService = new OrderService();
    IAccountService accountService = new AccountService();
    IMerchantService merchantService = new MerchantService();
    IFoodService foodService = new FoodService();

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
                showOrderDetail(req,resp);
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
        IMerchantService merchantService = new MerchantService();
        Merchant merchant = merchantService.getMerchantByMerchantId(accountId);
        List<Order> orderList = orderService.getOrdersByUser("store_id",merchant.getStore_id());

        for (Order order : orderList) {
            Account orderAccount = accountService.getAccount(order.getUserId());
            order.setUsername(orderAccount.getUsername());
            Merchant orderMerchant = merchantService.getMerchantById(order.getStoreId());
            order.setStoreName(orderMerchant.getStore_name());
        }
        req.setAttribute("orderList", orderList);
        req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=manageOrders").forward(req, resp);
    }

}
