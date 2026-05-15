package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.ProductDAO;
import com.model.Product;

@WebServlet("/UpdateProductServlet")
public class UpdateProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;
    
    @Override
    public void init() {
        productDAO = new ProductDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String productIdStr = request.getParameter("id");
        if (productIdStr != null && !productIdStr.isEmpty()) {
            try {
                int productId = Integer.parseInt(productIdStr);
                Product product = productDAO.getProductById(productId);
                if (product != null) {
                    request.setAttribute("product", product);
                } else {
                    request.setAttribute("error", "Product not found with ID: " + productId);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid Product ID");
            }
        }
        request.getRequestDispatcher("update_product.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String productIdStr = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        
        boolean hasError = false;
        
        // Validate Product ID
        int productId = 0;
        try {
            productId = Integer.parseInt(productIdStr);
            if (productId <= 0) {
                request.setAttribute("idError", "Product ID must be a positive number");
                hasError = true;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("idError", "Invalid Product ID format");
            hasError = true;
        }
        
        // Check if product exists
        Product existingProduct = productDAO.getProductById(productId);
        if (existingProduct == null && !hasError) {
            request.setAttribute("error", "Product ID not found!");
            hasError = true;
        }
        
        // Validate Product Name
        if (productName == null || productName.trim().isEmpty()) {
            request.setAttribute("nameError", "Product name is required");
            hasError = true;
        } else if (productName.trim().length() < 2) {
            request.setAttribute("nameError", "Product name must be at least 2 characters");
            hasError = true;
        }
        
        // Validate Category
        if (category == null || category.trim().isEmpty()) {
            request.setAttribute("categoryError", "Please select a category");
            hasError = true;
        }
        
        // Validate Price
        double price = 0;
        try {
            price = Double.parseDouble(priceStr);
            if (price < 0) {
                request.setAttribute("priceError", "Price cannot be negative");
                hasError = true;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("priceError", "Invalid price format");
            hasError = true;
        }
        
        // Validate Quantity
        int quantity = 0;
        try {
            quantity = Integer.parseInt(quantityStr);
            if (quantity < 0) {
                request.setAttribute("quantityError", "Quantity cannot be negative");
                hasError = true;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("quantityError", "Invalid quantity format");
            hasError = true;
        }
        
        if (hasError) {
            request.setAttribute("productId", productIdStr);
            request.setAttribute("productName", productName);
            request.setAttribute("category", category);
            request.setAttribute("price", priceStr);
            request.setAttribute("quantity", quantityStr);
            request.getRequestDispatcher("update_product.jsp").forward(request, response);
            return;
        }
        
        // Update product
        Product product = new Product(productId, productName.trim(), category, price, quantity);
        boolean success = productDAO.updateProduct(product);
        
        if (success) {
            response.sendRedirect("DisplayProductsServlet?success=updated");
        } else {
            request.setAttribute("error", "Failed to update product");
            request.getRequestDispatcher("update_product.jsp").forward(request, response);
        }
    }
}