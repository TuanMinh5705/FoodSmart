package com.example.foodSmart.service;

import com.example.foodSmart.model.Account;
import com.example.foodSmart.model.AccountDetails;

import java.util.List;

public interface IAccountService {
    // Lấy thông tin chi tiết của tài khoản
    List<AccountDetails> getAccountDetails(int accountID);

    // Lấy tài khoản đăng nhập vào hệ thống
    Account authenticateLogin(String username);

    // Kiểm tra tài khoản tồn tại chưa
    boolean checkUsername(String username);

    // Đăng kí tài khoản
    boolean authenticateRegister(Account account, AccountDetails accountDetails);

    // Cập nhật mật khẩu
    void resetPassword(String newPassword, String username);

    // Danh sách tài khoản
    List<Account> getListOfAccounts();

    // Lấy thông tin cơ bản của tài khoản
    Account getAccount(int accountID);

    // Cập nhật thông tin cơ bản
    boolean editAccount(Account account);

    // Cập nhật thông tin chi tiết
    boolean editAccountDetails(AccountDetails accountDetails);

    // Thêm thông tin chi tiết cho tài khoản
    boolean addAccountDetails(AccountDetails accountDetails);

    // Xóa thông tin chi tiết của tài khoản
    boolean deleteAccountDetails(int accountDetailID);

    // Tìm kiếm theo tên đăng nhập
    List<Account> getListAccountByUsername(String keyword);

    AccountDetails getAccountDetailById(int addressId, int accountID);

    void resetDefaultAddress(int accountId);


}
