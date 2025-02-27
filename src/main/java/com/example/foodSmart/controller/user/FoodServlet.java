package com.example.foodSmart.controller.user;

import com.example.foodSmart.model.admin.CategoryFood;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.service.admin.CategoryFoodService;
import com.example.foodSmart.service.admin.ICategoryFoodService;
import com.example.foodSmart.service.admin.IMerchantService;
import com.example.foodSmart.service.admin.MerchantService;
import com.example.foodSmart.service.merchant.FoodService;
import com.example.foodSmart.service.merchant.IFoodService;
import com.example.foodSmart.service.user.IProductService;
import com.example.foodSmart.service.user.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/homeUser")
public class FoodServlet extends HttpServlet {
IProductService productService = new ProductService();
ICategoryFoodService categoryFoodService = new CategoryFoodService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "showFoodDetail" :
                int id = Integer.parseInt(req.getParameter("id"));
                IFoodService foodService = new FoodService();
                IMerchantService merchantService = new MerchantService();
                Food food = foodService.getFoodByID(id);
                Merchant merchant = merchantService.getMerchantById(food.getStore_id());
                req.setAttribute("store", merchant);
                req.setAttribute("food", food);
                req.getRequestDispatcher("view/user/homeUser.jsp?page=productDetail").forward(req, resp);
                break;
            case "getFoodsByCategory":
                getFoodsByCategory(req,resp);
                break;
            default:
                showListFood(req,resp);
                break;
        }
    }

    private void getFoodsByCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int category_id = Integer.parseInt(req.getParameter("category_id"));
        List<Food> foodList = productService.getFoodListByCategory(category_id);
        req.setAttribute("foodList", foodList);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=foodsByCategory").forward(req, resp);
    }

    private void showListFood(HttpServletRequest req, HttpServletResponse resp) {
        try{
            List<CategoryFood> categoryFoodList = categoryFoodService.listCategoryFood();
            List<Food> foodListHotSale = productService.getFoodList();
            List<Food> foodListFoodRandom = productService.getFoodListRandom();
            req.setAttribute("categoryFoodList", categoryFoodList);
            req.setAttribute("foodListHotSale", foodListHotSale);
            req.setAttribute("foodListFoodRandom", foodListFoodRandom);
            req.getRequestDispatcher("/view/user/homeUser.jsp").forward(req, resp);
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }
}
