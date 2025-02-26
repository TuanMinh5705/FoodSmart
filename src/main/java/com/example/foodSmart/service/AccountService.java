package com.example.foodSmart.service;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.util.ConnectDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AccountService implements IAccountService {

    private static final String AUTHENTICATE_LOGIN_QUERY = "SELECT a.*, r.role_name FROM Account a JOIN Roles r ON a.role_id = r.role_id WHERE LOWER(a.username) = LOWER(?)";
    private static final String ACCOUNT_BY_ID_QUERY = "SELECT a.*, r.role_name FROM Account a JOIN Roles r ON a.role_id = r.role_id WHERE a.account_id = ?";
    private static final String ACCOUNT_DETAILS_QUERY = "SELECT * FROM Account_Details WHERE user_id = ?";
    private static final String ACCOUNT_BY_USERNAME_QUERY = "SELECT * FROM Account WHERE username = ?";
    private static final String AUTHENTICATE_REGISTER_QUERY = "CALL register_account(?, ?,?, ?, ?,?);";
    private static final String RESET_PASSWORD_QUERY = "UPDATE Account SET password = ? WHERE username = ?";
    private static final String LIST_ACCOUNTS_QUERY = "SELECT a.*, r.role_name FROM Account a JOIN Roles r ON a.role_id = r.role_id WHERE a.role_id != 1 ORDER BY a.account_id DESC ";
    private static final String UPDATE_ACCOUNT_QUERY = "CALL updateAccountInfo(?,?,?,?,?,?)";
    private static final String UPDATE_ACCOUNT_DETAILS_QUERY = "UPDATE Account_Details SET address = ?, phonenumber = ?, is_default = ? WHERE account_details_id = ?";
    private static final String ADD_ACCOUNT_DETAILS_QUERY = "INSERT INTO Account_Details(user_id,address,phonenumber,is_default) VALUES(?, ?, ?, ?)";
    private static final String DELETE_ACCOUNT_DETAILS_QUERY = "DELETE FROM Account_Details WHERE account_details_id = ?";
    private static final String LIST_ACCOUNT_BY_USERNAME_QUERY = "SELECT a.*, r.role_name FROM Account a JOIN Roles r ON a.role_id = r.role_id WHERE a.username LIKE ?";
    private static final String GET_ACCOUNT_DETAILS_BY_ID = "SELECT * FROM Account_Details WHERE account_details_id = ?";

    private static final String UPDATE_DEFAULT_QUERY = "UPDATE Account_Details SET is_default = false WHERE account_details_id = ?";

    @Override
    public List<AccountDetails> getAccountDetails(int accountID) {
        List<AccountDetails> accountDetails = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement prep = conn.prepareStatement(ACCOUNT_DETAILS_QUERY)
        ) {
            prep.setInt(1, accountID);
            ResultSet rs = prep.executeQuery();
            while (rs.next()) {
                int accountDetailID = rs.getInt("account_details_id");
                String address = rs.getString("address");
                String phonenumber = rs.getString("phonenumber");
                boolean isDefault = rs.getBoolean("is_default");
                AccountDetails accountDetail = new AccountDetails(accountDetailID, address, phonenumber, isDefault, accountID);
                accountDetails.add(accountDetail);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return accountDetails;
    }

    @Override
    public Account authenticateLogin(String username) {
        Account account = null;
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(AUTHENTICATE_LOGIN_QUERY)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    String username1 = rs.getString("username");
                    Boolean active = rs.getBoolean("active");
                    String role = rs.getString("role_name");
                    String password = rs.getString("password");
                    int accountID = rs.getInt("account_id");
                    String avtPath = rs.getString("avt_path");
                    List<AccountDetails> accountDetails = getAccountDetails(accountID);
                    account = new Account(accountID, username1, password, avtPath, role, active, accountDetails);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return account;
    }

    @Override
    public boolean checkUsername(String username) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement prep = conn.prepareStatement(ACCOUNT_BY_USERNAME_QUERY)) {
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
    public boolean authenticateRegister(Account account, AccountDetails accountDetails) {
        try (Connection conn = ConnectDB.getConnection();
             CallableStatement callableStatement = conn.prepareCall(AUTHENTICATE_REGISTER_QUERY);
        ) {
            callableStatement.setString(1, account.getUsername());
            callableStatement.setString(2, account.getPassword());
            callableStatement.setString(3, accountDetails.getAddress());
            callableStatement.setString(4, accountDetails.getPhonenumber());
            callableStatement.setString(5, account.getAvtPath());
            callableStatement.setString(6, account.getRole());
            callableStatement.execute();
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void resetPassword(String newPassword, String username) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement prep = conn.prepareStatement(RESET_PASSWORD_QUERY)) {
            prep.setString(1, newPassword);
            prep.setString(2, username);
            prep.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Account> getListOfAccounts() {
        List<Account> accounts = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement prep = conn.prepareStatement(LIST_ACCOUNTS_QUERY)) {
            ResultSet rs = prep.executeQuery();
            while (rs.next()) {
                int accountID = rs.getInt("account_id");
                String avtPath = rs.getString("avt_path");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String role = rs.getString("role_name");
                boolean active = rs.getBoolean("active");
                Account account = new Account(accountID, username, password, avtPath, role, active);
                accounts.add(account);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return accounts;
    }

    @Override
    public Account getAccount(int accountID) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement prep = conn.prepareStatement(ACCOUNT_BY_ID_QUERY)) {
            Account account = new Account();
            prep.setInt(1, accountID);
            ResultSet rs = prep.executeQuery();
            if (rs.next()) {
                String username = rs.getString("username");
                String password = rs.getString("password");
                String avtPath = rs.getString("avt_path");
                String role = rs.getString("role_name");
                boolean active = rs.getBoolean("active");
                account = new Account(accountID, username, password, avtPath, role, active);
                return account;
            }
            prep.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public boolean editAccount(Account account) {
        try (Connection conn = ConnectDB.getConnection();
             CallableStatement cs = conn.prepareCall(UPDATE_ACCOUNT_QUERY);
        ) {
            cs.setInt(1, account.getAccountID());
            cs.setString(2, account.getUsername());
            cs.setString(3, account.getPassword());
            cs.setBoolean(4, account.isActive());
            cs.setString(5, account.getAvtPath());
            cs.setString(6, account.getRole());
            cs.execute();
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);

        }
    }

    @Override
    public boolean editAccountDetails(AccountDetails accountDetails) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement prep = conn.prepareStatement(UPDATE_ACCOUNT_DETAILS_QUERY)) {
            prep.setString(1, accountDetails.getAddress());
            prep.setString(2, accountDetails.getPhonenumber());
            prep.setBoolean(3, accountDetails.isDefault());
            prep.setInt(4, accountDetails.getAccountDetailID());
            prep.execute();
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean addAccountDetails(AccountDetails accountDetails) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement prep = conn.prepareStatement(ADD_ACCOUNT_DETAILS_QUERY)) {
            prep.setInt(1, accountDetails.getAccountID());
            prep.setString(2, accountDetails.getAddress());
            prep.setString(3, accountDetails.getPhonenumber());
            prep.setBoolean(4, accountDetails.isDefault());
            prep.execute();
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean deleteAccountDetails(int accountDetailID) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement prep = conn.prepareStatement(DELETE_ACCOUNT_DETAILS_QUERY)) {
            prep.setInt(1, accountDetailID);
            prep.execute();
            return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Account> getListAccountByUsername(String keyword) {
        List<Account> accounts = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement prep = conn.prepareStatement(LIST_ACCOUNT_BY_USERNAME_QUERY)) {
            prep.setString(1, "%" + keyword + "%");
            ResultSet rs = prep.executeQuery();
            while (rs.next()) {
                int accountID = rs.getInt("account_id");
                String avtPath = rs.getString("avt_path");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String role = rs.getString("role_name");
                boolean active = rs.getBoolean("active");
                Account account = new Account(accountID, username, password, avtPath, role, active);
                accounts.add(account);
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
        return accounts;
    }

    @Override
    public AccountDetails getAccountDetailById(int addressId, int accountID) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement prep = conn.prepareStatement(GET_ACCOUNT_DETAILS_BY_ID)) {
            prep.setInt(1, addressId);
            ResultSet rs = prep.executeQuery();
            if (rs.next()) {
                int accountDetailID = rs.getInt("account_details_id");
                String address = rs.getString("address");
                String phonenumber = rs.getString("phonenumber");
                boolean isDefault = rs.getBoolean("is_default");
                AccountDetails accountDetail = new AccountDetails(accountID, accountDetailID, address, phonenumber, isDefault);
                return accountDetail;
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public void resetDefaultAddress(int accountId) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_DEFAULT_QUERY)) {
            stmt.setInt(1, accountId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }




}


