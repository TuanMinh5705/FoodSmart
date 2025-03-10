package com.example.foodSmart.controller.user;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.merchant.FoodImages;
import com.example.foodSmart.model.user.CartItem;
import com.example.foodSmart.model.user.Order;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    IOrderService orderService = new OrderService();
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
            List<Map<String, Object>> orderDetails = new ArrayList<>();

            for (CartItem cartItem : order.getCartItems()) {
                Food food = foodService.getFoodByID(cartItem.getProductId());
                if (food != null) {
                    Map<String, Object> detail = new HashMap<>();
                    detail.put("productName", food.getProduct_name());
                    detail.put("priceAtTime", cartItem.getPriceAtTime());
                    detail.put("quantity", cartItem.getQuantity());
                    String primaryImage = "../../../image/product_default.png";
                    if (food.getList_food_images() != null) {
                        for (FoodImages fi : food.getList_food_images()) {
                            if (fi.isIs_primary()) {
                                primaryImage = fi.getImage_path();
                                break;
                            }
                        }
                    }
                    detail.put("productImage", primaryImage);

                    orderDetails.add(detail);
                }
            }

            req.setAttribute("order", order);
            req.setAttribute("foodList", orderDetails);
            req.getRequestDispatcher("view/user/homeUser.jsp?page=showOrderDetail").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect("/homeUser");
        }
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
        req.getRequestDispatcher("view/user/homeUser.jsp?page=showOrder")
                .forward(req, resp);
    }
}
