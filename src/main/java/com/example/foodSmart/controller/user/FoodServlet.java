package com.example.foodSmart.controller.user;

import com.example.foodSmart.model.admin.CategoryFood;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.user.CartItem;
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
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/homeUser")
public class FoodServlet extends HttpServlet {
IProductService productService = new ProductService();
ICategoryFoodService categoryFoodService = new CategoryFoodService();
IFoodService foodService = new FoodService();
    IMerchantService merchantService = new MerchantService();
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
            case "showCartStore" :
                showCartStore(req,resp);
                break;
            default:
                showListFood(req,resp);
                break;
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "searchProduct":
                searchProduct(req,resp);
                break;
            case "addProductToCart":
                addProductToCart(req,resp);
                break;
            case "deleteStore" :
                removeStoreFromCart(req,resp);
                break;
        }
    }

    private void removeStoreFromCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        int storeId = Integer.parseInt(req.getParameter("id"));

        if (cart != null) {
            cart = cart.stream()
                    .filter(item -> item.getStoreId() != storeId)
                    .collect(Collectors.toList());
            session.setAttribute("cart", cart);
        }

        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write("success");
    }
    private void showCartStore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        Map<Integer, Map<String, Object>> groupedMap = new LinkedHashMap<>();

        if (cart != null && !cart.isEmpty()) {
            for (CartItem cartItem : cart) {
                int storeId = cartItem.getStoreId();
                Merchant merchant = merchantService.getMerchantById(storeId);

                if (!groupedMap.containsKey(storeId)) {
                    Map<String, Object> groupData = new HashMap<>();
                    groupData.put("storeId", storeId);
                    groupData.put("storeName", (merchant != null) ? merchant.getStore_name() : "Không xác định");
                    groupData.put("storeLogo", (merchant != null && merchant.getAvt_path() != null)
                            ? merchant.getAvt_path()
                            : "https://via.placeholder.com/80");
                    groupData.put("items", new ArrayList<Map<String, Object>>());
                    groupData.put("totalAmount", 0);
                    groupData.put("totalItems", 0);
                    groupedMap.put(storeId, groupData);
                }

                Map<String, Object> groupData = groupedMap.get(storeId);
                List<Map<String, Object>> itemsList = (List<Map<String, Object>>) groupData.get("items");

                Map<String, Object> itemData = new HashMap<>();
                itemData.put("productId", cartItem.getProductId());
                itemData.put("priceAtTime", cartItem.getPriceAtTime());
                itemData.put("quantity", cartItem.getQuantity());
                itemData.put("productName", "Product " + cartItem.getProductId());
                itemsList.add(itemData);

                int currentTotal = (Integer) groupData.get("totalAmount");
                currentTotal += cartItem.getPriceAtTime() * cartItem.getQuantity();
                groupData.put("totalAmount", currentTotal);

                int currentTotalItems = (Integer) groupData.get("totalItems");
                currentTotalItems += cartItem.getQuantity();
                groupData.put("totalItems", currentTotalItems);
            }
        }

        List<Map<String, Object>> cartDisplayList = new ArrayList<>(groupedMap.values());
        req.setAttribute("cartDisplayList", cartDisplayList);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=cart_store").forward(req, resp);
    }
    private void addProductToCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();

        int productId = Integer.parseInt(req.getParameter("id"));
        int priceAtTime = Integer.parseInt(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        Food food = foodService.getFoodByID(productId);

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        boolean found = false;
        for (CartItem item : cart) {
            if (item.getProductId() == productId) {
                item.setQuantity(item.getQuantity() + quantity); 
                found = true;
                break;
            }
        }

        if (!found) {
            cart.add(new CartItem(food.getStore_id(), productId, priceAtTime, quantity));
        }

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write("{\"success\": true, \"cartCount\": " + cart.size() + "}");
        System.out.println(cart);
    }
    private void searchProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        if (keyword == null) {
            req.setAttribute("error", "Please enter a keyword");
        }
        List<Food> foodList = foodService.listFoodStoreByName(-1,keyword);
        req.setAttribute("foodList", foodList);
        req.setAttribute("keyword", keyword);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=foodsByCategory").forward(req, resp);
    }
    private void getFoodsByCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int category_id = Integer.parseInt(req.getParameter("category_id"));
        List<Food> foodList = productService.getFoodListByCategory(category_id);
            List<CategoryFood> categoryFoodList = categoryFoodService.listCategoryFood();
            CategoryFood categoryFood = categoryFoodService.getCategoryFood(category_id);
            req.setAttribute("category", categoryFood);
            req.setAttribute("categoryFoodList", categoryFoodList);
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
