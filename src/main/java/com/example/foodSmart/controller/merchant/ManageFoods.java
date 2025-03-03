package com.example.foodSmart.controller.merchant;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.admin.CategoryFood;
import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.merchant.FoodImages;
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
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
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
            case "addFoodForm":
                List<CategoryFood> categoryStoreList = foodService.listCategoriesFoodStore(store_id);
                req.setAttribute("categoryStoreList", categoryStoreList);
                req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=addFood").forward(req, resp);
                break;
            case "editProductForm" :
                List<CategoryFood> categoryFoodList = foodService.listCategoriesFoodStore(store_id);
                req.setAttribute("categoryFoodList", categoryFoodList);
                showEditFoodForm(req,resp);
                break;
            case "infoCategoryForm":
                getCategoryFoodAction(req,resp);
                req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=infoCategory").forward(req, resp);
                break;
            case "addCategoryForm":
                List<CategoryFood> categoryFoodList1 = categoryFoodService.listCategoryFood();
                req.setAttribute("categoryFoodList", categoryFoodList1);
                req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=addCategory").forward(req, resp);
                break;
            case "getCategory":
                getCategory(req,resp);
                break;
            case "infoProductForm":
                int id = Integer.parseInt(req.getParameter("productID"));
                Food food = foodService.getFoodByID(id);
                req.setAttribute("food", food);
                CategoryFood categoryFood = categoryFoodService.getCategoryFood(food.getCategory_id());
                req.setAttribute("categoryFood", categoryFood);
                req.setAttribute("page", "infoFood");
                req.getRequestDispatcher("view/merchant/homeMerchant.jsp").forward(req, resp);
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
            case "addFood":
                addFood(resp, req);
                break;
            case "updateFood":
                updateFoodAction(req,resp);
                break;
            case "deleteImage" :
                int imageId = Integer.parseInt(req.getParameter("id"));
                boolean deleted = foodService.deleteFoodImage(imageId);
                resp.getWriter().write(deleted ? "success" : "fail");
                break;
            case "deleteFood" :
                int id = Integer.parseInt(req.getParameter("id"));
                boolean success = foodService.deleteFood(id);
                resp.getWriter().write(success ? "success" : "fail");

        }
    }
    private void updateFoodAction(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int product_id = Integer.parseInt(req.getParameter("product_id"));
        int store_id = storeIDByLoggedInUser(req, resp);

        Food food = foodService.getFoodByID(product_id);
        List<FoodImages> foodImagesList = food.getList_food_images();
        List<FoodImages> newImageList = new ArrayList<>();

        String uploadPath = "C:\\foodSmartImages\\product";
        new File(uploadPath).mkdirs();

        for (FoodImages img : foodImagesList) {
            Part part = req.getPart("img_path_" + img.getImage_id());
            if (part != null && part.getSize() > 0) {
                String newFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                File file = new File(uploadPath,newFileName);
                if(!file.exists()){
                    part.write(uploadPath + File.separator + newFileName);
                }
                img.setImage_path(newFileName);
                foodService.editFoodImages(img);
            }
        }

        for (Part part : req.getParts()) {
            if ("product_images".equals(part.getName()) && part.getSize() > 0) {
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                File file = new File(uploadPath,fileName);
                if(!file.exists()){
                    part.write(uploadPath + File.separator + fileName);
                }
                FoodImages newImage = new FoodImages(product_id, fileName, false);
                if (foodService.editFoodImages(newImage)) {
                    newImageList.add(newImage);
                    foodImagesList.add(newImage);
                }
            }
        }

        String primaryImageParam = req.getParameter("primary_image");
        if (primaryImageParam != null && !primaryImageParam.trim().isEmpty()) {
            try {
                int primaryImageId = Integer.parseInt(primaryImageParam);
                for (FoodImages img : foodImagesList) {
                    if (img.getImage_id() > 0) {
                        img.setIs_primary(img.getImage_id() == primaryImageId);
                        foodService.editFoodImages(img);
                    }
                }
            } catch (NumberFormatException ignored) {
            }
        }
        food.setProduct_name(req.getParameter("product_name"));
        food.setPrice(Integer.parseInt(req.getParameter("price")));
        food.setStock_quantity(Integer.parseInt(req.getParameter("stock_quantity")));
        food.setDiscount(Integer.parseInt(req.getParameter("discount")));
        food.setCategory_id(Integer.parseInt(req.getParameter("category_id")));
        food.setList_food_images(foodImagesList);
        foodService.updateFood(food, food.getCategory_id(), foodImagesList);
        listFoodAndCategory(req, resp, store_id);
    }
    private void addFood(HttpServletResponse resp, HttpServletRequest req) throws ServletException, IOException {
        try {
            String productName = req.getParameter("product_name");
            int price = Integer.parseInt(req.getParameter("price"));
            int stockQuantity = Integer.parseInt(req.getParameter("stock_quantity"));
            int discount = Integer.parseInt(req.getParameter("discount"));
            int store_id = storeIDByLoggedInUser(req, resp);

            String uploadPath = "C:\\foodSmartImages\\product";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            List<FoodImages> foodImagesList = new ArrayList<>();
            Collection<Part> fileParts = req.getParts();
            for (Part part : fileParts) {
                if (part.getName().equals("product_images") && part.getSize() > 0) {
                    String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    part.write(uploadPath + File.separator + fileName);
                    boolean isPrimary = foodImagesList.isEmpty();
                    foodImagesList.add(new FoodImages(0, 0, fileName, isPrimary));
                }
            }
            Food food = new Food(0, store_id, productName, price, stockQuantity, discount, foodImagesList);

            boolean success;
            int productID = foodService.addFood(store_id, food);
            if (productID > 0) {
                success = foodService.addFoodImages(productID, foodImagesList);
            } else {
                success = false;
            }
            if (success) {
                listFoodAndCategory(req, resp, store_id);
            } else {
                req.setAttribute("errorMessage", "Lỗi khi thêm sản phẩm.");
                req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=addFood").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Lỗi khi thêm sản phẩm.");
            req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=addFood").forward(req, resp);
        }
    }
    private void searchCategoryFoodByName(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int store_id = storeIDByLoggedInUser(req, resp);
        String keyword = req.getParameter("keyword");

        List<Food> foodList = foodService.listFoodStoreByName(store_id,keyword);
        List<CategoryFood> categoryFoodList = categoryFoodService.searchCategoryFoodWithName(keyword);
        req.setAttribute("foodList", foodList);
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
    private void showEditFoodForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productID = Integer.parseInt(req.getParameter("productID"));
        Food food = foodService.getFoodByID(productID);
        req.setAttribute("food", food);
        req.getRequestDispatcher("view/merchant/homeMerchant.jsp?page=editFood").forward(req,resp);
    }

}
