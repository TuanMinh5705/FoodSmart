package com.example.foodSmart.service.user;

import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.user.Order;

public interface IOrderService {
    // Thêm đơn hàng mới
    void addOrder(Order order);
}
