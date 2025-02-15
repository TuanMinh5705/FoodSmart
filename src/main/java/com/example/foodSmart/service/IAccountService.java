package com.example.foodSmart.service;

import com.example.foodSmart.model.Account;

public interface IAccountService {
    Account authenticateAccount(String username, String password);
}
