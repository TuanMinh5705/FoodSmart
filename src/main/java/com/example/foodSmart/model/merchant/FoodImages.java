package com.example.foodSmart.model.merchant;

public class FoodImages {
    private int image_id;
    private int product_id;
    private String image_path;
    private boolean is_primary;

    public FoodImages() {}


    public FoodImages(int image_id, int product_id, String image_path, boolean is_primary) {
        this.image_id = image_id;
        this.product_id = product_id;
        this.image_path = image_path;
        this.is_primary = is_primary;
    }
    public FoodImages( int product_id, String image_path, boolean is_primary) {
        this.product_id = product_id;
        this.image_path = image_path;
        this.is_primary = is_primary;
    }

    public int getImage_id() {
        return image_id;
    }

    public void setImage_id(int image_id) {
        this.image_id = image_id;
    }

    public String getImage_path() {
        return image_path;
    }

    public void setImage_path(String image_path) {
        this.image_path = image_path;
    }

    public boolean isIs_primary() {
        return is_primary;
    }

    public void setIs_primary(boolean is_primary) {
        this.is_primary = is_primary;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    @Override
    public String toString() {
        return "FoodImages{" +
                "image_id=" + image_id +
                ", product_id=" + product_id +
                ", image_path='" + image_path + '\'' +
                ", is_primary=" + is_primary +
                '}';
    }
}
