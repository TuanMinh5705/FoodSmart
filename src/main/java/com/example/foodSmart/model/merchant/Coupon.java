package com.example.foodSmart.model.merchant;

import java.sql.Timestamp;
import java.sql.Time;

public class Coupon {
    private int coupon_id;
    private int store_id;
    private String coupon_code;
    private int discount_value;
    private Timestamp start_date;
    private Timestamp end_date;
    private Time start_time;
    private Time end_time;
    private int quantity;
    private String description;
    private String store_name;


    public Coupon() {
    }

    public Coupon(int coupon_id, int store_id, String coupon_code, int discount_value, Timestamp start_date, Timestamp end_date, Time start_time, Time end_time, int quantity, String description) {
        this.coupon_id = coupon_id;
        this.store_id = store_id;
        this.coupon_code = coupon_code;
        this.discount_value = discount_value;
        this.start_date = start_date;
        this.end_date = end_date;
        this.start_time = start_time;
        this.end_time = end_time;
        this.quantity = quantity;
        this.description = description;
    }
    public Coupon(int store_id, String coupon_code, int discount_value, Timestamp start_date, Timestamp end_date, Time start_time, Time end_time, int quantity, String description) {
        this.store_id = store_id;
        this.coupon_code = coupon_code;
        this.discount_value = discount_value;
        this.start_date = start_date;
        this.end_date = end_date;
        this.start_time = start_time;
        this.end_time = end_time;
        this.quantity = quantity;
        this.description = description;
    }

    public Coupon(int coupon_id, int store_id, String coupon_code, int discount_value, Timestamp start_date, Timestamp end_date, Time start_time, Time end_time, int quantity, String description, String store_name) {
        this.coupon_id = coupon_id;
        this.store_id = store_id;
        this.coupon_code = coupon_code;
        this.discount_value = discount_value;
        this.start_date = start_date;
        this.end_date = end_date;
        this.start_time = start_time;
        this.end_time = end_time;
        this.quantity = quantity;
        this.description = description;
        this.store_name = store_name;
    }

    public String getStore_name() {
        return store_name;
    }

    public void setStore_name(String store_name) {
        this.store_name = store_name;
    }


    public int getCoupon_id() {
        return coupon_id;
    }

    public void setCoupon_id(int coupon_id) {
        this.coupon_id = coupon_id;
    }

    public int getStore_id() {
        return store_id;
    }

    public void setStore_id(int store_id) {
        this.store_id = store_id;
    }

    public String getCoupon_code() {
        return coupon_code;
    }

    public void setCoupon_code(String coupon_code) {
        this.coupon_code = coupon_code;
    }

    public int getDiscount_value() {
        return discount_value;
    }

    public void setDiscount_value(int discount_value) {
        this.discount_value = discount_value;
    }

    public Timestamp getStart_date() {
        return start_date;
    }

    public void setStart_date(Timestamp start_date) {
        this.start_date = start_date;
    }

    public Timestamp getEnd_date() {
        return end_date;
    }

    public void setEnd_date(Timestamp end_date) {
        this.end_date = end_date;
    }

    public Time getStart_time() {
        return start_time;
    }

    public void setStart_time(Time start_time) {
        this.start_time = start_time;
    }

    public Time getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Time end_time) {
        this.end_time = end_time;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Coupon{" +
                "coupon_id=" + coupon_id +
                ", store_id=" + store_id +
                ", coupon_code='" + coupon_code + '\'' +
                ", discount_value=" + discount_value +
                ", start_date=" + start_date +
                ", end_date=" + end_date +
                ", start_time=" + start_time +
                ", end_time=" + end_time +
                ", quantity=" + quantity +
                ", description='" + description + '\'' +
                '}';
    }



}
