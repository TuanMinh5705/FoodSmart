package com.example.foodSmart.model.admin;
import java.sql.Time;
import java.sql.Timestamp;

public class Voucher {
    private int voucher_id;
    private String voucher_code;
    private int discount_value;
    private Timestamp start_date;
    private Timestamp end_date;
    private Time start_time;
    private Time end_time;
    private int quantity;
    private String description;

    public Voucher(int voucher_id, String voucher_code, Timestamp start_date, Timestamp end_date, Time start_time, Time end_time, int quantity, int discount_value, String description) {
        this.voucher_id = voucher_id;
        this.voucher_code = voucher_code;
        this.start_date = start_date;
        this.end_date = end_date;
        this.start_time = start_time;
        this.end_time = end_time;
        this.quantity = quantity;
        this.discount_value = discount_value;
        this.description = description;
    }
    public Voucher(String voucher_code, Timestamp start_date, Timestamp end_date, Time start_time, Time end_time, int quantity, int discount_value, String description) {
        this.voucher_code = voucher_code;
        this.start_date = start_date;
        this.end_date = end_date;
        this.start_time = start_time;
        this.end_time = end_time;
        this.quantity = quantity;
        this.discount_value = discount_value;
        this.description = description;
    }

    public Voucher() {
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDiscount_value() {
        return discount_value;
    }

    public void setDiscount_value(int discount_value) {
        this.discount_value = discount_value;
    }

    public Timestamp getEnd_date() {
        return end_date;
    }

    public void setEnd_date(Timestamp end_date) {
        this.end_date = end_date;
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

    public Timestamp getStart_date() {
        return start_date;
    }

    public void setStart_date(Timestamp start_date) {
        this.start_date = start_date;
    }

    public Time getStart_time() {
        return start_time;
    }

    public void setStart_time(Time start_time) {
        this.start_time = start_time;
    }

    public String getVoucher_code() {
        return voucher_code;
    }

    public void setVoucher_code(String voucher_code) {
        this.voucher_code = voucher_code;
    }

    public int getVoucher_id() {
        return voucher_id;
    }

    public void setVoucher_id(int voucher_id) {
        this.voucher_id = voucher_id;
    }

    @Override
    public String toString() {
        return "Voucher{" +
                "description='" + description + '\'' +
                ", voucher_id=" + voucher_id +
                ", voucher_code='" + voucher_code + '\'' +
                ", discount_value=" + discount_value +
                ", start_date=" + start_date +
                ", end_date=" + end_date +
                ", start_time=" + start_time +
                ", end_time=" + end_time +
                ", quantity=" + quantity +
                '}';
    }
}
