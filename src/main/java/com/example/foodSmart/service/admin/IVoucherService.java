package com.example.foodSmart.service.admin;

import com.example.foodSmart.model.admin.Voucher;

import java.util.List;

public interface IVoucherService {
    // Danh sách mã giảm giá của sàn
    List<Voucher> getListVouchers();

    // Thêm mã giảm giá
    boolean addVoucher(Voucher voucher);

    // Lấy thông tin mã giảm giá theo id
    Voucher getVoucherById(int id);
    // Cập nhật thông tin mã giảm giá
    boolean updateVoucher(Voucher voucher);
    // Tìm kiếm theo mã
    List<Voucher> getListVoucherByName(String keyword);
}
