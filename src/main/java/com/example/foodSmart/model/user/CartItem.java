package com.example.foodSmart.model.user;

import com.example.foodSmart.model.merchant.Food;

public class CartItem {
    private int storeId;
    private int productId;
    private int priceAtTime;
    private int quantity;
    private Food food;

    public CartItem() {
    }

    public CartItem(int storeId, int productId, int priceAtTime, int quantity) {
        this.storeId = storeId;
        this.productId = productId;
        this.priceAtTime = priceAtTime;
        this.quantity = quantity;
    }
    public CartItem( int productId, int priceAtTime, int quantity) {
        this.productId = productId;
        this.priceAtTime = priceAtTime;
        this.quantity = quantity;
    }

    public Food getFood() {
        return food;
    }

    public void setFood(Food food) {
        this.food = food;
    }

    public int getPriceAtTime() {
        return priceAtTime;
    }

    public void setPriceAtTime(int priceAtTime) {
        this.priceAtTime = priceAtTime;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getStoreId() {
        return storeId;
    }

    public void setStoreId(int storeId) {
        this.storeId = storeId;
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "priceAtTime=" + priceAtTime +
                ", storeId=" + storeId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                '}';
    }
}
