package com.example.foodSmart.model.admin;

import java.util.Objects;

public class Merchant {
    private int store_id;
    private int merchant_id;
    private String store_name;
    private String store_address;
    private String contact_number;
    private String banner_path;
    private String avt_path;
    private  boolean store_type;

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Merchant merchant = (Merchant) obj;
        return store_id == merchant.store_id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(store_id);
    }
    public Merchant() {
    }

    public Merchant(int store_id, int merchant_id, String store_name, String store_address, String contact_number, String banner_path, String avt_path, boolean store_type) {
        this.store_id = store_id;
        this.merchant_id = merchant_id;
        this.store_name = store_name;
        this.store_address = store_address;
        this.contact_number = contact_number;
        this.banner_path = banner_path;
        this.avt_path = avt_path;
        this.store_type = store_type;
    }

    public Merchant(int store_id, String store_name, String store_address, String contact_number, String banner_path, String avt_path, boolean store_type) {
        this.store_id = store_id;
        this.store_name = store_name;
        this.store_address = store_address;
        this.contact_number = contact_number;
        this.banner_path = banner_path;
        this.avt_path = avt_path;
        this.store_type = store_type;
    }

    public Merchant(String store_name, String store_address, String contact_number, String banner_path, String avt_path, boolean store_type) {

        this.store_name = store_name;
        this.store_address = store_address;
        this.contact_number = contact_number;
        this.banner_path = banner_path;
        this.avt_path = avt_path;
        this.store_type = store_type;
    }

    public int getStore_id() {
        return store_id;
    }

    public void setStore_id(int store_id) {
        this.store_id = store_id;
    }

    public int getMerchant_id() {
        return merchant_id;
    }

    public void setMerchant_id(int merchant_id) {
        this.merchant_id = merchant_id;
    }

    public String getStore_name() {
        return store_name;
    }

    public void setStore_name(String store_name) {
        this.store_name = store_name;
    }

    public String getStore_address() {
        return store_address;
    }

    public void setStore_address(String store_address) {
        this.store_address = store_address;
    }

    public String getContact_number() {
        return contact_number;
    }

    public void setContact_number(String contact_number) {
        this.contact_number = contact_number;
    }

    public String getBanner_path() {
        return banner_path;
    }

    public void setBanner_path(String banner_path) {
        this.banner_path = banner_path;
    }

    public String getAvt_path() {
        return avt_path;
    }

    public void setAvt_path(String avt_path) {
        this.avt_path = avt_path;
    }

    public boolean isStore_type() {
        return store_type;
    }

    public void setStore_type(boolean store_type) {
        this.store_type = store_type;
    }

    @Override
    public String toString() {
        return "Merchant{" +
                "store_id=" + store_id +
                ", merchant_id=" + merchant_id +
                ", store_name='" + store_name + '\'' +
                ", store_address='" + store_address + '\'' +
                ", contact_number='" + contact_number + '\'' +
                ", banner_path='" + banner_path + '\'' +
                ", avt_path='" + avt_path + '\'' +
                ", store_type=" + store_type +
                '}';
    }
}
