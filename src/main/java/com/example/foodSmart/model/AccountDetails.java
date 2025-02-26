package com.example.foodSmart.model;

public class AccountDetails {
    private int accountDetailID;
    private String phonenumber;
    private String address;
    private boolean isDefault;
    private int accountID;

    public AccountDetails() {}

    public AccountDetails(int accountDetailID, String phonenumber, String address, boolean isDefault, int accountID) {
        this.accountDetailID = accountDetailID;
        this.phonenumber = phonenumber;
        this.address = address;
        this.isDefault = isDefault;
        this.accountID = accountID;
    }

    public AccountDetails(String address, String phonenumber) {
        this.address = address;
        this.phonenumber = phonenumber;
    }

    public AccountDetails(int accountID, String address, String phonenumber, Boolean isDefault) {
        this.phonenumber = phonenumber;
        this.address = address;
        this.isDefault = isDefault;
        this.accountID = accountID;
    }
    public AccountDetails(int accountID,int accountDetailID, String address, String phonenumber, Boolean isDefault) {
        this.phonenumber = phonenumber;
        this.accountDetailID = accountDetailID;
        this.address = address;
        this.isDefault = isDefault;
        this.accountID = accountID;
    }

    public AccountDetails(int addressId, String recipientName, String phoneNumber, String address, boolean isDefault) {
    }


    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public int getAccountDetailID() {
        return accountDetailID;
    }

    public void setAccountDetailID(int accountDetailsID) {
        this.accountDetailID = accountDetailsID;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isDefault() {
        return isDefault;
    }

    public void setDefault(boolean aDefault) {
        isDefault = aDefault;
    }

    public boolean getIsDefault() {
        return isDefault;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    @Override
    public String toString() {
        return "AccountDetails{" +
                "accountID=" + accountID +
                ", accountDetailsID=" + accountDetailID +
                ", phonenumber='" + phonenumber + '\'' +
                ", address='" + address + '\'' +
                ", isDeafault=" + isDefault +
                '}';
    }
}
