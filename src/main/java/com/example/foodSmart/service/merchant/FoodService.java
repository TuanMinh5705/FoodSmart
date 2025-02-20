package com.example.foodSmart.service.merchant;

import com.example.foodSmart.model.admin.CategoryFood;
import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.merchant.FoodImages;
import com.example.foodSmart.util.ConnectDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FoodService implements IFoodService {

    private static final String LIST_CATEGORIES_STORE_QUERY = "SELECT c.category_id, c.category_name, c.description, c.avt_path FROM Categories c JOIN categories_stores cs ON c.category_id = cs.category_id WHERE cs.store_id = ?";
    private static final String DELETE_CATEGORY_STORE_QUERY = "DELETE FROM Categories_Stores WHERE store_id = ? AND category_id = ?";
    private static final String ADD_CATEGORY_STORE_QUERY = "INSERT INTO Categories_Stores (store_id, category_id) VALUES (?, ?)";

    private static final String LIST_FOODS_IMAGE_QUERY = "select * from product_images where product_id = ?";
    private static final String LIST_FOODS_STORE_QUERY = "select * from products WHERE store_id = ?";

    @Override
    public List<CategoryFood> listCategoriesFoodStore(int store_id) {
        List<CategoryFood> categoryFoodList = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(LIST_CATEGORIES_STORE_QUERY)) {
            pstm.setInt(1, store_id);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int category_id = rs.getInt("category_id");
                String category_name1 = rs.getString("category_name");
                String description = rs.getString("description");
                String avt_path = rs.getString("avt_path");
                CategoryFood categoryFood = new CategoryFood(category_id, category_name1, description, avt_path);
                categoryFoodList.add(categoryFood);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return categoryFoodList;
    }

    @Override
    public void deleteCategoryFoodStore(int store_id, int category_id) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_CATEGORY_STORE_QUERY)) {
            stmt.setInt(1, store_id);
            stmt.setInt(2, category_id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void addCategoryFoodStore(int store_id, int category_id) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(ADD_CATEGORY_STORE_QUERY)) {
            stmt.setInt(1, store_id);
            stmt.setInt(2, category_id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<FoodImages> listFoodImageStore(int product_id) {
        List<FoodImages> foodImagesList = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(LIST_FOODS_IMAGE_QUERY)) {
            pstm.setInt(1, product_id);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int image_id = rs.getInt("image_id");
                String image_path = rs.getString("image_path");
                boolean is_primary = rs.getBoolean("is_primary");
                FoodImages foodImages = new FoodImages(image_id,product_id,image_path,is_primary);
                foodImagesList.add(foodImages);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return foodImagesList;
    }

    @Override
    public List<Food> listFoodStore(int store_id) {
        List<Food> foodList = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(LIST_FOODS_STORE_QUERY)) {
            pstm.setInt(1, store_id);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int product_id = rs.getInt("product_id");
                String product_name = rs.getString("product_name");
                int price = rs.getInt("price");
                int stock_quantity = rs.getInt("stock_quantity");
                int discount = rs.getInt("discount");
                List<FoodImages> foodImagesList = listFoodImageStore(product_id);
                Food food = new Food(product_id, store_id, product_name, price, stock_quantity, discount, foodImagesList);
                foodList.add(food);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return foodList;
    }
}

