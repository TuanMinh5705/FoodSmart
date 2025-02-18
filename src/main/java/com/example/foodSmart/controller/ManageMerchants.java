package com.example.foodSmart.controller;

import com.example.foodSmart.model.Merchant;
import com.example.foodSmart.service.IMerchantService;
import com.example.foodSmart.service.MerchantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageMerchants")
@MultipartConfig
public class ManageMerchants extends HttpServlet {
    IMerchantService merchantService = new MerchantService();

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
            default:
                listMerchant(req, resp);
                break;
        }
    }

    private void showMerchantDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int store_id = Integer.parseInt(req.getParameter("store_id"));
        req.setAttribute("merchant", merchantService.getMerchantById(store_id));
        req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=merchantDetails").forward(req, resp);
    }

    private void listMerchant(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Merchant> merchants = merchantService.getListMerchants();
        req.setAttribute("merchantsList", merchants);
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
            case "addMerchant":
                addMerchant(req, resp);
                break;
            case "updateMerchant":
                updateMerchant(req, resp);
                break;
        }
    }

    private void updateMerchant(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int store_id = Integer.parseInt(req.getParameter("store_id"));
        String store_name = req.getParameter("store_name");
        String store_address = req.getParameter("store_address");
        String contact_number = req.getParameter("contact_number");


        Part fileBannerPart = req.getPart("banner_path");
        String banner_path = (fileBannerPart != null && fileBannerPart.getSize() > 0) ? fileBannerPart.getSubmittedFileName() : req.getParameter("current_banner_path");;

        Part fileAvatarPart = req.getPart("avt_path");
        String avt_path = (fileAvatarPart != null && fileAvatarPart.getSize() > 0) ? fileAvatarPart.getSubmittedFileName() : req.getParameter("current_avt_path");;

        boolean store_type = Boolean.parseBoolean(req.getParameter("store_type"));
        Merchant merchant = new Merchant(store_id ,store_name, store_address, contact_number, banner_path, avt_path, store_type);
        merchantService.updateMerchant(merchant);
        listMerchant(req, resp);
    }

    private void addMerchant(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String store_name = req.getParameter("store_name");
        String store_address = req.getParameter("store_address");
        String contact_number = req.getParameter("contact_number");
        String banner_path = req.getParameter("banner_path");
        String avt_path = req.getParameter("avt_path");
        boolean store_type = Boolean.parseBoolean(req.getParameter("store_type"));
        Merchant merchant = new Merchant(store_name, store_address, contact_number, banner_path, avt_path, store_type);
        merchantService.addMerchant(merchant);
        listMerchant(req, resp);

    }
}
