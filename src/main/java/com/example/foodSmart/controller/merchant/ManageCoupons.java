package com.example.foodSmart.controller.merchant;

import com.example.foodSmart.model.admin.Voucher;
import com.example.foodSmart.model.merchant.Coupon;
import com.example.foodSmart.service.merchant.CouponService;
import com.example.foodSmart.service.merchant.ICouponSerice;
import jdk.internal.access.JavaNetHttpCookieAccess;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/manageCoupons")
public class ManageCoupons extends HttpServlet {
    ICouponSerice couponService = new CouponService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        List<Coupon> couponList = couponService.getListCoupons();
        switch (action) {
            case "addCouponForm":
                req.setAttribute("couponList", couponList);
                req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=addCoupons").forward(req, resp);
                break;
            default:
                listCoupons(req, resp);
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
            case "addCoupon":
                try {
                    addCoupon(req, resp);
                } catch (ParseException e) {
                    throw new RuntimeException(e);
                }
                break;

        }

    }

    private void addCoupon(HttpServletRequest req, HttpServletResponse resp) throws ParseException, ServletException, IOException {
        ManageFoods manageFoods = new ManageFoods();
        Integer store_id = manageFoods.storeIDByLoggedInUser(req, resp);

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
        String coupon_code = req.getParameter("coupon_code");
        int discount_value = Integer.parseInt(req.getParameter("discount_value"));
        Timestamp start_date = new Timestamp(dateFormat.parse(req.getParameter("start_date")).getTime());
        Timestamp end_date = new Timestamp(dateFormat.parse(req.getParameter("end_date")).getTime());
        Time start_time = new Time(timeFormat.parse(req.getParameter("start_time")).getTime());
        Time end_time = new Time(timeFormat.parse(req.getParameter("end_time")).getTime());
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        String description = req.getParameter("description");
        Coupon coupon = new Coupon(store_id,coupon_code,discount_value,start_date,end_date,start_time,end_time,quantity,description);
        couponService.addCoupon(coupon);
        listCoupons(req, resp);
    }


    private void listCoupons(HttpServletRequest req, HttpServletResponse resp) {
        try {
            List<Coupon> couponList = couponService.getListCoupons();
            req.setAttribute("couponList", couponList);
            req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=manageCoupons").forward(req, resp);
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

}
