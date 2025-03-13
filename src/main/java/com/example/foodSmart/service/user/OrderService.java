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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
                psOrder.setBoolean(7, order.getPaymentStatus());
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
        String sql = "SELECT * FROM Orders WHERE ORDER BY order_date DESC";

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
                boolean paymentStatus = rs.getBoolean("payment_status");
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

    public List<Order> getOrdersByUser(String name, int id) {
        List<Order> orders = new ArrayList<>();


        if (!name.matches("^[a-zA-Z_]+$")) {
            throw new IllegalArgumentException("Invalid column name");
        }

        String sql = "SELECT * FROM Orders WHERE " + name + " = ? ORDER BY order_date DESC";
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
                Boolean paymentStatus = rs.getBoolean("payment_status");
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
    public boolean updateStatus(String name,String newStatus,Boolean payment_status, int id) {
        String sql = "UPDATE orders SET order_status = ?, " + name + " = CURRENT_TIMESTAMP, payment_status = ? WHERE order_id = ?";
        try (Connection conn = ConnectDB.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newStatus);
            stmt.setBoolean(2,payment_status);
            stmt.setInt(3, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void addInvoices(int order_id, int total) {
        String sql = "INSERT INTO Invoices (order_id, payment_date, total_amount) VALUES (?, CURRENT_TIMESTAMP, ?)";

        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, order_id);
            ps.setInt(2, total);

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Error adding invoice: " + e.getMessage(), e);
        }
    }


@Override
        public Map<String, Object> getMerchantStatistics(int merchantId) {
            Map<String, Object> result = new HashMap<>();

            int totalOrders = 0;
            double totalRevenue = 0;
            List<String> topProducts = new ArrayList<>();
            List<Integer> topSales = new ArrayList<>();
            List<String> weeklyDays = new ArrayList<>();
            List<Double> weeklyRevenue = new ArrayList<>();
            List<String> monthlyDays = new ArrayList<>();
            List<Double> monthlyRevenue = new ArrayList<>();
            List<String> yearlyMonths = new ArrayList<>();
            List<Double> yearlyRevenue = new ArrayList<>();

            try {
                Connection conn = ConnectDB.getConnection();
                CallableStatement stmt = conn.prepareCall("{CALL Get_Merchant_Stats(?)}");
                stmt.setInt(1, merchantId);
                boolean hasResults = stmt.execute();

                if (hasResults) {
                    ResultSet rs = stmt.getResultSet();
                    if (rs.next()) {
                        totalOrders = rs.getInt("total_orders");
                        totalRevenue = rs.getDouble("total_revenue");
                    }
                    rs.close();
                }

                if (stmt.getMoreResults()) {
                    ResultSet rs = stmt.getResultSet();
                    while (rs.next()) {
                        topProducts.add(rs.getString("product_name"));
                        topSales.add(rs.getInt("total_sold"));
                    }
                    rs.close();
                }

                if (stmt.getMoreResults()) {
                    ResultSet rs = stmt.getResultSet();
                    while (rs.next()) {
                        weeklyDays.add(rs.getString("day"));
                        weeklyRevenue.add(rs.getDouble("revenue"));
                    }
                    rs.close();
                }

                if (stmt.getMoreResults()) {
                    ResultSet rs = stmt.getResultSet();
                    while (rs.next()) {
                        monthlyDays.add(rs.getString("day"));
                        monthlyRevenue.add(rs.getDouble("revenue"));
                    }
                    rs.close();
                }

                if (stmt.getMoreResults()) {
                    ResultSet rs = stmt.getResultSet();
                    while (rs.next()) {
                        yearlyMonths.add("Tháng " + rs.getString("month"));
                        yearlyRevenue.add(rs.getDouble("revenue"));
                    }
                    rs.close();
                }

                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            // Đưa tất cả dữ liệu vào Map
            result.put("totalOrders", totalOrders);
            result.put("totalRevenue", totalRevenue);
            result.put("topProducts", topProducts);
            result.put("topSales", topSales);
            result.put("weeklyDays", weeklyDays);
            result.put("weeklyRevenue", weeklyRevenue);
            result.put("monthlyDays", monthlyDays);
            result.put("monthlyRevenue", monthlyRevenue);
            result.put("yearlyMonths", yearlyMonths);
            result.put("yearlyRevenue", yearlyRevenue);

            return result;
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
                Boolean paymentStatus = rs.getBoolean("payment_status");
                int shippingInfo = rs.getInt("shipping_info");
                AccountDetails accountDetails = accountService.getAccountDetailById(shippingInfo, userId);
                order = new Order(order_id, userId, storeId, shipper, voucherId, couponId, orderStatus, shippingDate, deliveryDate, orderDate, paymentMethod, paymentStatus, accountDetails, details);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

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

