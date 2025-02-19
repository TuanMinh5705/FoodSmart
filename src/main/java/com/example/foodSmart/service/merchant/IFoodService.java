package com.example.foodSmart.service.merchant;

import com.example.foodSmart.model.admin.CategoryFood;
import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.merchant.FoodImages;

import java.util.List;

public interface IFoodService {
    // Danh sách danh mục của cửa hàng
    List<CategoryFood> listCategoriesFoodStore(int store_id);

    // Xóa danh mục của cửa hàng
    void deleteCategoryFoodStore(int store_id,int category_id);

    // Thêm danh mục mới cho cửa hàng
    void addCategoryFoodStore(int store_id, int category_id);

    // Danh sách ảnh món ăn
    List<FoodImages> listFoodImageStore(int product_id);

    // Danh sách món ăn của cửa hàng
    List<Food> listFoodStore(int store_id);

}
