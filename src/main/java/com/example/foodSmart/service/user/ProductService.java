package com.example.foodSmart.service.user;

import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.merchant.FoodImages;
import com.example.foodSmart.service.merchant.FoodService;
import com.example.foodSmart.service.merchant.IFoodService;
import com.example.foodSmart.util.ConnectDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductService implements IProductService {

    private static final String GET_PRODUCT_HOT_SALE = "SELECT * FROM ProductSummary ORDER BY total_sold DESC LIMIT 10";
    private static final String RANDOM_PRODUCT_QUERY = "SELECT * FROM ProductSummary ORDER BY RAND() LIMIT 12";
    private static final String PRODUCTS_BY_CATEGORY = "SELECT * FROM ProductSummary WHERE category_id = ?";

    @Override
    public List<Food> getFoodList() {
        return getFoods(GET_PRODUCT_HOT_SALE);
    }

    @Override
    public List<Food> getFoodListRandom() {
        return getFoods(RANDOM_PRODUCT_QUERY);
    }



    @Override
    public List<Food> getFoodListByCategory(int categoryId) {
        List<Food> foodList = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(PRODUCTS_BY_CATEGORY)) {

            ps.setInt(1, categoryId);
            processResultSet(ps, foodList);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return foodList;
    }


    private List<Food> getFoods(String query) {
        List<Food> foodList = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            processResultSet(ps, foodList);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return foodList;
    }
    private void processResultSet(PreparedStatement ps, List<Food> foodList) throws SQLException {
        ResultSet rs = ps.executeQuery();
        IFoodService foodService = new FoodService();

        while (rs.next()) {
            int product_id = rs.getInt("product_id");
            int store_id = rs.getInt("store_id");
            String product_name = rs.getString("product_name");
            int price = rs.getInt("price");
            int stock_quantity = rs.getInt("stock_quantity");
            int discount = rs.getInt("discount");
            int total_sold = rs.getInt("total_sold");
            int category_id = rs.getInt("category_id");

            List<FoodImages> foodImagesList = foodService.listFoodImageStore(product_id);
            Food food = new Food(product_id, store_id, product_name, price, stock_quantity, discount, category_id, total_sold, foodImagesList);
            foodList.add(food);
        }
    }
}
