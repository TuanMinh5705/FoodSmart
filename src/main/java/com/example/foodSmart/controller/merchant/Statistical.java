package com.example.foodSmart.controller.merchant;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.service.user.IOrderService;
import com.example.foodSmart.service.user.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet("/statistical")
public class Statistical extends HttpServlet {
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
                showStatistical(req,resp);
                break;
        }
    }

    private void showStatistical(HttpServletRequest req, HttpServletResponse resp) {
        Account loggedInUser = (Account) req.getSession().getAttribute("loggedInAccount");
        try {
            Map<String, Object> stats = orderService.getMerchantStatistics(loggedInUser.getAccountID());

            for (Map.Entry<String, Object> entry : stats.entrySet()) {
                req.setAttribute(entry.getKey(), entry.getValue());
            }
            req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=statistical").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
