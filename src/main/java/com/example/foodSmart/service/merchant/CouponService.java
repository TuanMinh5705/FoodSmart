package com.example.foodSmart.service.merchant;

import com.example.foodSmart.model.merchant.Coupon;
import com.example.foodSmart.util.ConnectDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CouponService implements ICouponSerice {
    private static final String LIST_COUPONS_QUERY = "SELECT * FROM store_coupons order by coupon_id desc";
    private static final String ADD_COUPON_QUERY = "INSERT INTO store_coupons (store_id, coupon_code, discount_value, start_date, end_date, start_time, end_time, quantity, description) VALUES (?,?,?,?,?,?,?,?,?)";
    private static final String EDIT_COUPON_QUERY = "UPDATE store_coupons SET store_id = ?, coupon_code = ?, discount_value = ?, start_date = ?, end_date = ?, start_time = ?, end_time = ?, quantity = ?, description = ? WHERE coupon_id = ?";
    private static final String COUPON_BY_ID_QUERY = "SELECT * FROM store_coupons where coupon_id = ?";
    private static final String COUPON_BY_NAME_QUERY = "SELECT * FROM store_coupons where coupon_code LIKE ?";
    private static final String GET_COUPON_BY_STORE_NAME = "SELECT c.coupon_id, c.discount_value, c.description, c.store_id, s.store_name " +
                    "FROM Store_Coupons c " +
                    "JOIN stores s ON c.store_id = s.store_id";

    public List<Coupon> getListCoupon() {
        List<Coupon> coupons = new ArrayList<>();
        try (Connection connection = ConnectDB.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_COUPON_BY_STORE_NAME);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Coupon coupon = new Coupon();
                coupon.setCoupon_id(resultSet.getInt("coupon_id"));
                coupon.setDiscount_value(resultSet.getInt("discount_value"));
                coupon.setDescription(resultSet.getString("description"));
                coupon.setStore_id(resultSet.getInt("store_id"));
                coupon.setStore_name(resultSet.getString("store_name"));
                coupons.add(coupon);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return coupons;
    }




    @Override
    public List<Coupon> getListCoupons() {
        List<Coupon> coupons = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(LIST_COUPONS_QUERY)) {
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int coupon_id = rs.getInt(1);
                int store_id = rs.getInt(2);
                String coupon_code = rs.getString(3);
                int discount_value = rs.getInt(4);
                Timestamp start_date = rs.getTimestamp(5);
                Timestamp end_date = rs.getTimestamp(6);
                Time start_time = rs.getTime(7);
                Time end_time = rs.getTime(8);
                int quantity = rs.getInt(9);
                String description = rs.getString(10);
                Coupon coupon = new Coupon(coupon_id, store_id, coupon_code, discount_value, start_date, end_date, start_time, end_time, quantity, description);
                coupons.add(coupon);
            }
            return coupons;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void addCoupon(Coupon coupon) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(ADD_COUPON_QUERY)) {
            pstm.setInt(1, coupon.getStore_id());
            pstm.setString(2, coupon.getCoupon_code());
            pstm.setInt(3, coupon.getDiscount_value());
            pstm.setTimestamp(4, coupon.getStart_date());
            pstm.setTimestamp(5, coupon.getEnd_date());
            pstm.setTime(6, coupon.getStart_time());
            pstm.setTime(7, coupon.getEnd_time());
            pstm.setInt(8, coupon.getQuantity());
            pstm.setString(9, coupon.getDescription());
            pstm.execute();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }

    @Override
    public void updateCoupon(Coupon coupon) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(EDIT_COUPON_QUERY)) {
            pstm.setInt(1, coupon.getStore_id());
            pstm.setString(2, coupon.getCoupon_code());
            pstm.setInt(3, coupon.getDiscount_value());
            pstm.setTimestamp(4, coupon.getStart_date());
            pstm.setTimestamp(5, coupon.getEnd_date());
            pstm.setTime(6, coupon.getStart_time());
            pstm.setTime(7, coupon.getEnd_time());
            pstm.setInt(8, coupon.getQuantity());
            pstm.setString(9, coupon.getDescription());
            pstm.setInt(10, coupon.getCoupon_id());
            pstm.execute();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }

    @Override
    public Coupon getCouponById(int couponId) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(COUPON_BY_ID_QUERY)) {
            pstm.setInt(1, couponId);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int store_id = rs.getInt(2);
                String coupon_code = rs.getString(3);
                int discount_value = rs.getInt(4);
                Timestamp start_date = rs.getTimestamp(5);
                Timestamp end_date = rs.getTimestamp(6);
                Time start_time = rs.getTime(7);
                Time end_time = rs.getTime(8);
                int quantity = rs.getInt(9);
                String description = rs.getString(10);
                Coupon coupon = new Coupon(couponId, store_id, coupon_code, discount_value, start_date, end_date, start_time, end_time, quantity, description);
                return coupon;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public List<Coupon> getListCouponsByName(String keyword) {
        List<Coupon> coupons = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(COUPON_BY_NAME_QUERY)) {
            pstm.setString(1, "%" + keyword + "%");
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int store_id = rs.getInt(2);
                String coupon_code = rs.getString(3);
                int discount_value = rs.getInt(4);
                Timestamp start_date = rs.getTimestamp(5);
                Timestamp end_date = rs.getTimestamp(6);
                Time start_time = rs.getTime(7);
                Time end_time = rs.getTime(8);
                int quantity = rs.getInt(9);
                String description = rs.getString(10);
                Coupon coupon = new Coupon(store_id, coupon_code, discount_value, start_date, end_date, start_time, end_time, quantity, description);
                coupons.add(coupon);
            }
            return coupons;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
