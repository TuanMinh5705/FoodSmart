package com.example.foodSmart.service.merchant;

import com.example.foodSmart.model.admin.Voucher;
import com.example.foodSmart.model.merchant.Coupon;

import java.util.List;

public interface ICouponSerice {
    List<Coupon> getListCoupons(int store_id);
    void addCoupon(Coupon coupon);
    void updateCoupon(Coupon coupon);
    Coupon getCouponById(int couponId);
    List<Coupon> getListCoupon();
    List<Coupon> getListCouponsByName(String keyword);
}
