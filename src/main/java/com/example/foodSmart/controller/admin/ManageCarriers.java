package com.example.foodSmart.controller.admin;

import com.example.foodSmart.model.admin.Carrier;
import com.example.foodSmart.model.admin.Shipper;
import com.example.foodSmart.service.admin.CarrierService;
import com.example.foodSmart.service.admin.ICarrierService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import static java.lang.Integer.parseInt;

@WebServlet("/manageCarriers")
public class ManageCarriers extends HttpServlet {
    ICarrierService carrierService = new CarrierService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        if(action == null){
            action = "";
        }
        switch (action){
            case "editCarrierForm":
                getCarrier(req,resp);
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=editCarriers").forward(req, resp);
                break;
                case "infoCarrierForm":
                    getCarrier(req,resp);
                    req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=infoCarriers").forward(req, resp);
                    break;
            case "addCarrierForm" :
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=addCarriers").forward(req, resp);
                break;
            case "editShipperForm":
                getShipper(req,resp);
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=editShippers").forward(req, resp);
                break;
                case "infoShipperForm":
                    getShipper(req,resp);
                    req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=infoShippers").forward(req, resp);
                    break;
            case "addShipperForm":
                List<Carrier> carriers = carrierService.getListCarriers();
                req.setAttribute("carriersList", carriers);
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=addShippers").forward(req, resp);
                break;
            default:
                listCarriers(req,resp);
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
            case "editCarrier" :
                editCarrier(req,resp);
                break;
                case "addCarrier" :
                    addCarriers(req,resp);
                    break;
            case "editShipper" :
                editShipper(req,resp);
                break;
            case "addShipper" :
                addShippers(req,resp);
                break;
        }
    }

    private void addShippers(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String shipperName = req.getParameter("shipperName");
        String phoneNumber = req.getParameter("phoneNumber");
        int carrierId = parseInt(req.getParameter("carrierId"));
        Shipper shipper = new Shipper(phoneNumber,shipperName);
        carrierService.addShipper(shipper,carrierId);
        req.getSession().setAttribute("success", "Thêm nhân viên vận chuyển thành công!");
        resp.sendRedirect("manageCarriers");
    }

    private void editShipper(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int shipperId = parseInt(req.getParameter("shipperId"));
        String shipperName = req.getParameter("shipperName");
        String phoneNumber = req.getParameter("phoneNumber");
        int carrierId = parseInt(req.getParameter("carrierId"));
        Carrier carrier = carrierService.getCarrier(carrierId);
        Shipper shipper = new Shipper(shipperId,shipperName,phoneNumber,carrier.getCarrier_name());
        carrierService.updateShipper(shipper,carrierId);
        req.getSession().setAttribute("success", "Cập nhật thông tin nhân viên vận chuyển thành công!");
        resp.sendRedirect("manageCarriers");
    }

    private void addCarriers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        int cost = parseInt(req.getParameter("cost"));
        Carrier carrier = new Carrier(name, phone, cost);
        carrierService.addCarrier(carrier);
        req.getSession().setAttribute("success", "Thêm đối tác vận chuyển thành công!");
        resp.sendRedirect("/manageCarriers");
    }
    private void editCarrier(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String carrierName = req.getParameter("name");
        String contact_phone = req.getParameter("phone");
        int shipping_cost = parseInt(req.getParameter("cost"));
        int carrier_id = parseInt(req.getParameter("carrierId"));
        Carrier carrier = new Carrier(carrier_id, carrierName, contact_phone, shipping_cost);
        carrierService.updateCarrier(carrier);
            req.getSession().setAttribute("success", "Cập nhật thông tin đối tác vận chuyển thành công!");
        resp.sendRedirect("/manageCarriers");
    }
    private void listCarriers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Carrier> carriers = carrierService.getListCarriers();
        List<Shipper> shipperList = carrierService.getListShippers();
        req.setAttribute("shippersList", shipperList);
        req.setAttribute("carriersList", carriers);
        req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageCarriers").forward(req,resp);
    }
    private void getCarrier(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int carrierId = parseInt(req.getParameter("id"));
        Carrier carrier = carrierService.getCarrier(carrierId);
        req.setAttribute("carrier", carrier);
    }
    private void getShipper(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = parseInt(req.getParameter("id"));
        Shipper shipper = carrierService.getShipper(id);
        req.setAttribute("shipper", shipper);
        List<Carrier> carriers = carrierService.getListCarriers();
        req.setAttribute("carriersList", carriers);
    }
}
