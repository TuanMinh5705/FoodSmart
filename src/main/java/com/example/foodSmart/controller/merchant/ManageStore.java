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
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;

@WebServlet("/manageStore")
@MultipartConfig
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
                req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=infoStore").forward(req, resp);
                break;
            case "showMerchantStore":
                showMerchantStore(req, resp);
                break;
            case "editMerchantStoreForm":
                showMerchantStoreForm(req, resp);
                break;
                case "editInfoStoreForm":
                    showInfoStore(req,resp);
                showInfoStoreForm(req, resp);
                break;
        }
    }

    private void showInfoStoreForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=editInfoStore").forward(req, resp);
    }

    private void showMerchantStoreForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Account account1 = (Account) session.getAttribute("loggedInAccount");
        Account merchant = accountService.getAccount(account1.getAccountID());
        req.setAttribute("merchant", merchant);
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
                editInfoStore(req,resp);
                break;
            case "editInfoStore":
                editMerchantStore(req, resp);
                break;
        }
    }


    private void editInfoStore(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        int store_id = Integer.parseInt(req.getParameter("store_id"));
        String store_name = req.getParameter("store_name");
        String store_address = req.getParameter("store_address");
        String contact_number = req.getParameter("contact_number");
        Part fileBannerPart = req.getPart("banner_path");
        String banner_path = (fileBannerPart != null && fileBannerPart.getSize() > 0) ? fileBannerPart.getSubmittedFileName() : req.getParameter("current_banner_path");
        Part fileAvatarPart = req.getPart("avt_path");
        String avt_path = (fileAvatarPart != null && fileAvatarPart.getSize() > 0) ? fileAvatarPart.getSubmittedFileName() : req.getParameter("current_avt_path");

        String uploadPath = System.getenv("uploadPath")  + File.separator + "avatars";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        File bannerFile = new File(uploadPath, banner_path);
        File avtFile = new File(uploadPath,avt_path);
        if (!bannerFile.exists()) {
            fileBannerPart.write(uploadPath + File.separator + banner_path);
        }
        if(!avtFile.exists()){
            fileAvatarPart.write(uploadPath + File.separator + avt_path);
        }
        String storeTypeParam = req.getParameter("store_type");
        boolean store_type = Boolean.parseBoolean(storeTypeParam);

        Merchant merchant = new Merchant(store_id, store_name, store_address, contact_number, banner_path, avt_path, store_type);
        boolean success = merchantService.updateMerchant(merchant);
        if (success){
            req.getSession().setAttribute("success", "Cập nhật thông tin cửa hàng thành công!");
        }
        resp.sendRedirect("/manageStore?action=showInfoStore");
    }


    private void editMerchantStore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AccountService accountService = new AccountService();
        Account loggedInUser = (Account) req.getSession().getAttribute("loggedInAccount");
        int accountId = loggedInUser.getAccountID();
        Part filePart = req.getPart("avtPath");
        String avatarPath = (filePart != null && filePart.getSize() > 0)
                ? filePart.getSubmittedFileName() : req.getParameter("currentAvtPath");
        String uploadPath = System.getenv("uploadPath")  + File.separator + "avatars";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        if (filePart != null && filePart.getSize() > 0) {
            File file = new File(uploadDir,avatarPath);
            if(!file.exists()) {
                filePart.write(uploadPath + File.separator + avatarPath);
            }
        }

        String username = req.getParameter("username"),
                password = req.getParameter("password");
        boolean active = "active".equals(req.getParameter("status"));
        Account account = new Account(accountId, username, password, avatarPath, "Merchant", active);
        if (accountService.editAccount(account)) {
            req.getSession().setAttribute("loggedInAccount", account);
            req.getSession().setAttribute("success", "Cập nhật thông tin người dùng thành công!");
        }
        resp.sendRedirect("/manageStore?action=showMerchantStore");
    }
}


