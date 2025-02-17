package com.example.foodSmart.model;

import java.util.List;

public class Account {
    private int accountID;
    private String username;
    private String password;
    private String avtPath;
    private String role;
    private boolean active;
    private List<AccountDetails> accountDetails;

    public Account() {
    }

    public Account(int accountID, String username, String password, String avtPath, String role, boolean active, List<AccountDetails> accountDetails) {
        this.accountID = accountID;
        this.username = username;
        this.password = password;
        this.avtPath = avtPath;
        this.role = role;
        this.active = active;
        this.accountDetails = accountDetails;
    }

    public Account(String username, String password, String avtPath,String role) {
        this.username = username;
        this.password = password;
        this.avtPath = avtPath;
        this.role = role;
    }

    public Account(int accountID, String username, String password, String avtPath, String role, boolean active) {
        this.accountID = accountID;
        this.username = username;
        this.password = password;
        this.avtPath = avtPath;
        this.role = role;
        this.active = active;
    }

    public List<AccountDetails> getAccountDetails() {
        return accountDetails;
    }

    public void setAccountDetails(List<AccountDetails> accountDetails) {
        this.accountDetails = accountDetails;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getAvtPath() {
        return avtPath;
    }

    public void setAvtPath(String avtPath) {
        this.avtPath = avtPath;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String toString() {
        return "Account{" +
                "accountDetails=" + accountDetails +
                ", accountID=" + accountID +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", avtPath='" + avtPath + '\'' +
                ", role='" + role + '\'' +
                ", active=" + active +
                '}';
    }
}