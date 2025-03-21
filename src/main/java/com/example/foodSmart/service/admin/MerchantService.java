package com.example.foodSmart.service.admin;

import com.example.foodSmart.model.admin.Merchant;
import com.example.foodSmart.util.ConnectDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MerchantService implements IMerchantService {
    private static final String LIST_MERCHANTS_QUERY = "select * from stores order by store_id  desc ";
    private static final String MERCHANTS_STORE_ID_QUERY = "select * from stores where store_id = ?";
    private static final String MERCHANTS_MERCHANT_ID_QUERY = "select * from stores where merchant_id = ?";
    private static final String ADD_MERCHANTS_QUERY = "INSERT INTO stores(store_name,store_address,contact_number,banner_path,avt_path,store_type,merchant_id) VALUES (?,?,?,?,?,?,?)";
    private static final String UPDATE_MERCHANTS_QUERY = "UPDATE stores SET store_name = ?,store_address = ?,contact_number = ?,banner_path = ?,avt_path = ?,store_type = ? WHERE store_id = ?";
    private static final String SEARCH_MERCHANTS_QUERY = "SELECT * FROM stores WHERE store_name LIKE ?";
    private static final String Filter_MERCHANTS_QUERY = "SELECT * FROM stores WHERE store_type = ?";

    @Override
    public List<Merchant> getListMerchants() {
        List<Merchant> merchants = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(LIST_MERCHANTS_QUERY)) {
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int store_id = rs.getInt(1);
                int merchant_id = rs.getInt(2);
                String store_name = rs.getString(3);
                String store_address = rs.getString(4);
                String contact_number = rs.getString(5);
                String banner_path = rs.getString(6);
                String avt_path = rs.getString(7);
                boolean store_type = rs.getBoolean(8);
                Merchant merchant = new Merchant(store_id, merchant_id, store_name, store_address, contact_number, banner_path, avt_path, store_type);
                merchants.add(merchant);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return merchants;
    }

    @Override
    public Merchant getMerchantById(int store_id) {
        Merchant merchant = new Merchant();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(MERCHANTS_STORE_ID_QUERY)) {
            pstm.setInt(1, store_id);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int merchant_id = rs.getInt(2);
                String store_name = rs.getString(3);
                String store_address = rs.getString(4);
                String contact_number = rs.getString(5);
                String banner_path = rs.getString(6);
                String avt_path = rs.getString(7);
                boolean store_type = rs.getBoolean(8);
                merchant = new Merchant(store_id, merchant_id, store_name, store_address, contact_number, banner_path, avt_path, store_type);

            }

            return merchant;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public Merchant getMerchantByMerchantId(int merchant_id) {
        Merchant merchant = new Merchant();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(MERCHANTS_MERCHANT_ID_QUERY)) {
            pstm.setInt(1, merchant_id);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int store_id = rs.getInt(1);
                String store_name = rs.getString(3);
                String store_address = rs.getString(4);
                String contact_number = rs.getString(5);
                String banner_path = rs.getString(6);
                String avt_path = rs.getString(7);
                boolean store_type = rs.getBoolean(8);
                merchant = new Merchant(store_id, merchant_id, store_name, store_address, contact_number, banner_path, avt_path, store_type);
            }

            return merchant;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private static final String DELETE_MERCHANT_QUERY = "DELETE FROM stores WHERE store_id = ?";

    @Override
    public void deleteMerchant(int store_id) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(DELETE_MERCHANT_QUERY)) {
            pstm.setInt(1, store_id);
            pstm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public boolean updateMerchant(Merchant merchant) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(UPDATE_MERCHANTS_QUERY)) {

            pstm.setString(1, merchant.getStore_name());
            pstm.setString(2, merchant.getStore_address());
            pstm.setString(3, merchant.getContact_number());
            pstm.setString(4, merchant.getBanner_path());
            pstm.setString(5, merchant.getAvt_path());
            pstm.setBoolean(6, merchant.isStore_type());
            pstm.setInt(7, merchant.getStore_id());
            pstm.executeUpdate();
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public boolean addMerchant(Merchant merchant) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(ADD_MERCHANTS_QUERY)) {

            pstm.setString(1, merchant.getStore_name());
            pstm.setString(2, merchant.getStore_address());
            pstm.setString(3, merchant.getContact_number());
            pstm.setString(4, merchant.getBanner_path());
            pstm.setString(5, merchant.getAvt_path());
            pstm.setBoolean(6, merchant.isStore_type());
            pstm.setInt(7,merchant.getMerchant_id());
            pstm.execute();
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Merchant> searchMerchant(String keyword) {
        List<Merchant> merchants = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstm = conn.prepareStatement(SEARCH_MERCHANTS_QUERY)) {
            pstm.setString(1, "%" + keyword + "%");
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                int store_id = rs.getInt(1);
                int merchant_id = rs.getInt(2);
                String store_name = rs.getString(3);
                String store_address = rs.getString(4);
                String contact_number = rs.getString(5);
                String banner_path = rs.getString(6);
                String avt_path = rs.getString(7);
                boolean store_type = rs.getBoolean(8);
                Merchant merchant = new Merchant(store_id, merchant_id, store_name, store_address, contact_number, banner_path, avt_path, store_type);
                merchants.add(merchant);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return merchants;
    }
    @Override
    public List<Merchant> getMerchantsByType(boolean store_type) {
        List<Merchant> merchants = new ArrayList<>();

        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(Filter_MERCHANTS_QUERY)) {
            stmt.setBoolean(1, store_type);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int store_id = rs.getInt(1);
                int merchant_id = rs.getInt(2);
                String store_name = rs.getString(3);
                String store_address = rs.getString(4);
                String contact_number = rs.getString(5);
                String banner_path = rs.getString(6);
                String avt_path = rs.getString(7);
                boolean store_Type = rs.getBoolean(8);
                merchants.add(new Merchant(store_id, merchant_id, store_name, store_address, contact_number, banner_path, avt_path, store_Type));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return merchants;
    }
}
