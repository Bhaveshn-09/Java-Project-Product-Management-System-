package com.model;

public class Product {
    private int productId;
    private String productName;
    private String category;
    private double price;
    private int quantity;
    
    // Default Constructor
    public Product() {}
    
    // Parameterized Constructor
    public Product(int productId, String productName, String category, double price, int quantity) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
        this.price = price;
        this.quantity = quantity;
    }
    
    // Getters
    public int getProductId() { return productId; }
    public String getProductName() { return productName; }
    public String getCategory() { return category; }
    public double getPrice() { return price; }
    public int getQuantity() { return quantity; }
    
    // Setters
    public void setProductId(int productId) { this.productId = productId; }
    public void setProductName(String productName) { this.productName = productName; }
    public void setCategory(String category) { this.category = category; }
    public void setPrice(double price) { this.price = price; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    // Business Methods
    public double getTotalValue() {
        return price * quantity;
    }
    
    public String getStockStatus() {
        if (quantity <= 0) return "Out of Stock";
        else if (quantity < 10) return "Low Stock";
        else if (quantity < 30) return "In Stock";
        else return "High Stock";
    }
    
    public String getStockBadgeClass() {
        if (quantity <= 0) return "badge-danger";
        else if (quantity < 10) return "badge-warning";
        else return "badge-success";
    }
}