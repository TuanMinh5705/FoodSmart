package com.example.foodSmart.service.user;

import com.example.foodSmart.model.merchant.Food;

import java.util.List;

public interface IProductService {
    // Danh sách sản phẩm bán chạy
    List<Food> getFoodList();
    // Random 10 sản phẩm
    List<Food> getFoodListRandom();
}
