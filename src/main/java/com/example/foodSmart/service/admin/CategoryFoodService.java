package com.example.foodSmart.service.admin;

import com.example.foodSmart.model.admin.CategoryFood;
import com.example.foodSmart.util.ConnectDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryFoodService implements ICategoryFoodService {

    private static final String LIST_CATEGORYS_FOOD_QUERY = "select * from categories ORDER BY category_id DESC";
    private static final String ADD_CATEGORY_FOOD_QUERY = "INSERT INTO categories (category_name, description, avt_path) VALUES (?, ?, ?)";
    private static final String UPDATE_CATEGORY_FOOD_QUERY = "UPDATE categories SET category_name = ?, description = ?, avt_path = ? WHERE category_id = ?";
    private static final String GET_CATEGORY_FOOD_BY_ID_QUERY = "SELECT * FROM categories WHERE category_id = ?";
    private static final String SEARCH_CATEGORY_FOOD_QUERY = "SELECT * FROM categories WHERE category_name LIKE ?";


    @Override
    public List<CategoryFood> listCategoryFood() {
        List<CategoryFood> categoryFoodList = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(LIST_CATEGORYS_FOOD_QUERY)) {
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int category_id = rs.getInt("category_id");
                String category_name = rs.getString("category_name");
                String description = rs.getString("description");
                String avt_path = rs.getString("avt_path");
                CategoryFood categoryFood = new CategoryFood(category_id, category_name, description, avt_path);
                categoryFoodList.add(categoryFood);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return categoryFoodList;
    }

    @Override
    public void addCategoryFood(CategoryFood categoryFood) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(ADD_CATEGORY_FOOD_QUERY)) {
            pstm.setString(1,categoryFood.getCategory_name());
            pstm.setString(2,categoryFood.getDescription());
            pstm.setString(3,categoryFood.getAvt_path());
            pstm.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateCategoryFood(CategoryFood categoryFood) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(UPDATE_CATEGORY_FOOD_QUERY)) {
            pstm.setString(1,categoryFood.getCategory_name());
            pstm.setString(2,categoryFood.getDescription());
            pstm.setString(3,categoryFood.getAvt_path());
            pstm.setInt(4,categoryFood.getCategory_id());
            pstm.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public CategoryFood getCategoryFood(int category_id) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(GET_CATEGORY_FOOD_BY_ID_QUERY)) {
            pstm.setInt(1,category_id);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int category_id1 = rs.getInt("category_id");
                String category_name1 = rs.getString("category_name");
                String description = rs.getString("description");
                String avt_path = rs.getString("avt_path");
                return new CategoryFood(category_id1, category_name1, description, avt_path);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public List<CategoryFood> searchCategoryFoodWithName(String name) {
        List<CategoryFood> categoryFoodList = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(SEARCH_CATEGORY_FOOD_QUERY)) {
            pstm.setString(1,"%"+name+"%");
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int category_id1 = rs.getInt("category_id");
                String category_name1 = rs.getString("category_name");
                String description = rs.getString("description");
                String avt_path = rs.getString("avt_path");
                CategoryFood categoryFood = new CategoryFood(category_id1, category_name1, description, avt_path);
                categoryFoodList.add(categoryFood);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return categoryFoodList;
    }
}


