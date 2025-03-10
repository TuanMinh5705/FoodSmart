package com.example.foodSmart.service.user;

import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.user.Order;

import java.util.List;

public interface IOrderService {
    // Thêm đơn hàng mới
    void addOrder(Order order);
    Order getOrder(int id);
    List<Order> getOrders();
    List<Order> getOrdersByUser(String name,int id);
}
