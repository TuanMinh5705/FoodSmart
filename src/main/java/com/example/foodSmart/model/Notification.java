package com.example.foodSmart.model;

import java.sql.Timestamp;

public class Notification {
    private int notificationId;
    private String message;
    private String type;
    private boolean status;
    private java.sql.Timestamp createAt;
    private Account account;

    public Notification(int notificationId, String message, String type, boolean status, Timestamp createAt, Account account) {
        this.notificationId = notificationId;
        this.message = message;
        this.type = type;
        this.status = status;
        this.createAt = createAt;
        this.account = account;
    }

    public Notification(String message, String type, Account account) {
        this.message = message;
        this.type = type;
        this.account = account;
    }

    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public java.sql.Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(java.sql.Timestamp createAt) {
        this.createAt = createAt;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    @Override
    public String toString() {
        return "Notification{" +
                "notificationId=" + notificationId +
                ", message='" + message + '\'' +
                ", type='" + type + '\'' +
                ", status=" + status +
                ", createAt=" + createAt +
                ", account=" + account +
                '}';
    }
}
