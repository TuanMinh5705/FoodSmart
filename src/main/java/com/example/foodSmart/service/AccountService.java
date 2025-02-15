package com.example.foodSmart.service;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.util.ConnectDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AccountService implements IAccountService {

    private static final String AUTHENTICATE_LOGIN_QUERY = "SELECT a.*, r.role_name FROM Account a JOIN Roles r ON a.role_id = r.role_id WHERE a.username = ? AND a.password = ?";
    private static final String ACCOUNT_DETAILS_QUERY = "SELECT * FROM Account_Details WHERE user_id = ?";
    private static final String CHECK_ACCOUNT_QUERY = "SELECT * FROM Account WHERE username = ?";
    private static final String AUTHENTICATE_REGISTER_QUERY = "CALL register_account(?, ?,?, ?, ?);";
    private static final String RESET_PASSWORD_QUERY = "UPDATE Account SET password = ? WHERE username = ?";


    @Override
    public List<AccountDetails> getAccountDetails(int accountID) {
        List<AccountDetails> accountDetails = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement prep = conn.prepareStatement(ACCOUNT_DETAILS_QUERY)
        ) {
            prep.setInt(1, accountID);
            ResultSet rs = prep.executeQuery();
            while (rs.next()) {
                int accountDetailID = rs.getInt("account_detail_id");
                String address = rs.getString("address");
                String phonenumber = rs.getString("phonenumber");
                boolean isDefault = rs.getBoolean("is_default");
                AccountDetails accountDetail = new AccountDetails(accountDetailID, phonenumber, address, isDefault, accountID);
                accountDetails.add(accountDetail);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return accountDetails;
    }
    @Override
    public Account authenticateLogin(String username, String password) {
        Account account = null;
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(AUTHENTICATE_LOGIN_QUERY)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Boolean active = rs.getBoolean("active");
                    String role = rs.getString("role_name");
                    int accountID = rs.getInt("account_id");
                    String avtPath = rs.getString("avt_path");
                    List<AccountDetails> accountDetails = getAccountDetails(accountID);
                    account = new Account(accountID, username, password, avtPath, role, active, accountDetails);
                }
            }
        } catch ( SQLException e) {
            e.printStackTrace();
        }

        return account;
    }

    @Override
    public boolean checkUsername(String username) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement prep = conn.prepareStatement(CHECK_ACCOUNT_QUERY)) {
            prep.setString(1, username);
            ResultSet rs = prep.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public void authenticateRegister(Account account, AccountDetails accountDetails) {
        try (Connection conn = ConnectDB.getConnection();
             CallableStatement callableStatement = conn.prepareCall(AUTHENTICATE_REGISTER_QUERY);
        ) {
            callableStatement.setString(1, account.getUsername());
            callableStatement.setString(2, account.getPassword());
            callableStatement.setString(3, accountDetails.getAddress());
            callableStatement.setString(4, accountDetails.getPhonenumber());
            callableStatement.setString(5, account.getAvtPath());
            callableStatement.execute();
            System.out.println("Đăng kí thành công");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void resetPassword(String newPassword, String username) {
        try(Connection conn = ConnectDB.getConnection();
        PreparedStatement prep = conn.prepareStatement(RESET_PASSWORD_QUERY)){
            prep.setString(1,newPassword);
            prep.setString(2,username);
            prep.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

