package com.example.foodSmart.model;

public class AccountDetails {
    private int accountDetailsID;
    private String phonenumber;
    private String address;
    private boolean deafault;
    private int acccountID;

    public AccountDetails() {}

    public AccountDetails(int accountDetailsID, String phonenumber, String address, boolean deafault, int acccountID) {
        this.accountDetailsID = accountDetailsID;
        this.phonenumber = phonenumber;
        this.address = address;
        this.deafault = deafault;
        this.acccountID = acccountID;
    }

    public AccountDetails(String address, String phonenumber) {
        this.address = address;
        this.phonenumber = phonenumber;
    }

    public int getAcccountID() {
        return acccountID;
    }

    public void setAcccountID(int acccountID) {
        this.acccountID = acccountID;
    }

    public int getAccountDetailsID() {
        return accountDetailsID;
    }

    public void setAccountDetailsID(int accountDetailsID) {
        this.accountDetailsID = accountDetailsID;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isDeafault() {
        return deafault;
    }

    public void setDeafault(boolean deafault) {
        this.deafault = deafault;
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
                "acccountID=" + acccountID +
                ", accountDetailsID=" + accountDetailsID +
                ", phonenumber='" + phonenumber + '\'' +
                ", address='" + address + '\'' +
                ", deafault=" + deafault +
                '}';
    }
}
