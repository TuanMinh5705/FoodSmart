package com.example.foodSmart.controller.user;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.model.merchant.Coupon;
import com.example.foodSmart.service.AccountService;
import com.example.foodSmart.service.IAccountService;

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

@WebServlet("/userInformation")
@MultipartConfig
public class UserInformation extends HttpServlet {
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
            default:
                showInfoUser(req, resp);
                break;
            case "editUserForm":
                Account account = (Account) req.getSession().getAttribute("loggedInAccount");
                req.setAttribute("account", account);
                showEditUserForm(req, resp);
                break;
            case "showAddressUser":
                showAddressUser(req, resp);
                req.getRequestDispatcher("view/user/homeUser.jsp?page=addressUser").forward(req, resp);
                break;
            case "editAddressForm":
                showEditAddressForm(req, resp);
                break;

        }
    }

    private void showEditAddressForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int accountDetailID = Integer.parseInt(req.getParameter("accountDetailID"));
        Account loggedInUser = (Account) req.getSession().getAttribute("loggedInAccount");
        int accountId = loggedInUser.getAccountID();
        AccountDetails address = accountService.getAccountDetailById(accountDetailID, accountId);
        req.setAttribute("address", address);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=editAddressUser").forward(req, resp);
    }
    private void showAddressUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account loggedInUser = (Account) req.getSession().getAttribute("loggedInAccount");
        if (loggedInUser != null) {
            int accountId = loggedInUser.getAccountID();
            List<AccountDetails> accountDetailsList = accountService.getAccountDetails(accountId);

            req.setAttribute("accountDetailsList", accountDetailsList);
        }
    }
    private void showEditUserForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("view/user/homeUser.jsp?page=editUser").forward(req, resp);

    }
    private void showInfoUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account loggedInUser = (Account) req.getSession().getAttribute("loggedInAccount");
        int merchant_id = loggedInUser.getAccountID();
        Account user = accountService.getAccount(merchant_id);
        req.setAttribute("account", user);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=infoUser").forward(req, resp);
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

            case "editInfoUser":
                editInfoUser(req, resp);
                break;
            case "editAddressUser":
                editAddressUser(req, resp);
                break;
            case "deleteAddress":
                deleteAddressUser(req, resp);
                break;
        }
    }

    private void deleteAddressUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int accountDetailID = Integer.parseInt(req.getParameter("id"));
        accountService.deleteAccountDetails(accountDetailID);
        resp.sendRedirect("/userInformation?action=showAddressUser");
    }
    private void editAddressUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int accountDetailID = Integer.parseInt(req.getParameter("accountDetailID"));
        String address = req.getParameter("address");
        String phonenumber = req.getParameter("phonenumber");
        boolean isDefault = "on".equals(req.getParameter("isDefault"));

        Account loggedInUser = (Account) req.getSession().getAttribute("loggedInAccount");
        int accountId = loggedInUser.getAccountID();

        if (isDefault) {
            accountService.resetDefaultAddress(accountId);
        }

        AccountDetails updatedAddress = new AccountDetails(accountId, accountDetailID, address, phonenumber, isDefault);
        boolean result = accountService.editAccountDetails(updatedAddress);

        if (result) {
            req.getSession().setAttribute("success", "Cập nhật địa chỉ thành công!");
        } else {
            req.getSession().setAttribute("error", "Cập nhật địa chỉ thất bại!");
        }

        resp.sendRedirect("/userInformation?action=showAddressUser");
    }
    private void editInfoUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        IAccountService accountService = new AccountService();
        Account loggedInUser = (Account) req.getSession().getAttribute("loggedInAccount");
        int accountID = loggedInUser.getAccountID();
        Part filePart = req.getPart("avtPath");
        String avatarPath = (filePart != null && filePart.getSize() > 0)
                ? filePart.getSubmittedFileName() : req.getParameter("currentAvtPath");
        String uploadPath = "C:\\foodSmartImages\\avatars";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        if (filePart != null && filePart.getSize() > 0) {
            File file = new File(uploadPath,avatarPath);
            if (!file.exists()){
                filePart.write(uploadPath + File.separator + avatarPath);
            };
        }

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        boolean active = "active".equals(req.getParameter("status"));
        Account account = new Account(accountID, username, password, avatarPath, "User", active);
        if (accountService.editAccount(account)) {
            req.getSession().setAttribute("success", "Cập nhật thông tin người dùng thành công!");
        }
        showInfoUser(req,resp);

    }


}