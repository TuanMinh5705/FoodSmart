package com.example.foodSmart.service;

import com.example.foodSmart.model.AccountDetails;
import com.example.foodSmart.model.Notification;
import com.example.foodSmart.service.INotificationDAO;
import com.example.foodSmart.util.ConnectDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO implements INotificationDAO {

    AccountService accountService = new AccountService();
    private static final String select_all_notification = "select * from notifications where account_id = ?";
    private static final String insert_new_notification = "insert into notifications (message, notification_type, status, created_at, account_id) values (?, ?, ?, ?, ?)";
    @Override
    public List<com.example.foodSmart.model.Notification> selectAllNotification(int accountID) {
        List<com.example.foodSmart.model.Notification> notifications = new ArrayList<>();
        try (Connection conn = ConnectDB.getConnection();
             PreparedStatement prep = conn.prepareStatement(select_all_notification);
        ) {
            prep.setInt(1, accountID);
            ResultSet rs = prep.executeQuery();

            while (rs.next()) {
                notifications.add(new Notification(
                    rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getBoolean(4),
                        rs.getTimestamp(5),
                        accountService.getAccount(rs.getInt(6))
                ));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return notifications;
    }

    @Override
    public int insertNotification(Notification notification) {
        try(Connection conn = ConnectDB.getConnection();
        PreparedStatement preparedStatement = conn.prepareStatement(insert_new_notification, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setString(1, notification.getMessage());
            preparedStatement.setString(2, notification.getType());
            preparedStatement.setBoolean(3, notification.isStatus());
            preparedStatement.setTimestamp(4, notification.getCreateAt());
            preparedStatement.setInt(5, notification.getAccount().getAccountID());

            int row = preparedStatement.executeUpdate();
            if (row > 0) {
                ResultSet rs = preparedStatement.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return -1;
    }
}
