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
}
