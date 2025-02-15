package com.example.foodSmart.model;

public class Account {
    private int accountID;
    private String username;
    private String password;
    private String avtPath;
    private String role;
    private boolean active;

    public Account() {
    }

    public Account(int accountID, String username, String password, String avtPath, String role, boolean active) {
        this.accountID = accountID;
        this.username = username;
        this.password = password;
        this.avtPath = avtPath;
        this.role = role;
        this.active = active;
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
        return "IAccountService{" +
                "accountID=" + accountID +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", avtPath='" + avtPath + '\'' +
                ", role='" + role + '\'' +
                ", active=" + active +
                '}';
    }
}