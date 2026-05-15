package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.model.Product;
import com.util.DBConnection;

public class ProductDAO {

    // ADD PRODUCT - Returns the generated ID
    public int addProduct(Product p) {
        int generatedId = 0;
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO products(productName, category, price, quantity) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getCategory());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity());
            int rows = ps.executeUpdate();
            
            if(rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if(rs.next()) {
                    generatedId = rs.getInt(1);
                }
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    // GET ALL PRODUCTS
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<Product>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM products ORDER BY id";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setProductName(rs.getString("productName"));
                p.setCategory(rs.getString("category"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                list.add(p);
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // GET PRODUCT BY ID
    public Product getProductById(int id) {
        Product p = null;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM products WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                p = new Product();
                p.setId(rs.getInt("id"));
                p.setProductName(rs.getString("productName"));
                p.setCategory(rs.getString("category"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return p;
    }

    // UPDATE PRODUCT
    public boolean updateProduct(Product p) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "UPDATE products SET productName=?, category=?, price=?, quantity=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getCategory());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity());
            ps.setInt(5, p.getId());
            int rows = ps.executeUpdate();
            if(rows > 0) status = true;
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // DELETE PRODUCT
    public boolean deleteProduct(int id) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "DELETE FROM products WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            if(rows > 0) status = true;
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // GET NEXT PRODUCT ID (For display only)
    public int getNextProductId() {
        int nextId = 1;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT MAX(id) as maxId FROM products";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                nextId = rs.getInt("maxId") + 1;
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return nextId;
    }

    // TOTAL PRODUCTS
    public int getProductCount() {
        int count = 0;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT COUNT(*) FROM products";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) count = rs.getInt(1);
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // TOTAL INVENTORY VALUE
    public double getTotalInventoryValue() {
        double total = 0;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT SUM(price * quantity) FROM products";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) total = rs.getDouble(1);
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // PRODUCTS ABOVE PRICE
    public List<Product> getProductsByPriceAbove(double minPrice) {
        List<Product> list = new ArrayList<Product>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM products WHERE price >= ? ORDER BY price DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setDouble(1, minPrice);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setProductName(rs.getString("productName"));
                p.setCategory(rs.getString("category"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                list.add(p);
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // PRODUCTS BY CATEGORY
    public List<Product> getProductsByCategory(String category) {
        List<Product> list = new ArrayList<Product>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM products WHERE category=? ORDER BY productName";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setProductName(rs.getString("productName"));
                p.setCategory(rs.getString("category"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                list.add(p);
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // TOP N PRODUCTS BY QUANTITY
    public List<Product> getTopNProductsByQuantity(int n) {
        List<Product> list = new ArrayList<Product>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM products ORDER BY quantity DESC LIMIT ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, n);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setProductName(rs.getString("productName"));
                p.setCategory(rs.getString("category"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                list.add(p);
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // GET ALL CATEGORIES
    public List<String> getAllCategories() {
        List<String> list = new ArrayList<String>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT DISTINCT category FROM products ORDER BY category";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                list.add(rs.getString("category"));
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}