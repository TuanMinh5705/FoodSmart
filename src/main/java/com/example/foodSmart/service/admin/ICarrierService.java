package com.example.foodSmart.service.admin;

import com.example.foodSmart.model.admin.Carrier;
import com.example.foodSmart.model.admin.Shipper;

import java.util.List;

public interface ICarrierService {
    // Danh sách đối tác vận chuyển
    List<Carrier> getListCarriers();
    // Lấy thông tin chi tiết
    Carrier getCarrier(int id);
    // Cập nhật thông tin
    void updateCarrier(Carrier carrier);
    // Thêm đối tác vận chuyển
    void addCarrier(Carrier carrier);

    // Danh sách nhân viên vận chuyển
    List<Shipper> getListShippers();

    // Lấy thông tin chi tiết
    Shipper getShipper(int id);
    // Cập nhật thông tin
    void updateShipper(Shipper shipper,int carrierID);
    // Thêm nhân viên vận chuyển
    void addShipper(Shipper shipper,int carrierID);
}
