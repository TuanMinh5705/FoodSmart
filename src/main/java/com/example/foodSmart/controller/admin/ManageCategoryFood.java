package com.example.foodSmart.controller.admin;

import com.example.foodSmart.model.admin.CategoryFood;
import com.example.foodSmart.service.admin.CategoryFoodService;
import com.example.foodSmart.service.admin.ICategoryFoodService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageCategoryFood")
@MultipartConfig
public class ManageCategoryFood extends HttpServlet {
    ICategoryFoodService categoryFoodService = new CategoryFoodService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        List<CategoryFood> categoryFoodList = categoryFoodService.listCategoryFood();
        switch (action) {
            case "editForm":
                getCategoryFoodAction(req,resp);
                req.setAttribute("categoryFoodList", categoryFoodList);
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=updateCategoriesFood").forward(req, resp);
                break;
                case "infoForm":
                    getCategoryFoodAction(req,resp);
                    req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=infoCategoriesFood").forward(req, resp);
                    break;
            case "addForm":
                req.setAttribute("categoryFoodList", categoryFoodList);
                req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=addCategoriesFood").forward(req, resp);
                break;
            default:
                listCategorysFood(req, resp);
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
            case "add":
                addCategoryFoodAction(req,resp);
                break;
                case "edit":
                    editCategoryFood(req,resp);
                    break;
                    case "search":
                        searchCategoryFoodByName(req,resp);
                        break;
            
        }
    }

    private void editCategoryFood(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int categoryFood_id = Integer.parseInt(req.getParameter("category_id"));
        Part filePart = req.getPart("avt_path");
        String avatarPath = (filePart != null && filePart.getSize() > 0) ? filePart.getSubmittedFileName() : req.getParameter("currentAvtPath");

        String uploadPath = System.getenv("uploadPath")  + File.separator + "avatars";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        File file = new File(uploadPath,avatarPath);
        if (!file.exists()) {
            filePart.write(uploadPath + File.separator + avatarPath);
        }
        String categoryName = req.getParameter("category_name");
        String description = req.getParameter("description");
        CategoryFood categoryFood = new CategoryFood(categoryFood_id,categoryName,description,avatarPath);
        categoryFoodService.updateCategoryFood(categoryFood);
        listCategorysFood(req, resp);
    }

    private void addCategoryFoodAction(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part filePart = req.getPart("avatar");
        String avatarPath = filePart.getSubmittedFileName();

        String uploadPath = System.getenv("uploadPath")  + File.separator + "avatars";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        File file = new File(uploadPath,avatarPath);
        if (!file.exists()) {
            filePart.write(uploadPath + File.separator + avatarPath);
        }
        String category_name = req.getParameter("category_name");
        String description = req.getParameter("description");
        CategoryFood categoryFood = new CategoryFood(category_name,description,avatarPath);
        categoryFoodService.addCategoryFood(categoryFood);
        listCategorysFood(req,resp);
    }

    private void searchCategoryFoodByName(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<CategoryFood> categoryFoodList = categoryFoodService.searchCategoryFoodWithName(keyword);
        req.setAttribute("categoryFoodList", categoryFoodList);
        req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageCategoriesFood").forward(req, resp);
    }

    private void getCategoryFoodAction(HttpServletRequest req, HttpServletResponse resp) {
        int categoryID = Integer.parseInt(req.getParameter("categoryID"));
        CategoryFood categoryFood = categoryFoodService.getCategoryFood(categoryID);
        req.setAttribute("category", categoryFood);
    }

    private void listCategorysFood(HttpServletRequest req, HttpServletResponse resp) {
        try {
            List<CategoryFood> categoryFoodList = categoryFoodService.listCategoryFood();
            req.setAttribute("categoryFoodList", categoryFoodList);
            req.getRequestDispatcher("view/admin/homeAdmin.jsp?page=manageCategoriesFood").forward(req, resp);
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

}
