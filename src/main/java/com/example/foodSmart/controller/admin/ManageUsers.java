package com.example.foodSmart.controller.admin;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.service.AccountService;
import com.example.foodSmart.service.IAccountService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageUsers")
@MultipartConfig
public class ManageUsers extends HttpServlet {
    IAccountService accountService = new AccountService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            case "editForm":
                getInfoAccount(req, resp);
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageUsers_updateInfo").forward(req, resp);
                break;
            case "showInfoForm":
                getInfoAccount(req, resp);
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageUsers_showInfo").forward(req, resp);
                break;
            case "showAddAccountForm":
                resp.sendRedirect("view/admin/homeAdmin.jsp?page=manageUsers_addAccount");
                break;
            default:
                showListUser(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            case "updateInfoUser":
                updateInfoUser(req, resp);
                break;
            case "deleteDetails":
                deleteDetails(req, resp);
                break;
            case "addUser":
                addUser(req, resp);
                break;
            case "searchWithName":
                getAccountWithName(req, resp);
                break;
            case "addAddress":
                addAddress(req, resp);
                break;
            default:
                showListUser(req,resp);
                break;
        }
    }

    private void addUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part filePart = req.getPart("avatar");
        String avatarPath = filePart.getSubmittedFileName();
        String uploadPath = "C:\\foodSmartImages\\avatars";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        filePart.write(uploadPath + File.separator + avatarPath);

        String username = req.getParameter("username"),
                password = req.getParameter("password"),
                address = req.getParameter("address"),
                phone = req.getParameter("phone"),
                role = req.getParameter("role");
        Account account = new Account(username, password, avatarPath, role);
        AccountDetails accountDetails = new AccountDetails(address, phone);
        if(accountService.authenticateRegister(account, accountDetails)) {
            req.getSession().setAttribute("success", "Thêm người dùng thành công!");
        }
        showListUser(req, resp);
    }

    private void deleteDetails(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        resp.getWriter().write(accountService.deleteAccountDetails(id) ? "success" : "fail");
    }

    private void updateInfoUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int accountID = Integer.parseInt(req.getParameter("accountID"));
        Part filePart = req.getPart("avtPath");
        String avatarPath = (filePart != null && filePart.getSize() > 0)
                ? filePart.getSubmittedFileName() : req.getParameter("currentAvtPath");
        String uploadPath = "C:\\foodSmartImages\\avatars";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        if (filePart != null && filePart.getSize() > 0) {
            filePart.write(uploadPath + File.separator + avatarPath);
        }

        String username = req.getParameter("username"),
                password = req.getParameter("password"),
                role = req.getParameter("role");
        boolean active = "active".equals(req.getParameter("status"));
        Account account = new Account(accountID, username, password, avatarPath, role, active);
        if (accountService.editAccount(account)) {
            req.getSession().setAttribute("success", "Cập nhật thông tin người dùng thành công!");
        }

        String[] accountDetailIDs = req.getParameterValues("accountDetailsID");
        String defaultAddressId = req.getParameter("isDefault");
        if (accountDetailIDs != null) {
            for (String id : accountDetailIDs) {
                String address = req.getParameter("address_" + id);
                String phoneNumber = req.getParameter("phonenumber_" + id);
                boolean isDefault = defaultAddressId != null && defaultAddressId.equals(id);
                AccountDetails detail = new AccountDetails(Integer.parseInt(id),
                        phoneNumber != null ? phoneNumber : "",
                        address != null ? address : "", isDefault, accountID);
                accountService.editAccountDetails(detail);
            }
        }

        String newAddress = req.getParameter("newAddress");
        String newPhoneNumber = req.getParameter("newPhonenumber");
        if ((newAddress != null && !newAddress.isEmpty()) || (newPhoneNumber != null && !newPhoneNumber.isEmpty()) ||
                "true".equals(req.getParameter("isDefault"))) {
            AccountDetails detail = new AccountDetails(accountID, newAddress, newPhoneNumber, "true".equals(req.getParameter("isDefault")));
            accountService.addAccountDetails(detail);
        }
        showListUser(req, resp);
    }

    private void addAddress(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int accountID = Integer.parseInt(req.getParameter("accountID"));
        String newAddress = req.getParameter("newAddress");
        String newPhoneNumber = req.getParameter("newPhonenumber");
        boolean isDefault = "true".equals(req.getParameter("isDefault"));

        AccountDetails detail = new AccountDetails(accountID, newAddress, newPhoneNumber, isDefault);

        if (accountService.addAccountDetails(detail)) {
            int newId = detail.getAccountDetailID();
            String jsonResponse = String.format(
                    "{\"success\": true, \"id\":%d, \"address\":\"%s\", \"phone\":\"%s\", \"isDefault\":%b}",
                    newId, newAddress, newPhoneNumber, isDefault);

            resp.setContentType("application/json");
            resp.getWriter().write(jsonResponse);
        } else {
            resp.setContentType("application/json");
            resp.getWriter().write("{\"success\": false, \"message\":\"fail\"}");
        }
    }


    private void getInfoAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int accountID = Integer.parseInt(req.getParameter("accountID"));
        Account account = accountService.getAccount(accountID);
        List<AccountDetails> accountDetails = accountService.getAccountDetails(accountID);
        req.setAttribute("account", account);
        req.setAttribute("accountDetails", accountDetails);
    }

    private void showListUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Account> accountList = accountService.getListOfAccounts();
        req.setAttribute("accountList", accountList);
        req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageUsers").forward(req, resp);
    }

    private void getAccountWithName(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<Account> accountList = accountService.getListAccountByUsername(keyword);
        req.setAttribute("accountList", accountList);
        req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageUsers").forward(req, resp);
    }
}
