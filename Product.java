package com.model;

public class Product {

    private int id;
    private String productName;
    private String category;
    private double price;
    private int quantity;

    public Product() {}

    public Product(int id, String productName, String category, double price, int quantity) {
        this.id = id;
        this.productName = productName;
        this.category = category;
        this.price = price;
        this.quantity = quantity;
    }

    // Getters
    public int getId() { return id; }
    public String getProductName() { return productName; }
    public String getCategory() { return category; }
    public double getPrice() { return price; }
    public int getQuantity() { return quantity; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setProductName(String productName) { this.productName = productName; }
    public void setCategory(String category) { this.category = category; }
    public void setPrice(double price) { this.price = price; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    // Helper methods
    public double getTotalValue() { 
        return price * quantity; 
    }
    
    public String getStockStatus() {
        if(quantity <= 0) return "Out Of Stock";
        if(quantity < 10) return "Low Stock";
        return "In Stock";
    }
    
    public String getStockBadgeClass() {
        if(quantity <= 0) return "badge-danger";
        if(quantity < 10) return "badge-warning";
        return "badge-success";
    }
}