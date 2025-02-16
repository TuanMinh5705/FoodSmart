package com.example.foodSmart.model;

public class Carrier {
    private int carrier_id;
    private String carrier_name;
    private String contact_phone;
    private int shipping_cost;

    public Carrier(int carrier_id, String carrier_name, String contact_phone, int shipping_cost) {
        this.carrier_id = carrier_id;
        this.carrier_name = carrier_name;
        this.contact_phone = contact_phone;
        this.shipping_cost = shipping_cost;
    }
    public Carrier( String carrier_name, String contact_phone, int shipping_cost) {
        this.carrier_name = carrier_name;
        this.contact_phone = contact_phone;
        this.shipping_cost = shipping_cost;
    }
    public Carrier(){}

    public int getCarrier_id() {
        return carrier_id;
    }

    public void setCarrier_id(int carrier_id) {
        this.carrier_id = carrier_id;
    }

    public String getCarrier_name() {
        return carrier_name;
    }

    public void setCarrier_name(String carrier_name) {
        this.carrier_name = carrier_name;
    }

    public String getContact_phone() {
        return contact_phone;
    }

    public void setContact_phone(String contact_phone) {
        this.contact_phone = contact_phone;
    }

    public int getShipping_cost() {
        return shipping_cost;
    }

    public void setShipping_cost(int shipping_cost) {
        this.shipping_cost = shipping_cost;
    }

    @Override
    public String toString() {
        return "Carrier{" +
                "carrier_id=" + carrier_id +
                ", carrier_name='" + carrier_name + '\'' +
                ", contact_phone='" + contact_phone + '\'' +
                ", shipping_cost=" + shipping_cost +
                '}';
    }
}
