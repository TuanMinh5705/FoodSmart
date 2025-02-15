package com.example.foodSmart.controller;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.service.AccountService;
import com.example.foodSmart.service.IAccountService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/authenticate")
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
            case "forgetPassword":
                login(req,resp);
                break;
                case "registerForm":
                    resp.sendRedirect("view/authenticate/register.jsp");
        }
    }

    public void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Account account = accountService.authenticateAccount(username, password);

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

}
