package com.example.foodSmart.service.user;

import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.model.user.CartItem;
import com.example.foodSmart.model.user.Order;
import com.example.foodSmart.util.ConnectDB;

import java.sql.*;

public class OrderService implements IOrderService {

    private static final String ADD_ORDER_QUERY = "INSERT INTO Orders (user_id, shipper_id, store_id, order_status, order_date, payment_method, payment_status, shipping_address, shipping_phone) VALUES (?,?,?,?,?,?,?,?,?)";
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
                psOrder.setString(8, accountDetails.getAddress());
                psOrder.setString(9, accountDetails.getPhonenumber());

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


}
