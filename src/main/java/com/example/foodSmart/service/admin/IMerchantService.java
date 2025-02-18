package com.example.foodSmart.service.admin;

import com.example.foodSmart.model.admin.Merchant;

import java.util.List;

public interface IMerchantService {
    List<Merchant> getListMerchants();
    Merchant getMerchantById(int id);
    void updateMerchant( Merchant merchant);
    void addMerchant(Merchant merchant);
}
