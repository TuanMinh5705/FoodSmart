package com.example.foodSmart.model.user;

public class OrderItem {
    private int productId;
    private int priceAtTime;
    private int quantity;

    public OrderItem() {
    }

    public OrderItem(int productId, int priceAtTime, int quantity) {
        this.productId = productId;
        this.priceAtTime = priceAtTime;
        this.quantity = quantity;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getPriceAtTime() {
        return priceAtTime;
    }

    public void setPriceAtTime(int priceAtTime) {
        this.priceAtTime = priceAtTime;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "productId=" + productId +
                ", priceAtTime=" + priceAtTime +
                ", quantity=" + quantity +
                '}';
    }
}
