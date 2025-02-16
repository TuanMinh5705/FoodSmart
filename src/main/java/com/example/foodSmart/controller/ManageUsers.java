package com.example.foodSmart.controller;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.service.AccountService;
import com.example.foodSmart.service.IAccountService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.nio.file.Path;
import java.util.List;

@WebServlet("/manageUsers")
@MultipartConfig
public class ManageUsers extends HttpServlet {
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
            case "editForm":
                getInfoAccount(req, resp);
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageUsers_updateInfo").forward(req, resp);
                break;
            case "showInfoForm" :
                getInfoAccount(req,resp);
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageUsers_showInfo").forward(req, resp);
                break;
                case "showAddAccountForm" :
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
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "updateInfoUser":
                updateInfoUser(req, resp);
                break;
            case "deleteDetails":
                deleteDetails(req, resp);
                break;
            case "addUser" :
                addUser(req,resp);
                break;
        }
    }

    private void addUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part filePart = req.getPart("avatar");
        String avatarPath = filePart.getSubmittedFileName();

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String role = req.getParameter("role");
        Account account = new Account(username,password,avatarPath,role);
        AccountDetails accountDetails = new AccountDetails(address,phone);
        accountService.authenticateRegister(account,accountDetails);
        showListUser(req, resp);
    }

    private void deleteDetails(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        boolean delete = accountService.deleteAccountDetails(id);
        if (delete) {
            resp.getWriter().write("success");
        }else {
            resp.getWriter().write("fail");
        }
    }

    private void updateInfoUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int accountID = Integer.parseInt(req.getParameter("accountID"));

        Part filePart = req.getPart("avtPath");
        String avatarPath = (filePart != null && filePart.getSize() > 0) ? filePart.getSubmittedFileName() : req.getParameter("currentAvtPath");


        String username = req.getParameter("username");
        String password = req.getParameter("password");
        boolean active = "active".equals(req.getParameter("status"));
        String role = req.getParameter("role");

        Account account = new Account(accountID, username, password, avatarPath, role, active);
        accountService.editAccount(account);

        String[] accountDetailIDs = req.getParameterValues("accountDetailsID");
        String defaultAddressId = req.getParameter("isDefault");

        if (accountDetailIDs != null) {
            for (String id : accountDetailIDs) {
                String address = req.getParameter("address_" + id);
                String phoneNumber = req.getParameter("phonenumber_" + id);
                address = (address != null) ? address : "";
                phoneNumber = (phoneNumber != null) ? phoneNumber : "";

                boolean isDefault = defaultAddressId != null && defaultAddressId.equals(id);

                AccountDetails detail = new AccountDetails(
                        Integer.parseInt(id),
                        phoneNumber,
                        address,
                        isDefault,
                        accountID
                );
                accountService.editAccountDetails(detail);
            }
        }

        String newAddress = req.getParameter("newAddress");
        String newPhoneNumber = req.getParameter("newPhonenumber");
        Boolean isDefault = "true".equals(req.getParameter("isDefault"));
        if ((newAddress != null && !newAddress.isEmpty()) ||
                (newPhoneNumber != null && !newPhoneNumber.isEmpty()) ||
                isDefault) {
            AccountDetails detail = new AccountDetails(accountID, newAddress, newPhoneNumber, isDefault);
            accountService.addAccountDetails(detail);
        }

        showListUser(req, resp);
    }

    private void getInfoAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int accountID = Integer.parseInt(req.getParameter("accountID"));
        Account account = accountService.getAccount(accountID);
        List<AccountDetails> accountDetails = accountService.getAccountDetails(accountID);
        req.setAttribute("accountDetails", accountDetails);
        req.setAttribute("account", account);
    }

    private void showListUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Account> accountList = accountService.getListOfAccounts();
        req.setAttribute("accountList", accountList);
        req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageUsers").forward(req, resp);
    }
}
