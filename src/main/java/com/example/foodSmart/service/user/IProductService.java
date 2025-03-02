package com.example.foodSmart.service.user;

import com.example.foodSmart.model.merchant.Food;

import java.util.List;

public interface IProductService {
    // Danh sách sản phẩm bán chạy
    List<Food> getFoodList();
    // Random 10 sản phẩm
    List<Food> getFoodListRandom();
    // Hiển thị sản phẩm theo danh mục
    List<Food> getFoodListByCategory(int category);
    // Cập nhật số lượng sp
    void updateStockQuantity(int productId, int quantity);
}
