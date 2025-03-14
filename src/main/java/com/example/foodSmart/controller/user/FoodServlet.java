package com.example.foodSmart.controller.user;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.model.admin.CategoryFood;
import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.model.merchant.Food;
import com.example.foodSmart.model.merchant.FoodImages;
import com.example.foodSmart.model.user.CartItem;
import com.example.foodSmart.model.user.Order;
import com.example.foodSmart.service.AccountService;
import com.example.foodSmart.service.IAccountService;
import com.example.foodSmart.service.admin.CategoryFoodService;
import com.example.foodSmart.service.admin.ICategoryFoodService;
import com.example.foodSmart.service.admin.IMerchantService;
import com.example.foodSmart.service.admin.MerchantService;
import com.example.foodSmart.service.merchant.FoodService;
import com.example.foodSmart.service.merchant.IFoodService;
import com.example.foodSmart.service.user.IOrderService;
import com.example.foodSmart.service.user.IProductService;
import com.example.foodSmart.service.user.OrderService;
import com.example.foodSmart.service.user.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/homeUser")
public class FoodServlet extends HttpServlet {
    IProductService productService = new ProductService();
    ICategoryFoodService categoryFoodService = new CategoryFoodService();
    IFoodService foodService = new FoodService();
    IAccountService accountService = new AccountService();
    IOrderService orderService = new OrderService();
    IMerchantService merchantService = new MerchantService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "showFoodDetail":
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
                getFoodsByCategory(req, resp);
                break;
            case "showCartStore":
                showCartStore(req, resp);
                break;
            case "showCartProduct":
                showCartProduct(req, resp);
                break;
            case "showStore":
                showStore(req, resp);
                break;
            case "showCollection":
                showCollection(req, resp);
                break;
            case "buyNow" :
                buyNow(req,resp);
                break;
            case "record" :
                record(req,resp);
                break;
            default:
                showListFood(req, resp);
                break;
        }
    }
    private void record(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            HttpSession session = req.getSession();
            String orderIdStr = req.getParameter("orderId");

            if (orderIdStr == null) {
                resp.sendRedirect("/homeUser");
                return;
            }

            int orderId = Integer.parseInt(orderIdStr);
            Order order = orderService.getOrder(orderId);
            if (order == null) {
                resp.sendRedirect("/homeUser");
                return;
            }

            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            for (CartItem orderItem : order.getCartItems()) {
                Food food = foodService.getFoodByID(orderItem.getProductId());
                if (food == null) continue;

                int discountedPrice = food.getPrice() * (1 - food.getDiscount() / 100);
                boolean found = false;

                for (CartItem cartItem : cart) {
                    if (cartItem.getProductId() == orderItem.getProductId()) {
                        cartItem.setQuantity(cartItem.getQuantity() + orderItem.getQuantity());
                        found = true;
                        break;
                    }
                }

                if (!found) {
                    cart.add(new CartItem(food.getStore_id(), orderItem.getProductId(), discountedPrice, orderItem.getQuantity()));
                }
            }

            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", cart.size());

            req.getRequestDispatcher("/homeUser?action=showCartProduct&storeId=" + order.getStoreId()).forward(req,resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect("/homeUser");
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }



    private void showCollection(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<Food> foods = (List<Food>) session.getAttribute("collection");
        if (foods == null) {
            foods = new ArrayList<>();
        }
        req.setAttribute("foodList", foods);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=collection").forward(req, resp);
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
            case "searchProduct":
                searchProduct(req, resp);
                break;
            case "addProductToCart":
                addProductToCart(req, resp);
                break;
            case "deleteStore":
                removeStoreFromCart(req, resp);
                break;
            case "deleteProduct":
                removeProductFromCart(req, resp);
                break;
            case "orderProduct":
                orderProduct(req, resp);
                break;
            case "updateCart":
                updateCart(req, resp);
                break;
            case "payment":
                paymentOrder(req, resp);
                break;
            case "addCollection":
                addCollection(req, resp);
                break;
            case "addAddress":
                addAddress(req, resp);
                break;
            case "updateAddress":
                updateAddress(req, resp);
                break;
            case "removeCollection":
                removeCollection(req, resp);
                break;

        }
    }
    private void buyNow(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("id"));
            int quantity = 1;
            Food food = foodService.getFoodByID(productId);
            if (food == null) {
                resp.sendRedirect("/homeUser");
                return;
            }

            int discountedPrice = food.getPrice() * (1 - food.getDiscount() / 100);

            HttpSession session = req.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
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
                cart.add(new CartItem(food.getStore_id(), productId, discountedPrice, quantity));
            }
            Merchant merchant = merchantService.getMerchantById(food.getStore_id());
            Map<String, Object> storeData = new HashMap<>();
            storeData.put("storeId", food.getStore_id());
            storeData.put("storeName", (merchant != null) ? merchant.getStore_name() : "Không xác định");
            storeData.put("storeLogo",
                    (merchant != null && merchant.getAvt_path() != null)
                            ? merchant.getAvt_path()
                            : "defaultStoreLogo.png");
            List<Map<String, Object>> items = new ArrayList<>();
            Map<String, Object> itemData = new HashMap<>();
            itemData.put("productId", food.getProduct_id());
            itemData.put("productName", food.getProduct_name());
            // Sử dụng giá đã giảm cho priceAtTime
            itemData.put("priceAtTime", discountedPrice);
            itemData.put("quantity", quantity);
            String primaryImage = "defaultProduct.png";
            if (food.getList_food_images() != null) {
                for (FoodImages img : food.getList_food_images()) {
                    if (img.isIs_primary()) {
                        primaryImage = img.getImage_path();
                        break;
                    }
                }
            }
            itemData.put("productImage", primaryImage);

            items.add(itemData);
            // Tính tổng tiền dựa theo giá đã giảm
            double totalAmount = discountedPrice * quantity;

            storeData.put("items", items);
            storeData.put("totalAmount", totalAmount);
            req.setAttribute("storeData", storeData);
            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", cart.size());
            req.getRequestDispatcher("view/user/homeUser.jsp?page=showCartProduct").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect("/homeUser");
        }
    }

    private void paymentOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        Order order = (Order) session.getAttribute("order");
        Account account = (Account) session.getAttribute("loggedInAccount");

        String addressParam = req.getParameter("address");
        int addressShipping = (addressParam != null && !addressParam.isEmpty()) ? Integer.parseInt(addressParam) : 0;
        AccountDetails accountDetails = accountService.getAccountDetailById(addressShipping, account.getAccountID());

        String paymentMethod = req.getParameter("payment");
        order.setShippingInfo(accountDetails);
        order.setPaymentMethod(paymentMethod);
        if(paymentMethod.equals("bank")){
            order.setPaymentStatus(true);
        }

        for (CartItem item : order.getCartItems()) {
            Food product = foodService.getFoodByID(item.getProductId());
            if (product != null) {
                int newQuantity = product.getStock_quantity() - item.getQuantity();
                if (newQuantity < 0) {
                    resp.getWriter().write("error: Not enough stock for product " + product.getProduct_name());
                    return;
                }
                productService.updateStockQuantity(item.getProductId(), newQuantity);
            }
        }
        orderService.addOrder(order);
        if (cart != null) {
            cart.removeIf(item ->
                    order.getCartItems().stream().anyMatch(o -> o.getProductId() == item.getProductId())
            );
        }
        session.setAttribute("cart", cart);
        session.setAttribute("cartCount", cart != null ? cart.size() : 0);
            req.getSession().setAttribute("success", "Đặt hàng thành công!");
        resp.sendRedirect("/homeUser");

    }

    private void removeCollection(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        String productIdStr = req.getParameter("id");

        if (productIdStr != null) {
            try {
                int productId = Integer.parseInt(productIdStr);
                List<Food> collection = (List<Food>) session.getAttribute("collection");

                if (collection != null) {
                    boolean removed = collection.removeIf(food -> food.getProduct_id() == productId);

                    if (removed) {
                        session.setAttribute("collection", collection);
                        session.setAttribute("collectionCount", collection.size());
                        resp.getWriter().write("success");
                    } else {
                        resp.getWriter().write("not_found");
                    }
                } else {
                    resp.getWriter().write("empty");
                }
            } catch (NumberFormatException e) {
                resp.getWriter().write("error");
            }
        } else {
            resp.getWriter().write("error");
        }
    }

    private void addCollection(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        String productIdStr = req.getParameter("product_id");

        if (productIdStr != null) {
            try {
                int productId = Integer.parseInt(productIdStr);
                Food food = foodService.getFoodByID(productId);

                if (food == null) {
                    resp.getWriter().write("not_found");
                    return;
                }

                List<Food> collection = (List<Food>) session.getAttribute("collection");

                if (collection == null) {
                    collection = new ArrayList<>();
                }

                boolean exists = collection.stream().anyMatch(f -> f.getProduct_id() == productId);

                if (!exists) {
                    collection.add(food);
                    session.setAttribute("collection", collection);
                    session.setAttribute("collectionCount", collection.size());
                    resp.getWriter().write("success:" + collection.size());
                } else {
                    resp.getWriter().write("exists");
                }
            } catch (NumberFormatException e) {
                resp.getWriter().write("error");
            }
        } else {
            resp.getWriter().write("error");
        }
    }

    private void addAddress(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            HttpSession session = req.getSession();
            Account account = (Account) session.getAttribute("loggedInAccount");
            String newPhoneNumber = req.getParameter("phone");
            String newAddress = req.getParameter("address");

            AccountDetails detail = new AccountDetails(account.getAccountID(), newAddress, newPhoneNumber, false);

            if (accountService.addAccountDetails(detail)) {
                int newId = detail.getAccountDetailID();
                resp.getWriter().write("success");
            } else {
                resp.getWriter().write("error");
            }
        } catch (NumberFormatException e) {
            resp.getWriter().write("error");
        }
    }

    private void updateAddress(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int addressID = Integer.parseInt(req.getParameter("id"));
            String updatedPhoneNumber = req.getParameter("phone");
            String updatedAddress = req.getParameter("address");
            boolean isDefault = "true".equals(req.getParameter("isDefault"));

            AccountDetails detail = new AccountDetails(0, addressID, updatedAddress, updatedPhoneNumber, isDefault);

            if (accountService.editAccountDetails(detail)) {
                resp.getWriter().write("success");
            } else {
                resp.getWriter().write("error");
            }
        } catch (NumberFormatException e) {
            resp.getWriter().write("error");
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
        List<CategoryFood> categoryList = foodService.listCategoriesFoodStore(store_id);
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
                        if (foodImage.isIs_primary()) {
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
        req.setAttribute("storeData", storeData);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=showCartProduct").forward(req, resp);
    }

    private void updateCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));


        HttpSession session = req.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart != null) {
            for (CartItem item : cart) {
                if (item.getProductId() == productId) {
                    item.setQuantity(quantity);
                    break;
                }
            }
        }

        session.setAttribute("cart", cart);

        resp.getWriter().write("Success");
    }
    private void orderProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        int storeId = Integer.parseInt(req.getParameter("storeId"));
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect("view/user/homeUser.jsp?page=cart_store");
            return;
        }
        int totalAmount = 0;
        Set<Integer> productIds = new HashSet<>();
        List<CartItem> storeCartItems = new ArrayList<>();
        for (CartItem item : cart) {
            if (item.getStoreId() == storeId) {
                storeCartItems.add(item);
                totalAmount += item.getPriceAtTime() * item.getQuantity();
                productIds.add(item.getProductId());
            }
        }

        Map<Integer, Food> productMap = new HashMap<>();
        for (Integer id : productIds) {
            Food food = foodService.getFoodByID(id);
            if (food != null) {
                productMap.put(id, food);
            }
        }
        int shipping_cost = 25000;
        int discount1 = 5000;
        int discount2 = 5000;
        totalAmount = totalAmount + shipping_cost - discount1 - discount2;

        Order order = new Order();
        order.setStoreId(storeId);
        Account user = (Account) session.getAttribute("loggedInAccount");
        if (user != null) {
            order.setUserId(user.getAccountID());
        }

        order.setOrderStatus("Chờ xác nhận");
        order.setOrderDate(new Timestamp(System.currentTimeMillis()));
        order.setShipper(null);

        order.setVoucherId(0);
        order.setCouponId(0);
        order.setShippingInfo(null);
        order.setPaymentMethod(null);
        order.setShippingDate(null);
        order.setDeliveryDate(null);

        order.setCartItems(storeCartItems);
        session.setAttribute("order", order);
        session.setAttribute("cart", cart);
        List<AccountDetails> accountDetails = accountService.getAccountDetails(user.getAccountID());
        session.setAttribute("productMap", productMap);
        req.setAttribute("accountDetails", accountDetails);
        req.setAttribute("totalAmount", totalAmount);
        req.getRequestDispatcher("view/user/homeUser.jsp?page=orderProduct").forward(req, resp);
    }
    private void removeProductFromCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        int productId = Integer.parseInt(req.getParameter("id"));

        if (cart != null) {
            cart = cart.stream()
                    .filter(item -> item.getProductId() != productId)
                    .collect(Collectors.toList());

            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", cart.size());
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
            session.setAttribute("cartCount", cart.size());
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


                Food food = foodService.getFoodByID(cartItem.getProductId());
                if (food != null) {
                    itemData.put("productName", food.getProduct_name());

                    String productImage = "https://via.placeholder.com/150";
                    List<FoodImages> foodImages = food.getList_food_images();
                    if (foodImages != null) {
                        for (FoodImages foodImage : foodImages) {
                            if (foodImage.isIs_primary()) {
                                productImage = foodImage.getImage_path();
                                break;
                            }
                        }
                    }
                    itemData.put("productImage", productImage);
                } else {
                    itemData.put("productName", "Sản phẩm không xác định");
                    itemData.put("productImage", "https://via.placeholder.com/150");
                }
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
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            int productId = Integer.parseInt(req.getParameter("id"));
            int priceAtTime = Integer.parseInt(req.getParameter("price"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            if (quantity <= 0) {
                resp.getWriter().write("{\"success\": false, \"message\": \"Số lượng không hợp lệ\"}");
                return;
            }

            Food food = foodService.getFoodByID(productId);
            if (food == null) {
                resp.getWriter().write("{\"success\": false, \"message\": \"Sản phẩm không tồn tại\"}");
                return;
            }

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

            session.setAttribute("cartCount", cart.size());

            resp.getWriter().write("{\"success\": true, \"cartCount\": " + cart.size() + "}");
        } catch (NumberFormatException e) {
            resp.getWriter().write("{\"success\": false, \"message\": \"Dữ liệu không hợp lệ\"}");
        }
    }
    private void searchProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        if (keyword == null) {
            req.setAttribute("error", "Please enter a keyword");
        }
        List<Food> foodList = foodService.listFoodStoreByName(-1, keyword);
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
        try {
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