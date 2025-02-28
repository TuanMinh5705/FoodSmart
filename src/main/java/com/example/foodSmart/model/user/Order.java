package com.example.foodSmart.model.user;

import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.model.admin.Shipper;

import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int orderId;
    private int userId;
    private int storeId;
    private Shipper shipper;
    private int voucherId;
    private int couponId;
    private String orderStatus;
    private Timestamp shippingDate;
    private Timestamp deliveryDate;
    private Timestamp orderDate;
    private String paymentMethod;
    private String paymentStatus;
    private AccountDetails shippingInfo;
    private List<OrderItem> orderItems;

    public Order() {
    }

    public Order(int orderId, int userId, int storeId, Shipper shipper, int voucherId, int couponId, String orderStatus,
                 Timestamp shippingDate, Timestamp deliveryDate, Timestamp orderDate, String paymentMethod, String paymentStatus, AccountDetails shippingInfo, List<OrderItem> orderItems) {
        this.orderId = orderId;
        this.userId = userId;
        this.storeId = storeId;
        this.shipper = shipper;
        this.voucherId = voucherId;
        this.couponId = couponId;
        this.orderStatus = orderStatus;
        this.shippingDate = shippingDate;
        this.deliveryDate = deliveryDate;
        this.orderDate = orderDate;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.shippingInfo = shippingInfo;
        this.orderItems = orderItems;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getStoreId() {
        return storeId;
    }

    public void setStoreId(int storeId) {
        this.storeId = storeId;
    }

    public Shipper getShipper() {
        return shipper;
    }

    public void setShipper(Shipper shipper) {
        this.shipper = shipper;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }

    public int getCouponId() {
        return couponId;
    }

    public void setCouponId(int couponId) {
        this.couponId = couponId;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Timestamp getShippingDate() {
        return shippingDate;
    }

    public void setShippingDate(Timestamp shippingDate) {
        this.shippingDate = shippingDate;
    }

    public Timestamp getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Timestamp deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public AccountDetails getShippingInfo() {
        return shippingInfo;
    }

    public void setShippingInfo(AccountDetails shippingInfo) {
        this.shippingInfo = shippingInfo;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", storeId=" + storeId +
                ", shipper=" + shipper +
                ", voucherId=" + voucherId +
                ", couponId=" + couponId +
                ", orderStatus='" + orderStatus + '\'' +
                ", shippingDate=" + shippingDate +
                ", deliveryDate=" + deliveryDate +
                ", orderDate=" + orderDate +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", shippingInfo=" + shippingInfo +
                ", orderItems=" + orderItems +
                '}';
    }
}