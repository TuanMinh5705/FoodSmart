package com.example.foodSmart.service.user;

import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.model.admin.Shipper;
import com.example.foodSmart.model.user.CartItem;
import com.example.foodSmart.model.user.Order;
import com.example.foodSmart.service.AccountService;
import com.example.foodSmart.service.IAccountService;
import com.example.foodSmart.service.admin.CarrierService;
import com.example.foodSmart.service.admin.ICarrierService;
import com.example.foodSmart.service.merchant.FoodService;
import com.example.foodSmart.service.merchant.IFoodService;
import com.example.foodSmart.util.ConnectDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderService implements IOrderService {
    ICarrierService carrierService = new CarrierService();
    IAccountService accountService = new AccountService();
    IFoodService foodService = new FoodService();

    private static final String ADD_ORDER_QUERY = "INSERT INTO Orders (user_id, shipper_id, store_id, order_status, order_date, payment_method, payment_status, shipping_info) VALUES (?,?,?,?,?,?,?,?)";
    private static final String ADD_ORDER_PRODUCT_QUERY = "INSERT INTO Products_Orders (product_id, order_id, price_at_time, quantity) VALUES (?,?,?,?)";

    @Override
    public void addOrder(Order order) {
        int orderId = -1;

        try (Connection conn = ConnectDB.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement psOrder = conn.prepareStatement(ADD_ORDER_QUERY, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setInt(1, order.getUserId());
                psOrder.setInt(2, 1);
                psOrder.setInt(3, order.getStoreId());
                psOrder.setString(4, order.getOrderStatus());
                psOrder.setTimestamp(5, order.getOrderDate());
                psOrder.setString(6, order.getPaymentMethod());
                psOrder.setString(7, order.getPaymentStatus());
                AccountDetails accountDetails = order.getShippingInfo();
                psOrder.setInt(8, accountDetails.getAccountDetailID());

                int affectedRows = psOrder.executeUpdate();
                if (affectedRows > 0) {
                    try (ResultSet generatedKeys = psOrder.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            orderId = generatedKeys.getInt(1);
                        }
                    }
                }

                try (PreparedStatement psOrderProduct = conn.prepareStatement(ADD_ORDER_PRODUCT_QUERY)) {
                    for (CartItem cartItem : order.getCartItems()) {
                        psOrderProduct.setInt(1, cartItem.getProductId());
                        psOrderProduct.setInt(2, orderId);
                        psOrderProduct.setInt(3, cartItem.getPriceAtTime());
                        psOrderProduct.setInt(4, cartItem.getQuantity());
                        psOrderProduct.addBatch();
                    }
                    psOrderProduct.executeBatch();
                }

                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException(e);
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Order> getOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders ORDER BY order_date DESC";

        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                List<CartItem> details = getCartItems(orderId);
                int order_id = rs.getInt("order_id");
                int userId = rs.getInt("user_id");
                int shipperId = rs.getInt("shipper_id");
                Shipper shipper = carrierService.getShipper(shipperId);
                int storeId = rs.getInt("store_id");
                int voucherId = rs.getInt("voucher_id");
                int couponId = rs.getInt("coupon_id");
                String orderStatus = rs.getString("order_status");
                Timestamp shippingDate = rs.getTimestamp("shipping_date");
                Timestamp deliveryDate = rs.getTimestamp("delivery_date");
                Timestamp orderDate = rs.getTimestamp("order_date");
                String paymentMethod = rs.getString("payment_method");
                String paymentStatus = rs.getString("payment_status");
                int shippingInfo = rs.getInt("shipping_info");
                AccountDetails accountDetails = accountService.getAccountDetailById(shippingInfo, userId);
                Order order = new Order(order_id, userId, storeId, shipper, voucherId, couponId, orderStatus, shippingDate, deliveryDate, orderDate, paymentMethod, paymentStatus, accountDetails, details);
                orders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    @Override
    public List<Order> getOrdersByUser(int id) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE user_id = ? ORDER BY order_date DESC";

        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                List<CartItem> details = getCartItems(orderId);
                int order_id = rs.getInt("order_id");
                int userId = rs.getInt("user_id");
                int shipperId = rs.getInt("shipper_id");
                Shipper shipper = carrierService.getShipper(shipperId);
                int storeId = rs.getInt("store_id");
                int voucherId = rs.getInt("voucher_id");
                int couponId = rs.getInt("coupon_id");
                String orderStatus = rs.getString("order_status");
                Timestamp shippingDate = rs.getTimestamp("shipping_date");
                Timestamp deliveryDate = rs.getTimestamp("delivery_date");
                Timestamp orderDate = rs.getTimestamp("order_date");
                String paymentMethod = rs.getString("payment_method");
                String paymentStatus = rs.getString("payment_status");
                int shippingInfo = rs.getInt("shipping_info");
                AccountDetails accountDetails = accountService.getAccountDetailById(shippingInfo, userId);
                Order order = new Order(order_id, userId, storeId, shipper, voucherId, couponId, orderStatus, shippingDate, deliveryDate, orderDate, paymentMethod, paymentStatus, accountDetails, details);
                orders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    @Override
    public Order getOrder(int id) {
        String sql = "SELECT * FROM Orders WHERE order_id = ?";
        Order order = order = new Order();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                List<CartItem> details = getCartItems(orderId);
                int order_id = rs.getInt("order_id");
                int userId = rs.getInt("user_id");
                int shipperId = rs.getInt("shipper_id");
                Shipper shipper = carrierService.getShipper(shipperId);
                int storeId = rs.getInt("store_id");
                int voucherId = rs.getInt("voucher_id");
                int couponId = rs.getInt("coupon_id");
                String orderStatus = rs.getString("order_status");
                Timestamp shippingDate = rs.getTimestamp("shipping_date");
                Timestamp deliveryDate = rs.getTimestamp("delivery_date");
                Timestamp orderDate = rs.getTimestamp("order_date");
                String paymentMethod = rs.getString("payment_method");
                String paymentStatus = rs.getString("payment_status");
                int shippingInfo = rs.getInt("shipping_info");
                AccountDetails accountDetails = accountService.getAccountDetailById(shippingInfo, userId);
                order = new Order(order_id, userId, storeId, shipper, voucherId, couponId, orderStatus, shippingDate, deliveryDate, orderDate, paymentMethod, paymentStatus, accountDetails, details);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    // Phương thức lấy danh sách chi tiết đơn hàng từ bảng Products_Orders
    private List<CartItem> getCartItems(int orderId) {
        List<CartItem> details = new ArrayList<>();
        String sql = "SELECT * FROM Products_Orders WHERE order_id = ?";
        CartItem cartItem = new CartItem();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int product_id = rs.getInt("product_id");
                    int priceAtTime = rs.getInt("price_at_time");
                    int quantity = rs.getInt("quantity");
                    cartItem = new CartItem(product_id, priceAtTime, quantity);
                    details.add(cartItem);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }
}

