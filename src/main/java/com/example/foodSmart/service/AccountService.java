package com.example.foodSmart.service;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.util.ConnectDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AccountService implements IAccountService {

    private static final String AUTHENTICATE_ACCOUNT_QUERY = "SELECT a.*, r.role_name FROM Account a JOIN Roles r ON a.role_id = r.role_id WHERE a.username = ? AND a.password = ?";

    @Override
    public Account authenticateAccount(String username, String password) {
        Account account = null;
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(AUTHENTICATE_ACCOUNT_QUERY)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Boolean active = rs.getBoolean("active");
                    String role = rs.getString("role_name");
                    int accountID = rs.getInt("account_id");
                    String avtPath = rs.getString("avt_path");
                    account = new Account(accountID,username,password,avtPath,role,active);
                }
            }
        } catch ( SQLException e) {
            e.printStackTrace();
        }

        return account;
    }
}

