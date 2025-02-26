package com.example.foodSmart.service.admin;

import com.example.foodSmart.model.admin.Carrier;
import com.example.foodSmart.model.admin.Shipper;
import com.example.foodSmart.util.ConnectDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CarrierService implements ICarrierService {

    private static final String LIST_CARRIERS_QUERY = "SELECT * FROM carriers ORDER BY carrier_id desc";
    private static final String CARRIERS_BY_ID_QUERY = "SELECT * FROM carriers WHERE carrier_id =?";
    private static final String UPDATE_CARRIER_QUERY = "UPDATE Carriers SET carrier_name = ?, contact_phone = ?, shipping_cost = ? WHERE carrier_id = ?";
    private static final String ADD_CARRIER_QUERY = " INSERT INTO carriers(carrier_name,contact_phone,shipping_cost) VALUES (  ?, ?, ?)";
    private static final String LIST_SHIPPERS_QUERY = "SELECT s.*, c.carrier_name FROM Shippers s JOIN Carriers c ON s.carrier_id = c.carrier_id order by s.shipper_id desc ;";
    private static final String SHIPPERS_BY_ID_QUERY = "SELECT s.*, c.carrier_name FROM Shippers s JOIN Carriers c ON s.carrier_id = c.carrier_id where s.shipper_id =?;";
    private static final String UPDATE_SHIPPER_QUERY = "UPDATE Shippers SET shipper_name = ?,phonenumber = ?,carrier_id = ? WHERE shipper_id = ?;";
    private static final String ADD_SHIPPER_QUERY = "INSERT INTO shippers(carrier_id,shipper_name,phonenumber) VALUES (?,?,?);";

    @Override
    public List<Carrier> getListCarriers() {
        List<Carrier> carriers = new ArrayList<Carrier>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(LIST_CARRIERS_QUERY)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int carrier_id = rs.getInt(1);
                String carrier_name = rs.getString(2);
                String contact_number = rs.getString(3);
                int shipping_cost = rs.getInt(4);
                Carrier carrier = new Carrier(carrier_id, carrier_name, contact_number, shipping_cost);
                carriers.add(carrier);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return carriers;
    }

    @Override
    public Carrier getCarrier(int id) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(CARRIERS_BY_ID_QUERY)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int carrier_id = rs.getInt(1);
                String carrier_name = rs.getString(2);
                String contact_number = rs.getString(3);
                int shipping_cost = rs.getInt(4);
                return new Carrier(carrier_id, carrier_name, contact_number, shipping_cost);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public void updateCarrier(Carrier carrier) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_CARRIER_QUERY)) {
            ps.setString(1, carrier.getCarrier_name());
            ps.setString(2, carrier.getContact_phone());
            ps.setInt(3, carrier.getShipping_cost());
            ps.setInt(4, carrier.getCarrier_id());
            ps.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void addCarrier(Carrier carrier) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(ADD_CARRIER_QUERY)) {
            ps.setString(1, carrier.getCarrier_name());
            ps.setString(2, carrier.getContact_phone());
            ps.setInt(3, carrier.getShipping_cost());
            ps.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Shipper> getListShippers() {
        List<Shipper> shippers = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(LIST_SHIPPERS_QUERY)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int shipper_id = rs.getInt(1);
                String shipper_name = rs.getString(3);
                String phonenumber = rs.getString(4);
                String carrier_name = rs.getString(5);
                Shipper shipper = new Shipper(shipper_id, shipper_name, phonenumber, carrier_name);
                shippers.add(shipper);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return shippers;
    }

    @Override
    public Shipper getShipper(int id) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(SHIPPERS_BY_ID_QUERY)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int shipper_id = rs.getInt(1);
                String shipper_name = rs.getString(3);
                String phonenumber = rs.getString(4);
                String carrier_name = rs.getString(5);
                return new Shipper(shipper_id, shipper_name, phonenumber, carrier_name);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public void updateShipper(Shipper shipper,int carrierID) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_SHIPPER_QUERY)) {
        ps.setString(1,shipper.getShipper_name());
        ps.setString(2,shipper.getPhonenumber());
        ps.setInt(3,carrierID);
        ps.setInt(4,shipper.getShipper_id());
        ps.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void addShipper(Shipper shipper, int carrierID) {
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(ADD_SHIPPER_QUERY)) {
            ps.setInt(1,carrierID);
            ps.setString(2,shipper.getShipper_name());
            ps.setString(3, shipper.getPhonenumber());
            ps.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

