package com.example.foodSmart.model.user;

import java.sql.Timestamp;

public class Complaint {
    public int complaint_id;
    public String complaint_content;
    public String feedback;
    public boolean complaint_status;
    public Timestamp created_at;
    public int order_id;
    public Complaint() {}

    public Complaint(String complaint_content, String feedback, boolean complaint_status, Timestamp created_at, int order_id) {
        this.complaint_content = complaint_content;
        this.feedback = feedback;
        this.complaint_status = complaint_status;
        this.created_at = created_at;
        this.order_id = order_id;
    }

    public Complaint(String complaint_content, int order_id) {
        this.complaint_content = complaint_content;
        this.order_id = order_id;
    }

    public int getComplaint_id() {
        return complaint_id;
    }

    public void setComplaint_id(int complaint_id) {
        this.complaint_id = complaint_id;
    }

    public String getComplaint_content() {
        return complaint_content;
    }

    public void setComplaint_content(String complaint_content) {
        this.complaint_content = complaint_content;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public boolean isComplaint_status() {
        return complaint_status;
    }

    public void setComplaint_status(boolean complaint_status) {
        this.complaint_status = complaint_status;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    @Override
    public String toString() {
        return "Complaint{" +
                "complaint_id=" + complaint_id +
                ", complaint_content='" + complaint_content + '\'' +
                ", feedback='" + feedback + '\'' +
                ", complaint_status=" + complaint_status +
                ", created_at=" + created_at +
                ", order_id=" + order_id +
                '}';
    }
}
