package com.example.foodSmart.service.user;

public interface ICartService {
    boolean addProductToCart(int product_id, int user_id, int cart_id);
}
