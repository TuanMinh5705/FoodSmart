package com.example.foodSmart.service;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.AccountDetails;

import java.util.List;

public interface IAccountService {
    // Lấy thông tin chi tiết của tài khoản
    List<AccountDetails> getAccountDetails(int accountID);

    // Lấy tài khoản đăng nhập vào hệ thống
    Account authenticateLogin(String username, String password);

    // Kiểm tra tài khoản tồn tại chưa
    boolean checkUsername(String username);

    // Đăng kí tài khoản
    void authenticateRegister(Account account, AccountDetails accountDetails);

    // Cập nhật mật khẩu
    void resetPassword(String newPassword, String username);

    // Danh sách tài khoản
    List<Account> getListOfAccounts();

    // Lấy thông tin cơ bản của tài khoản
    Account getAccount(int accountID);

    // Cập nhật thông tin cơ bản
    void editAccount(Account account);

    // Cập nhật thông tin chi tiết
    void editAccountDetails(AccountDetails accountDetails);

    // Thêm thông tin chi tiết cho tài khoản
    void addAccountDetails(AccountDetails accountDetails);

    // Xóa thông tin chi tiết của tài khoản
    boolean deleteAccountDetails(int accountDetailID);

    // Tìm kiếm theo tên đăng nhập
    List<Account> getListAccountByUsername(String keyword);
}
