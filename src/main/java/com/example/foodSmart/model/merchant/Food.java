package com.example.foodSmart.model.merchant;

import java.util.List;

public class Food {
    private int product_id;
    private int store_id;
    private String product_name;
    private int price;
    private int stock_quantity;
    private int discount;
    private int category_id;
    private int total_sold;
    private List<FoodImages> list_food_images;

    public Food(){}

    public Food(int product_id, int store_id, String product_name, int price, int stock_quantity, int discount, List<FoodImages> list_food_images) {
        this.product_id = product_id;
        this.store_id = store_id;
        this.product_name = product_name;
        this.price = price;
        this.stock_quantity = stock_quantity;
        this.discount = discount;
        this.list_food_images = list_food_images;
    }

    public Food(int product_id, int store_id, String product_name, int price, int stock_quantity, int discount, int category_id, List<FoodImages> list_food_images) {
        this.product_id = product_id;
        this.store_id = store_id;
        this.product_name = product_name;
        this.price = price;
        this.stock_quantity = stock_quantity;
        this.discount = discount;
        this.category_id = category_id;
        this.list_food_images = list_food_images;
    }

    public Food(int product_id, int store_id, String product_name, int price, int stock_quantity, int discount, int category_id, int total_sold, List<FoodImages> list_food_images) {
        this.product_id = product_id;
        this.store_id = store_id;
        this.product_name = product_name;
        this.price = price;
        this.stock_quantity = stock_quantity;
        this.discount = discount;
        this.category_id = category_id;
        this.total_sold = total_sold;
        this.list_food_images = list_food_images;
    }

    public int getTotal_sold() {
        return total_sold;
    }

    public void setTotal_sold(int total_sold) {
        this.total_sold = total_sold;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public List<FoodImages> getList_food_images() {
        return list_food_images;
    }

    public void setList_food_images(List<FoodImages> list_food_images) {
        this.list_food_images = list_food_images;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public int getStock_quantity() {
        return stock_quantity;
    }

    public void setStock_quantity(int stock_quantity) {
        this.stock_quantity = stock_quantity;
    }

    public int getStore_id() {
        return store_id;
    }

    public void setStore_id(int store_id) {
        this.store_id = store_id;
    }

    @Override
    public String toString() {
        return "Food{" +
                "category_id=" + category_id +
                ", product_id=" + product_id +
                ", store_id=" + store_id +
                ", product_name='" + product_name + '\'' +
                ", price=" + price +
                ", stock_quantity=" + stock_quantity +
                ", discount=" + discount +
                ", total_sold=" + total_sold +
                ", list_food_images=" + list_food_images +
                '}';
    }
}
