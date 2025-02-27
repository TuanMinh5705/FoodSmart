package com.example.foodSmart.controller;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.service.AccountService;
import com.example.foodSmart.service.IAccountService;
import com.example.foodSmart.service.admin.IMerchantService;
import com.example.foodSmart.service.admin.MerchantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
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
                login(req, resp);
                break;
            case "register":
                register(req, resp);
                break;
            case "resetPassword":
                resetPassword(req, resp);
                break;
            case "registerStore" :
                registerStore(req, resp);
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
                req.getRequestDispatcher("view/authenticate/forgetPassword.jsp").forward(req, resp);
                break;
            case "registerForm":
                resp.sendRedirect("view/authenticate/register.jsp");
                break;
            case "loginForm":
                resp.sendRedirect("view/authenticate/login.jsp");
                break;
            case "logout":
                HttpSession session = req.getSession(false);
                if (session != null) {
                    session.removeAttribute("loggedInAccount");
                }
                resp.sendRedirect("view/authenticate/login.jsp");
                break;
            case "showFormRegisterStore" :
                resp.sendRedirect("/view/authenticate/registerStore.jsp");
                break;
            case "checkUsername":
                checkUsername(req, resp);
                break;

        }
    }
   // Đăng kí cửa hàng
    private void registerStore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy các giá trị từ form
        String storeName = req.getParameter("store_name");
        String storeAddress = req.getParameter("store_address");
        String contactNumber = req.getParameter("contact_number");
        int merchantId = Integer.parseInt(req.getParameter("merchant_id"));

        Part fileBannerPart = req.getPart("banner_path");
        Part fileAvatarPart = req.getPart("avt_path");

        String banner_path = fileBannerPart.getSubmittedFileName().toString();
        String avt_path = fileAvatarPart.getSubmittedFileName().toString();
        String uploadPath = "C:\\foodSmartImages\\avatars";
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

        Merchant merchant = new Merchant("test",merchantId,storeName,storeAddress,contactNumber,banner_path,avt_path,true);
        IMerchantService merchantService = new MerchantService();
        merchantService.addMerchant(merchant);
        req.getSession().setAttribute("success", "Đăng ký thành công . Chờ xác nhận!");
        resp.sendRedirect("/view/user/homeUser.jsp");
    }
    private void checkUsername(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        boolean isExist = accountService.checkUsername(username);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write("{\"exists\": " + isExist + "}");
    }
    // Đăng nhập vào hệ thống
    public void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Account account = accountService.authenticateLogin(username);

        if (account != null && account.getPassword().equals(password)) {
            HttpSession session = req.getSession();
            session.setAttribute("loggedInAccount", account);

            if (!account.isActive()) {
                session.setAttribute("error", "Tài khoản đã bị khóa");
                resp.sendRedirect("/authenticate?action=loginForm");
                return;
            }

            String role = account.getRole();
            switch (role) {
                case "Admin":
                    resp.sendRedirect("view/admin/homeAdmin.jsp");
                    break;
                case "User":
                    resp.sendRedirect("/homeUser");
                    break;
                case "Merchant":
                    resp.sendRedirect("view/merchant/homeMerchant.jsp");
                    break;
                default:
                    session.setAttribute("error", "Vai trò không xác định");
                    resp.sendRedirect("/authenticate?action=loginForm");
                    break;
            }
        } else {
            req.getSession().setAttribute("error", "Username hoặc password không đúng");
            resp.sendRedirect("/authenticate?action=loginForm");
        }
    }
    // Đăng ký tài khoản
    private void register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part filePart = req.getPart("avt_path");
        String avatarPath = filePart.getSubmittedFileName();
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String phonenumber = req.getParameter("phonenumber");
        String address = req.getParameter("address");

        if (!accountService.checkUsername(username)) {
            AccountDetails accountDetails = new AccountDetails(address, phonenumber);
            Account account = new Account(username, password, avatarPath, "User");
            accountService.authenticateRegister(account, accountDetails);
            req.getSession().setAttribute("success", "Đăng kí thành công !");
            resp.sendRedirect("/authenticate?action=loginForm");
        } else {
            req.getSession().setAttribute("error", "Tài khoản đã tồn tại");
            resp.sendRedirect("/authenticate?action=registerForm");
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
                session.setAttribute("error", "Mã xác minh không đúng, vui lòng thử lại.");
                resp.sendRedirect("/authenticate?action=forgetPasswordForm");
            } else {
                String newPassword = req.getParameter("newPassword");
                accountService.resetPassword(newPassword, username);
                session.setAttribute("success", "Cập nhật mật khẩu thành công. Vui lòng đăng nhập lại!!!");
                resp.sendRedirect("/authenticate?action=loginForm");
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
