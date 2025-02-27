package com.example.foodSmart.controller.admin;

import com.example.foodSmart.model.admin.Voucher;
import com.example.foodSmart.service.admin.IVoucherService;
import com.example.foodSmart.service.admin.VoucherService;

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

@WebServlet("/manageVouchers")
public class ManageVouchers extends HttpServlet {
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
        List<Voucher> voucherList = voucherService.getListVouchers();
        switch (action) {
            case "addVoucherForm":
                req.setAttribute("voucherList", voucherList);
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=addVouchers").forward(req, resp);
                break;
            case "editVoucherForm":
                req.setAttribute("voucherList", voucherList);
                getVoucher(req);
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=editVouchers").forward(req, resp);
                break;
            case "infoVoucherForm":
                getVoucher(req);
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=infoVouchers").forward(req, resp);
                break;
            default:
                listVouchers(req, resp);
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
            case "addVoucher":
                addVouchers(req, resp);
                break;
            case "editVoucher":
                editVouchers(req, resp);
                break;
            case "searchVouchers":
                searchVouchersByCode(req, resp);
                break;
        }

    }

    private void searchVouchersByCode(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<Voucher> voucherList = voucherService.getListVoucherByName(keyword);
        req.setAttribute("voucherList", voucherList);
        req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageVouchers").forward(req, resp);
    }

    private void editVouchers(HttpServletRequest req, HttpServletResponse resp) {
        try {
            int voucher_id = Integer.parseInt(req.getParameter("voucher_id"));
            info(req, resp, voucher_id);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
    }

    private void info(HttpServletRequest req, HttpServletResponse resp, int voucher_id) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");

        String voucher_code = req.getParameter("voucher_code");
        int discount_value = Integer.parseInt(req.getParameter("discount_value"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        String description = req.getParameter("description");
        Timestamp start_date = new Timestamp(dateFormat.parse(req.getParameter("start_date")).getTime());
        Timestamp end_date = new Timestamp(dateFormat.parse(req.getParameter("end_date")).getTime());
        Time start_time = new Time(timeFormat.parse(req.getParameter("start_time")).getTime());
        Time end_time = new Time(timeFormat.parse(req.getParameter("end_time")).getTime());
        Voucher voucher = new Voucher(voucher_id, voucher_code, start_date, end_date, start_time, end_time, discount_value, quantity, description);
        boolean success = voucherService.updateVoucher(voucher);
        if (success){
            req.getSession().setAttribute("success", "Cập nhật mã giảm giá thành công!");
        }
        listVouchers(req, resp);
    }

    private void addVouchers(HttpServletRequest req, HttpServletResponse resp) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");

        try {
            String voucher_code = req.getParameter("voucher_code");
            int discount_value = Integer.parseInt(req.getParameter("discount_value"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            String description = req.getParameter("description");
            Timestamp start_date = new Timestamp(dateFormat.parse(req.getParameter("start_date")).getTime());
            Timestamp end_date = new Timestamp(dateFormat.parse(req.getParameter("end_date")).getTime());
            Time start_time = new Time(timeFormat.parse(req.getParameter("start_time")).getTime());
            Time end_time = new Time(timeFormat.parse(req.getParameter("end_time")).getTime());
            Voucher voucher = new Voucher(voucher_code, start_date, end_date, start_time, end_time, quantity, discount_value, description);
            boolean success = voucherService.addVoucher(voucher);
            if (success){
                req.getSession().setAttribute("success", "Thêm mã giảm giá thành công!");
            }
            listVouchers(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void listVouchers(HttpServletRequest req, HttpServletResponse resp) {
        try {
            List<Voucher> voucherList = voucherService.getListVouchers();
            req.setAttribute("voucherList", voucherList);
            req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageVouchers").forward(req, resp);
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void getVoucher(HttpServletRequest req) {
        int voucher_id = Integer.parseInt(req.getParameter("voucherID"));
        Voucher voucher = voucherService.getVoucherById(voucher_id);
        req.setAttribute("voucher", voucher);
    }
}
