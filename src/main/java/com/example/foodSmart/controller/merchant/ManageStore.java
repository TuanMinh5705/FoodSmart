package com.example.foodSmart.controller.merchant;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.service.AccountService;
import com.example.foodSmart.service.IAccountService;
import com.example.foodSmart.service.admin.CategoryFoodService;
import com.example.foodSmart.service.admin.IMerchantService;
import com.example.foodSmart.service.admin.MerchantService;
import com.example.foodSmart.service.merchant.FoodService;
import com.example.foodSmart.service.merchant.IFoodService;

import javax.servlet.RequestDispatcher;
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
            case "showMerchantStore":
                showMerchantStore(req, resp);
                break;
            case "editMerchantStoreForm":
                showMerchantStoreForm(req, resp);
                break;
                case "editInfoStoreForm":
                showInfoStoreForm(req, resp);
        }
    }

    private void showInfoStoreForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=editInfoStore").forward(req, resp);
    }

    private void showMerchantStoreForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=editMerchantStore").forward(req, resp);

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
            case "editMerchantStore":
                editMerchantStore(req, resp);
                break;
            case "editInfoStore":
                editInfoStore(req,resp);
                break;
        }
    }

    private void editInfoStore(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        MerchantService merchantService = new MerchantService();
        Merchant loggedInMerchant = (Merchant) req.getSession().getAttribute("loggedInMerchant");

        int store_id = loggedInMerchant.getMerchant_id();
        String storeName = req.getParameter("store_name");
        String storeAddress = req.getParameter("store_address");
        String contactNumber = req.getParameter("contact_number");
        String bannerPath = req.getParameter("banner_path");
        String avtPath = req.getParameter("avt_path");
        boolean storeType = Boolean.parseBoolean(req.getParameter("store_type"));
        Merchant updatedMerchant = new Merchant(store_id, storeName, storeAddress, contactNumber, bannerPath, avtPath, storeType);
        merchantService.updateMerchant(updatedMerchant);
        resp.sendRedirect("/manageStore?action=showMerchantStore");
    }





    private void editMerchantStore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AccountService accountService = new AccountService();
        Account loggedInUser = (Account) req.getSession().getAttribute("loggedInAccount");
        int accountId = loggedInUser.getAccountID();
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String avtPath = req.getParameter("avtPath");
        boolean active = Boolean.parseBoolean(req.getParameter("active"));
        String role = loggedInUser.getRole();
        Account updatedAccount = new Account(accountId, username, password, avtPath, role, active);
        accountService.editAccount(updatedAccount);
        resp.sendRedirect("/manageStore?action=showMerchantStore");
    }
}


