package com.example.foodSmart.controller.user;

import com.example.foodSmart.model.admin.CategoryFood;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.merchant.FoodImages;
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
            case "showCartProduct":
                showCartProduct(req, resp);
                break;
            case "showStore" :
                showStore(req,resp);
                break;
            default:
                showListFood(req,resp);
                break;
        }
    }

    private void showStore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int store_id = Integer.parseInt(req.getParameter("store_id"));
        Merchant merchant = merchantService.getMerchantById(store_id);
        List<Food> foodList = foodService.listFoodStore(store_id);

        Map<Integer, List<Food>> categoryFoodMap = new HashMap<>();

        for (Food food : foodList) {
            int categoryId = food.getCategory_id();
            categoryFoodMap.putIfAbsent(categoryId, new ArrayList<>());
            categoryFoodMap.get(categoryId).add(food);
        }
        List<CategoryFood> categoryList =foodService.listCategoriesFoodStore(store_id);
        for (CategoryFood category : categoryList) {
            int categoryId = category.getCategory_id();
            if (categoryFoodMap.containsKey(categoryId)) {
                category.setFoodList(categoryFoodMap.get(categoryId));
            }
        }
        req.setAttribute("store", merchant);
        req.setAttribute("storeCategories", categoryList);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=showStore").forward(req, resp);
    }

    private void showCartProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        String storeIdToShow = req.getParameter("storeId");
        int storeId = Integer.parseInt(storeIdToShow);
        Merchant merchant = merchantService.getMerchantById(storeId);

        Map<String, Object> storeData = new HashMap<>();
        storeData.put("storeId", storeIdToShow);
        storeData.put("storeName", (merchant != null) ? merchant.getStore_name() : "Không xác định");
        storeData.put("storeLogo",
                (merchant != null && merchant.getAvt_path() != null)
                        ? merchant.getAvt_path()
                        : "https://via.placeholder.com/80");

        List<Map<String, Object>> items = new ArrayList<>();
        int totalAmount = 0;


        if (cart != null && !cart.isEmpty()) {
            for (CartItem cartItem : cart) {
                if (cartItem.getStoreId() == storeId) {
                    Map<String, Object> itemData = new HashMap<>();
                    itemData.put("productId", cartItem.getProductId());
                    itemData.put("priceAtTime", cartItem.getPriceAtTime());
                    itemData.put("quantity", cartItem.getQuantity());
                    Food food = foodService.getFoodByID(cartItem.getProductId());
                    itemData.put("productName", food.getProduct_name());
                    for (FoodImages foodImage : food.getList_food_images()) {
                        if(foodImage.isIs_primary()){
                            String imagePath = foodImage.getImage_path();
                            itemData.put("productImage", imagePath);
                        }
                    }
                    items.add(itemData);
                    totalAmount += cartItem.getPriceAtTime() * cartItem.getQuantity();
                }
            }
        }
        storeData.put("items", items);
        storeData.put("totalAmount", totalAmount);
        System.out.println(storeData);
        req.setAttribute("storeData", storeData);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=showCartProduct").forward(req, resp);
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
            case "deleteProduct" :
                removeProductFromCart(req,resp);
                break;
//            case "updateQuantityProduct" :
//                updateQuantityProduct(req,resp);
//                break;
        }
    }

    //    private void updateQuantityProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
//        HttpSession session = req.getSession();
//        int productId = Integer.parseInt(req.getParameter("productId"));
//        int quantity = Integer.parseInt(req.getParameter("quantity"));
//        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
//        if (cart != null) {
//            for (CartItem item : cart) {
//                if (item.getProductId() == productId) {
//                    item.setQuantity(quantity);
//                    break;
//                }
//            }
//        }
//        session.setAttribute("cart", cart);
//
//        double totalAmount = cart.stream().mapToDouble(item -> item.getPriceAtTime() * item.getQuantity()).sum();
//        resp.setContentType("application/json");
//        resp.getWriter().write("{\"success\": true, \"totalAmount\": " + totalAmount + "}");
//    }
    private void removeProductFromCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        int productId = Integer.parseInt(req.getParameter("id"));

        if (cart != null) {
            cart = cart.stream()
                    .filter(item -> item.getProductId() != productId)
                    .collect(Collectors.toList());
            session.setAttribute("cart", cart);
        }

        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write("success");
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
        List<Merchant> storeList = merchantService.searchMerchant(keyword);
        req.setAttribute("storeList", storeList);
        req.setAttribute("foodList", foodList);
        req.setAttribute("keyword", keyword);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=foodsByCategory").forward(req, resp);
    }
    private void getFoodsByCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int category_id = Integer.parseInt(req.getParameter("category_id"));
        List<Food> foodList = productService.getFoodListByCategory(category_id);
            List<CategoryFood> categoryFoodList = categoryFoodService.listCategoryFood();
            CategoryFood categoryFood = categoryFoodService.getCategoryFood(category_id);

        Set<Merchant> storeSet = new HashSet<>();
        for (Food food : foodList) {
            Merchant merchant = merchantService.getMerchantById(food.getStore_id());
            storeSet.add(merchant);
        }

        List<Merchant> storeList = new ArrayList<>(storeSet);
        req.setAttribute("storeList", storeList);
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
