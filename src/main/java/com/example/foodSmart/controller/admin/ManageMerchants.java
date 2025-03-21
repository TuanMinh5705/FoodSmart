package com.example.foodSmart.controller.admin;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.service.AccountService;
import com.example.foodSmart.service.IAccountService;
import com.example.foodSmart.service.admin.IMerchantService;
import com.example.foodSmart.service.admin.MerchantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageMerchants")
@MultipartConfig
public class ManageMerchants extends HttpServlet {
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
            case "addMerchantForm":
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=addMerchants").forward(req, resp);
                break;
            case "updateMerchantForm":
                int store_id = Integer.parseInt(req.getParameter("store_id"));
                req.setAttribute("merchant", merchantService.getMerchantById(store_id));
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=updateMerchants").forward(req, resp);
                break;
            case "detail":
                showMerchantDetails(req, resp);
                break;
            case "approveRegistration" :
                List<Merchant> merchants = merchantService.getMerchantsByType(false);
                req.setAttribute("merchants", merchants);
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=approveRegistration").forward(req, resp);
                break;

            default:
                listMerchant(req, resp);
                break;
        }
    }

    private void approveRegistration(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int store_id = Integer.parseInt(req.getParameter("store_id"));
        Merchant merchant = merchantService.getMerchantById(store_id);
        merchant.setStore_type(true);
        Account account = accountService.getAccount(merchant.getMerchant_id());
        account.setRole("Merchant");
        accountService.editAccount(account);
        merchantService.updateMerchant(merchant);
        req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=approveRegistration").forward(req, resp);
    }

    private void showMerchantDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int store_id = Integer.parseInt(req.getParameter("store_id"));
        req.setAttribute("merchant", merchantService.getMerchantById(store_id));
        req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=merchantDetails").forward(req, resp);
    }

    private void listMerchant(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");
        List<Merchant> merchants;

        if ("active".equals(status)) {
            merchants = merchantService.getMerchantsByType(true);
        } else if ("locked".equals(status)) {
            merchants = merchantService.getMerchantsByType(false);
        } else {
            merchants = merchantService.getListMerchants();
        }

        req.setAttribute("merchantsList", merchants);
        req.setAttribute("status", status);
        req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageMerchants").forward(req, resp);
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
            case "approve":
                approveRegistration(req, resp);
                break;
            case "reject":
                reject(req, resp);
                break;
            case "addMerchant":
                addMerchant(req, resp);
                break;
            case "updateMerchant":
                updateMerchant(req, resp);
                break;
            case "searchWithNameMerchant":
                searchMerchant(req, resp);
                break;
        }
    }

    private void reject(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int store_id = Integer.parseInt(req.getParameter("store_id"));
        merchantService.deleteMerchant(store_id);
        req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=approveRegistration").forward(req, resp);
    }

    private void searchMerchant(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<Merchant> merchants = merchantService.searchMerchant(keyword);
        req.setAttribute("merchantsList", merchants);
        req.setAttribute("searchKeyword", keyword);
        req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageMerchants").forward(req, resp);
    }

    private void updateMerchant(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
        File banner = new File(uploadDir, banner_path);
        File avt = new File(uploadDir, avt_path);
        if (!avt.exists()) {
            fileAvatarPart.write(uploadPath + File.separator + avt_path);
        }
        if (!banner.exists()) {
            fileBannerPart.write(uploadPath + File.separator + banner_path);
        }
        String storeTypeParam = req.getParameter("store_type");
        boolean store_type = Boolean.parseBoolean(storeTypeParam);

        Merchant merchant = new Merchant(store_id, store_name, store_address, contact_number, banner_path, avt_path, store_type);
        boolean success = merchantService.updateMerchant(merchant);
        if (success){
            req.getSession().setAttribute("success", "Cập nhật thông tin cửa hàng thành công!");
        }
        listMerchant(req, resp);
    }

    private void addMerchant(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String store_name = req.getParameter("store_name");
        String store_address = req.getParameter("store_address");
        String contact_number = req.getParameter("contact_number");
        Part fileBannerPart = req.getPart("banner_path");
        Part fileAvatarPart = req.getPart("avt_path");

        String banner_path = fileBannerPart.getSubmittedFileName().toString();
        String avt_path = fileAvatarPart.getSubmittedFileName().toString();
        String uploadPath = System.getenv("uploadPath")  + File.separator + "avatars";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        File uploadBanner = new File(uploadPath,banner_path);
        File uploadAvatar = new File(uploadPath,avt_path);
        if (!uploadAvatar.exists()) {
            fileAvatarPart.write(uploadPath + File.separator + avt_path);
        }
        if(!uploadBanner.exists()) {
            fileBannerPart.write(uploadPath + File.separator + banner_path);
        }

        Merchant merchant = new Merchant(store_name, store_address, contact_number, banner_path, avt_path, true);
        boolean success = merchantService.addMerchant(merchant);
        if (success){
            req.getSession().setAttribute("success", "Thêm cửa hàng thành công!");
        }
        listMerchant(req, resp);
    }
}
