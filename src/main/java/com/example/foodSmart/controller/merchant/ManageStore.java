package com.example.foodSmart.controller.merchant;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.service.AccountService;
import com.example.foodSmart.service.IAccountService;
import com.example.foodSmart.service.admin.IMerchantService;
import com.example.foodSmart.service.admin.MerchantService;
import com.example.foodSmart.service.merchant.FoodService;
import com.example.foodSmart.service.merchant.IFoodService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/manageStore")
public class ManageStore extends HttpServlet {
    IMerchantService merchantService = new MerchantService();
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
            case "showInfoStore":
                showInfoStore(req, resp);
                break;
            case "showMerchantStore" :
                showMerchantStore(req, resp);
                break;
        }
    }

    private void showMerchantStore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account loggedInUser = (Account) req.getSession().getAttribute("loggedInAccount");
        int merchant_id = loggedInUser.getAccountID();
        Account merchant = accountService.getAccount(merchant_id);
        req.setAttribute("merchant", merchant);
        req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=infoMerchantStore").forward(req, resp);
    }

    private void showInfoStore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ManageFoods manageFoods = new ManageFoods();
        int store_id = manageFoods.storeIDByLoggedInUser(req, resp);
        Merchant store = merchantService.getMerchantById(store_id);
        req.setAttribute("store", store);
        req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=infoStore").forward(req, resp);
    }
}
