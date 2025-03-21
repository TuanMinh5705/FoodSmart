package com.example.foodSmart.service.admin;

import com.example.foodSmart.model.admin.Merchant;

import java.util.List;

public interface IMerchantService {
    List<Merchant> getListMerchants();
    Merchant getMerchantById(int store_id);
    boolean updateMerchant( Merchant merchant);
    boolean addMerchant(Merchant merchant);
    List<Merchant> searchMerchant(String keyword);
    List<Merchant> getMerchantsByType(boolean storeType);
    Merchant getMerchantByMerchantId(int merchant_id);
    void deleteMerchant(int store_id);
}
