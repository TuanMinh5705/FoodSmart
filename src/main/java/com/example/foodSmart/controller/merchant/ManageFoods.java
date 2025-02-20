package com.example.foodSmart.controller.merchant;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.admin.CategoryFood;
import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.service.admin.CategoryFoodService;
import com.example.foodSmart.service.admin.ICategoryFoodService;
import com.example.foodSmart.service.admin.IMerchantService;
import com.example.foodSmart.service.admin.MerchantService;
import com.example.foodSmart.service.merchant.FoodService;
import com.example.foodSmart.service.merchant.IFoodService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/manageFoods")
@MultipartConfig
public class ManageFoods extends HttpServlet {
    IMerchantService merchantService = new MerchantService();
    IFoodService foodService = new FoodService();
    ICategoryFoodService categoryFoodService = new CategoryFoodService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        if(action == null){
            action = "";
        }
        int store_id = storeIDByLoggedInUser(req,resp);
        switch (action){
            case "infoCategoryForm":
                getCategoryFoodAction(req,resp);
                req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=infoCategory").forward(req, resp);
                break;
            case "addCategoryForm":
                List<CategoryFood> categoryFoodList = categoryFoodService.listCategoryFood();
                req.setAttribute("categoryFoodList", categoryFoodList);
                req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=addCategory").forward(req, resp);
                break;
            case "getCategory":
                getCategory(req,resp);
                break;
            default:
                listFoodAndCategory(req,resp,store_id);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "addCategory":
                addCategoryFoodAction(req,resp);
                break;
            case "deleteCategory":
                deleteCategoryFood(req,resp);
                break;
            case "search":
                searchCategoryFoodByName(req,resp);
                break;
        }
    }

    private void searchCategoryFoodByName(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<CategoryFood> categoryFoodList = categoryFoodService.searchCategoryFoodWithName(keyword);
        req.setAttribute("categoryFoodList", categoryFoodList);
        req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=manageFoods").forward(req, resp);
    }

    private void deleteCategoryFood(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            int categoryFood_id = Integer.parseInt(req.getParameter("id"));
            int store_id = storeIDByLoggedInUser(req, resp);
            foodService.deleteCategoryFoodStore(store_id, categoryFood_id);
        resp.getWriter().write("success");
    }

    private void addCategoryFoodAction(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int categoryFood_id = Integer.parseInt(req.getParameter("category_id"));
        int store_id = storeIDByLoggedInUser(req,resp);
        foodService.addCategoryFoodStore(store_id,categoryFood_id);
        listFoodAndCategory(req,resp,store_id);
    }

    private void getCategoryFoodAction(HttpServletRequest req, HttpServletResponse resp) {
        int categoryID = Integer.parseInt(req.getParameter("categoryID"));
        CategoryFood categoryFood = categoryFoodService.getCategoryFood(categoryID);
        req.setAttribute("category", categoryFood);
    }

    private void listFoodAndCategory(HttpServletRequest req, HttpServletResponse resp,int store_id) {
   try{
       List<Food> foodList = foodService.listFoodStore(store_id);
       req.setAttribute("foodList", foodList);

       List<CategoryFood> categoryFoodList = foodService.listCategoriesFoodStore(store_id);
       req.setAttribute("categoryFoodList", categoryFoodList);
       req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=manageFoods").forward(req, resp);
   } catch (ServletException | IOException e) {
       throw new RuntimeException(e);
   }
    }
    int storeIDByLoggedInUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account loggedInUser = (Account) req.getSession().getAttribute("loggedInAccount");
        int loggedUserId = 0;
        if (loggedInUser != null) {
            loggedUserId = loggedInUser.getAccountID();
        } else {
            req.setAttribute("error", "Bạn chưa đăng nhập. Vui lòng đăng nhập !!!");
            req.getRequestDispatcher("view/authenticate/login.jsp").forward(req,resp);
            System.out.println("Chưa đăng nhập!");
        }

        int store_id = merchantService.getMerchantByMerchantId(loggedUserId).getStore_id();
        return store_id;
    }

    private void getCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        CategoryFood category = categoryFoodService.getCategoryFood(categoryId);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (category != null) {
            String json = "{"
                    + "\"success\": true,"
                    + "\"imageUrl\": \"" + category.getAvt_path() + "\","
                    + "\"description\": \"" + category.getDescription() + "\""
                    + "}";
            resp.getWriter().write(json);
        } else {
            resp.getWriter().write("{\"success\": false}");
        }
    }
}
