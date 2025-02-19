package com.example.foodSmart.service.admin;

import com.example.foodSmart.model.admin.CategoryFood;

import java.util.List;

public interface ICategoryFoodService {
    // Danh sách danh mục đồ ăn của hệ thống
    List<CategoryFood> listCategoryFood();

    // Thêm danh mục mới
    void addCategoryFood(CategoryFood categoryFood);

    // Sửa thông tin danh mục
    void updateCategoryFood(CategoryFood categoryFood);

    // Lấy thông tin danh mục bằng id
    CategoryFood getCategoryFood(int category_id);

    // Tìm kiếm danh mục theo tên
    List<CategoryFood> searchCategoryFoodWithName(String name);
}
