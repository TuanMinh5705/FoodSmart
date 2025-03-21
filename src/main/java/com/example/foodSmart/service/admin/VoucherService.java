package com.example.foodSmart.service.admin;

import com.example.foodSmart.model.admin.Voucher;
import com.example.foodSmart.util.ConnectDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VoucherService implements IVoucherService {

    private static final String LIST_VOUCHERS_QUERY = "SELECT * FROM vouchers order by voucher_id desc";
    private static final String ADD_VOUCHERS_QUERY ="INSERT INTO Vouchers (voucher_code, discount_value, start_date, end_date, start_time, end_time, quantity, description) VALUES (?,?,?,?,?,?,?,?)";
    private static final String VOUCHER_BY_ID_QUERY = "SELECT * FROM vouchers where voucher_id = ?";
    private static final String UPDATE_VOUCHER_QUERY = "UPDATE Vouchers SET voucher_code = ?, discount_value = ?,start_date = ?,end_date = ?,start_time = ?,end_time = ?,quantity = ?,description = ? WHERE voucher_id = ?;";
    private static final String VOUCHER_BY_CODE_QUERY = "SELECT * FROM vouchers where voucher_code LIKE ?";

    @Override
    public List<Voucher> getListVouchers() {
        List<Voucher> vouchers = new ArrayList<Voucher>();
        try(Connection conn = ConnectDB.getConnection();
        PreparedStatement ps = conn.prepareStatement(LIST_VOUCHERS_QUERY)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                int voucher_id = rs.getInt("voucher_id");
                String voucher_code = rs.getString("voucher_code");
                int discount_value = rs.getInt("discount_value");
                Timestamp start_date = rs.getTimestamp("start_date");
                Timestamp end_date = rs.getTimestamp("end_date");
                Time start_time = rs.getTime("start_time");
                Time end_time = rs.getTime("end_time");
                int quantity = rs.getInt("quantity");
                String description = rs.getString("description");
                Voucher voucher = new Voucher(voucher_id,voucher_code,start_date,end_date,start_time,end_time,quantity,discount_value,description);
                vouchers.add(voucher);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return vouchers;
    }

    @Override
    public boolean addVoucher(Voucher voucher) {

        try(Connection conn = ConnectDB.getConnection();
            PreparedStatement ps = conn.prepareStatement(ADD_VOUCHERS_QUERY)) {
            ps.setString(1,voucher.getVoucher_code());
            ps.setInt(2,voucher.getDiscount_value());
            ps.setTimestamp(3,voucher.getStart_date());
            ps.setTimestamp(4,voucher.getEnd_date());
            ps.setTime(5,voucher.getStart_time());
            ps.setTime(6,voucher.getEnd_time());
            ps.setInt(7,voucher.getQuantity());
            ps.setString(8,voucher.getDescription());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Voucher getVoucherById(int id) {
        try(Connection conn = ConnectDB.getConnection();
            PreparedStatement ps = conn.prepareStatement(VOUCHER_BY_ID_QUERY)) {
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                int voucher_id = rs.getInt("voucher_id");
                String voucher_code = rs.getString("voucher_code");
                int discount_value = rs.getInt("discount_value");
                Timestamp start_date = rs.getTimestamp("start_date");
                Timestamp end_date = rs.getTimestamp("end_date");
                Time start_time = rs.getTime("start_time");
                Time end_time = rs.getTime("end_time");
                int quantity = rs.getInt("quantity");
                String description = rs.getString("description");
                return new Voucher(voucher_id,voucher_code,start_date,end_date,start_time,end_time,quantity,discount_value,description);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public boolean updateVoucher(Voucher voucher) {
        try(Connection conn = ConnectDB.getConnection();
            PreparedStatement ps = conn.prepareStatement(UPDATE_VOUCHER_QUERY)) {
            ps.setString(1,voucher.getVoucher_code());
            ps.setInt(2,voucher.getDiscount_value());
            ps.setTimestamp(3,voucher.getStart_date());
            ps.setTimestamp(4,voucher.getEnd_date());
            ps.setTime(5,voucher.getStart_time());
            ps.setTime(6,voucher.getEnd_time());
            ps.setInt(7,voucher.getQuantity());
            ps.setString(8,voucher.getDescription());
            ps.setInt(9,voucher.getVoucher_id());
            ps.execute();
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Voucher> getListVoucherByName(String keyword) {
        List<Voucher> vouchers = new ArrayList<Voucher>();
        try(Connection conn = ConnectDB.getConnection();
            PreparedStatement ps = conn.prepareStatement(VOUCHER_BY_CODE_QUERY)) {
            ps.setString(1,"%"+keyword+"%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                int voucher_id = rs.getInt("voucher_id");
                String voucher_code = rs.getString("voucher_code");
                int discount_value = rs.getInt("discount_value");
                Timestamp start_date = rs.getTimestamp("start_date");
                Timestamp end_date = rs.getTimestamp("end_date");
                Time start_time = rs.getTime("start_time");
                Time end_time = rs.getTime("end_time");
                int quantity = rs.getInt("quantity");
                String description = rs.getString("description");
                Voucher voucher = new Voucher(voucher_id,voucher_code,start_date,end_date,start_time,end_time,quantity,discount_value,description);
                vouchers.add(voucher);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return vouchers;
    }
}
