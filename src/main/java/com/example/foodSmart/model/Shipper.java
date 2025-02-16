package com.example.foodSmart.model;

public class Shipper {
private int shipper_id;
private String shipper_name;
private String phonenumber;
private String carrier_name;

private Shipper(){};

    public Shipper(int shipper_id, String shipper_name, String phonenumber, String carrier_name) {
        this.shipper_id = shipper_id;
        this.shipper_name = shipper_name;
        this.phonenumber = phonenumber;
        this.carrier_name = carrier_name;
    }

    public Shipper(String shipper_name, String phonenumber, String carrier_name) {
        this.shipper_name = shipper_name;
        this.phonenumber = phonenumber;
        this.carrier_name = carrier_name;
    }

    public Shipper(String phonenumber, String shipper_name) {
        this.phonenumber = phonenumber;
        this.shipper_name = shipper_name;
    }

    public String getCarrier_name() {
        return carrier_name;
    }

    public void setCarrier_name(String carrier_name) {
        this.carrier_name = carrier_name;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public int getShipper_id() {
        return shipper_id;
    }

    public void setShipper_id(int shipper_id) {
        this.shipper_id = shipper_id;
    }

    public String getShipper_name() {
        return shipper_name;
    }

    public void setShipper_name(String shipper_name) {
        this.shipper_name = shipper_name;
    }

    @Override
    public String toString() {
        return "Shipper{" +
                "carrier_name='" + carrier_name + '\'' +
                ", shipper_id=" + shipper_id +
                ", shipper_name='" + shipper_name + '\'' +
                ", phonenumber='" + phonenumber + '\'' +
                '}';
    }
}
