package com.example.foodSmart.service;

import com.example.foodSmart.model.Notification;

import java.util.List;

public interface INotificationDAO {
    List<Notification> selectAllNotification(int accountId);

    int insertNotification(Notification notification);
}
