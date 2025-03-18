package com.example.foodSmart.controller.user;

import com.example.foodSmart.model.admin.Voucher;
import com.example.foodSmart.model.merchant.Coupon;
import com.example.foodSmart.service.admin.IVoucherService;
import com.example.foodSmart.service.admin.VoucherService;
import com.example.foodSmart.service.merchant.CouponService;
import com.example.foodSmart.service.merchant.ICouponSerice;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

    @WebServlet("/voucher")
public class VoucherServlet extends HttpServlet {
    ICouponSerice couponService = new CouponService();
    IVoucherService voucherService = new VoucherService();

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

            case "displayVouchers":
                displayVouchers(req, resp);
        }
    }

    private void displayVouchers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Coupon> couponList = couponService.getListCoupon();
        List<Voucher> voucherList = voucherService.getListVouchers();

        req.setAttribute("couponList", couponList);
        req.setAttribute("voucherList", voucherList);

        req.getRequestDispatcher("view/user/homeUser.jsp?page=displayVouchers").forward(req, resp);
    }


}
