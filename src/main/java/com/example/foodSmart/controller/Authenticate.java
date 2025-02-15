package com.example.foodSmart.controller;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.service.AccountService;
import com.example.foodSmart.service.IAccountService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet("/authenticate")
@MultipartConfig
public class Authenticate extends HttpServlet {
    IAccountService accountService = new AccountService();
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
            case "login":
                login(req,resp);
                break;
            case "register":
                register(req, resp);
                break;
            case "resetPassword":
                resetPassword(req, resp);
                break;
        }
    }
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
            case "forgetPasswordForm":
                String captcha = generateCaptcha();
                req.getSession().setAttribute("captcha", captcha);
                req.setAttribute("captchaText", captcha);
                req.getRequestDispatcher("view/authenticate/forgetPassword.jsp").forward(req, resp);
                break;
                case "registerForm":
                    resp.sendRedirect("view/authenticate/register.jsp");
                    break;
            case "loginForm":
                resp.sendRedirect("view/authenticate/login.jsp");
                break;
            case "logout" :
                HttpSession session = req.getSession(false);
                if (session != null) {
                    session.removeAttribute("loggedInAccount");
                }
                resp.sendRedirect("view/authenticate/login.jsp");
                break;
        }
    }

    // Đăng nhập vào hệ thống
    public void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Account account = accountService.authenticateLogin(username, password);

        if (account != null) {
            HttpSession session = req.getSession();
            session.setAttribute("loggedInAccount", account);

            if (!account.isActive()) {
                req.setAttribute("error", "Tài khoản đã bị khóa");
                req.getRequestDispatcher("view/authenticate/login.jsp").forward(req, resp);
                return;
            }
            String role = account.getRole();
            switch (role) {
                case "Admin":
                    req.getRequestDispatcher("view/admin/homeAdmin.jsp").forward(req, resp);
                    break;
                case "User":
                    req.getRequestDispatcher("view/user/homeUser.jsp").forward(req, resp);
                    break;
                case "Merchant":
                    req.getRequestDispatcher("view/merchant/homeMerchant.jsp").forward(req, resp);
                    break;
                default:
                    req.setAttribute("error", "Vai trò không xác định");
                    req.getRequestDispatcher("view/authenticate/login.jsp").forward(req, resp);
                    break;
            }
        } else {
            req.setAttribute("error", "Username hoặc password không đúng");
            req.getRequestDispatcher("view/authenticate/login.jsp").forward(req, resp);
        }
    }

    // Đăng kí tài khoản
    private void register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part filePart = req.getPart("avt_path");
        String avatarPath = filePart.getSubmittedFileName();
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String phonenumber = req.getParameter("phonenumber");
        String address = req.getParameter("address");
        if (!accountService.checkUsername(username)) {
            AccountDetails accountDetails = new AccountDetails(address, phonenumber);
            Account account = new Account(username, password, avatarPath);
            accountService.authenticateRegister(account, accountDetails);
            req.setAttribute("success", "Đăng kí thành công . Vui lòng đăng nhập lại");
            req.getRequestDispatcher("view/authenticate/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Tài khỏan đã tồn tại");
            req.getRequestDispatcher("view/authenticate/register.jsp").forward(req, resp);
        }
    }

    // Quên mật khẩu
    private void resetPassword(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String userCaptcha = req.getParameter("captchaInput");
        String username = req.getParameter("username");
        HttpSession session = req.getSession();
        String sessionCaptcha = (String) session.getAttribute("captcha");
        if (accountService.checkUsername(username)) {
            if (sessionCaptcha == null || !sessionCaptcha.equals(userCaptcha)) {
                req.setAttribute("error", "Mã xác minh không đúng , vui lòng thử lại.");
                req.getRequestDispatcher("/view/authenticate/forgetPassword.jsp").forward(req, resp);
            } else {
                String newPassword = req.getParameter("newPassword");
                accountService.resetPassword(newPassword, username);
                req.setAttribute("success", "Cập nhật mật khẩu thành công . Vui lòng đăng nhập lại!!!");
                req.getRequestDispatcher("/view/authenticate/login.jsp").forward(req, resp);
            }
        }
    }

    private String generateCaptcha() {
        int length = 6;
        String chars = "ABCDEFGHJKLMabcdefghjklm0123456789";
        StringBuilder captcha = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(chars.length());
            char randomChar = chars.charAt(randomIndex);
            captcha.append(randomChar);
        }
        return captcha.toString();
    }
}

