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

public class ProductSerive implements IProductService {
    private static final String GET_PRODUCT_HOT_SALE = "SELECT p.*, SUM(po.quantity) AS total_sold, c.category_id FROM Products p\n" +
            "    JOIN Products_Orders po ON p.product_id = po.product_id\n" +
            "    LEFT JOIN Products_Categories pc ON p.product_id = pc.product_id\n" +
            "    LEFT JOIN Categories c ON pc.category_id = c.category_id\n" +
            "GROUP BY p.product_id, p.product_name, p.price, c.category_id\n" +
            "ORDER BY total_sold DESC LIMIT 10;";
    private static final String RANDOM_PRODUCT_QUERY = "SELECT p.*,c.category_id,SUM(po.quantity) AS total_sold FROM Products p\n" +
            "LEFT JOIN Products_Orders po ON p.product_id = po.product_id\n" +
            "    LEFT JOIN Products_Categories pc ON p.product_id = pc.product_id\n" +
            "    LEFT JOIN Categories c ON pc.category_id = c.category_id\n" +
            "    GROUP BY p.product_id, p.product_name, p.price, c.category_id\n" +
            "ORDER BY RAND() LIMIT 12";

    @Override
    public List<Food> getFoodList() {
        return getFoods(GET_PRODUCT_HOT_SALE);
    }
    @Override
    public List<Food> getFoodListRandom() {
        return getFoods(RANDOM_PRODUCT_QUERY);
    }

    private static List<Food> getFoods(String query) {
        List<Food> foodList = new ArrayList<Food>();
        try(Connection conn = ConnectDB.getConnection();
            PreparedStatement ps = conn.prepareStatement(query)){
            ResultSet rs = ps.executeQuery();
            Food food = null;
            IFoodService foodService = new FoodService();
            while (rs.next()){
                int product_id = rs.getInt("product_id");
                int store_id = rs.getInt("store_id");
                String product_name = rs.getString("product_name");
                int price = rs.getInt("price");
                int stock_quantity = rs.getInt("stock_quantity");
                int discount = rs.getInt("discount");
                int total_sold = rs.getInt("total_sold");
                int category_id = rs.getInt("category_id");
                List<FoodImages> foodImagesList = foodService.listFoodImageStore(product_id);
                food = new Food(product_id,store_id,product_name,price,stock_quantity,discount,category_id,total_sold,foodImagesList);
                foodList.add(food);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return foodList;
    }


}
