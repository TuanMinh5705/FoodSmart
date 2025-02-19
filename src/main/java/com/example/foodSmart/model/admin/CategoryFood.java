package com.example.foodSmart.model.admin;

public class CategoryFood {

    private int category_id;
    private String category_name;
    private String description;
    private String avt_path;

    public CategoryFood() {};

    public CategoryFood(int category_id, String category_name, String description, String avt_path) {
        this.category_id = category_id;
        this.category_name = category_name;
        this.description = description;
        this.avt_path = avt_path;
    }

    public String getAvt_path() {
        return avt_path;
    }

    public void setAvt_path(String avt_path) {
        this.avt_path = avt_path;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public String getCategory_name() {
        return category_name;
    }

    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "CategoryFood{" +
                "avt_path='" + avt_path + '\'' +
                ", category_id=" + category_id +
                ", category_name='" + category_name + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
