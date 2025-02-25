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
// Thêm món ăn
    int addFood(int storeID, Food food);
    // Thêm ảnh món ăn
    boolean addFoodImages(int productID, List<FoodImages> foodImages);
    // Cap nhat anh mon ăn
    boolean editFoodImages(FoodImages foodImages);
    // Them mon an vao danh muc
    void addFoodToCategory(int food_id, int category_id);
    // Xoá ảnh món ăn
    boolean deleteFoodImage(int id);
    // Thông tin món ăn
    Food getFoodByID(int id);
    // Cập nhật thông tin món ăn
    void updateFood(Food food, int category_id, List<FoodImages> foodImages);


}
