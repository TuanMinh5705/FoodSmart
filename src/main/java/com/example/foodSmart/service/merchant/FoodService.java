package com.example.foodSmart.service.merchant;

import com.example.foodSmart.model.admin.CategoryFood;
import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.merchant.FoodImages;
import com.example.foodSmart.util.ConnectDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FoodService implements IFoodService {

    private static final String LIST_CATEGORIES_STORE_QUERY = "SELECT c.category_id, c.category_name, c.description, c.avt_path FROM Categories c JOIN categories_stores cs ON c.category_id = cs.category_id WHERE cs.store_id = ?";
    private static final String DELETE_CATEGORY_STORE_QUERY = "DELETE FROM Categories_Stores WHERE store_id = ? AND category_id = ?";
    private static final String ADD_CATEGORY_STORE_QUERY = "INSERT INTO Categories_Stores (store_id, category_id) VALUES (?, ?)";

    private static final String LIST_FOODS_IMAGE_QUERY = "select * from product_images where product_id = ?";
    private static final String LIST_FOODS_STORE_QUERY = "select * from products WHERE store_id = ?";
    private static final String GET_FOODS_QUERY = "SELECT p.product_id,p.product_name,p.price,p.stock_quantity,p.discount,p.store_id,pc.category_id\n" +
            "FROM Products p LEFT JOIN Products_Categories pc ON p.product_id = pc.product_id WHERE p.product_id = ?;";
    private static final  String DELETE_FOOD_IMAGE_QUERY = "DELETE FROM Product_Images WHERE image_id = ?";

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

    @Override
    public int addFood(int storeID, Food food) {
        String sql = "INSERT INTO Products (store_id, product_name, price, stock_quantity, discount) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, storeID);
            ps.setString(2, food.getProduct_name());
            ps.setInt(3, food.getPrice());
            ps.setInt(4, food.getStock_quantity());
            ps.setInt(5, food.getDiscount());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1); // Trả về product_id vừa tạo
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Lỗi
    }

    @Override
    public boolean addFoodImages(int productID, List<FoodImages> foodImages) {
        String sql = "INSERT INTO Product_Images (product_id, image_path, is_primary) VALUES (?, ?, ?)";
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < foodImages.size(); i++) {
                FoodImages img = foodImages.get(i);
                ps.setInt(1, productID);
                ps.setString(2, img.getImage_path());
                ps.setBoolean(3, i == 0);
                ps.addBatch();
            }
            ps.executeBatch();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteFoodImage(int id) {
            try (Connection conn = ConnectDB.getConnection();
                 PreparedStatement ps = conn.prepareStatement(DELETE_FOOD_IMAGE_QUERY)) {
                ps.setInt(1, id);
                return ps.executeUpdate()>0;
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return false;
        }


    @Override
    public Food getFoodByID(int id) {
        Food food = new Food();
        try(Connection conn = ConnectDB.getConnection();
        PreparedStatement ps = conn.prepareStatement(GET_FOODS_QUERY)){
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                int product_id = rs.getInt("product_id");
                String product_name = rs.getString("product_name");
                int price = rs.getInt("price");
                int stock_quantity = rs.getInt("stock_quantity");
                int discount = rs.getInt("discount");
                List<FoodImages> foodImagesList = listFoodImageStore(product_id);
                int store_id = rs.getInt("store_id");
                int category_id = rs.getInt("category_id");
                food = new Food(product_id,store_id,product_name,price,stock_quantity,discount,category_id,foodImagesList);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return food;
    }

    @Override
    public void updateFood(Food food, int category_id, List<FoodImages> foodImages) {
        try(Connection conn = ConnectDB.getConnection();
        PreparedStatement ps = conn.prepareStatement(DELETE_FOOD_IMAGE_QUERY)){
            ps.setString(1,food.getProduct_name());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


}



