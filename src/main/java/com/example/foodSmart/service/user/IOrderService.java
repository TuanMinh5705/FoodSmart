package com.example.foodSmart.service.user;

import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.user.Order;

import java.util.List;
import java.util.Map;

public interface IOrderService {
    // Thêm đơn hàng mới
    void addOrder(Order order);
    Order getOrder(int id);
    List<Order> getOrders();
    List<Order> getOrdersByUser(String name,int id);
    boolean updateStatus(String name , String newStatus, Boolean payment_status, int id);
    void addInvoices(int order_id,int total);
    Map<String, Object> getMerchantStatistics(int merchantId);
}
