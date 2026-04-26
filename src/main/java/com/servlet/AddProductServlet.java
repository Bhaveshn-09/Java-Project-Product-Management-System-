package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.ProductDAO;
import com.model.Product;

@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;
    
    @Override
    public void init() {
        productDAO = new ProductDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get parameters
        String productIdStr = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        
        boolean hasError = false;
        
        // Validate Product ID
        int productId = 0;
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            request.setAttribute("idError", "Product ID is required");
            hasError = true;
        } else {
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
        }
        
        // Validate Product Name
        if (productName == null || productName.trim().isEmpty()) {
            request.setAttribute("nameError", "Product name is required");
            hasError = true;
        } else if (productName.trim().length() < 2) {
            request.setAttribute("nameError", "Product name must be at least 2 characters");
            hasError = true;
        } else if (!productName.trim().matches("[A-Za-z0-9\\s]+")) {
            request.setAttribute("nameError", "Product name can only contain letters, numbers and spaces");
            hasError = true;
        }
        
        // Validate Category
        if (category == null || category.trim().isEmpty()) {
            request.setAttribute("categoryError", "Please select a category");
            hasError = true;
        }
        
        // Validate Price
        double price = 0;
        if (priceStr == null || priceStr.trim().isEmpty()) {
            request.setAttribute("priceError", "Price is required");
            hasError = true;
        } else {
            try {
                price = Double.parseDouble(priceStr);
                if (price < 0) {
                    request.setAttribute("priceError", "Price cannot be negative");
                    hasError = true;
                } else if (price > 999999.99) {
                    request.setAttribute("priceError", "Price is too high");
                    hasError = true;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("priceError", "Invalid price format");
                hasError = true;
            }
        }
        
        // Validate Quantity
        int quantity = 0;
        if (quantityStr == null || quantityStr.trim().isEmpty()) {
            request.setAttribute("quantityError", "Quantity is required");
            hasError = true;
        } else {
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
        }
        
        // If validation fails, return to form
        if (hasError) {
            request.setAttribute("productId", productIdStr);
            request.setAttribute("productName", productName);
            request.setAttribute("category", category);
            request.setAttribute("price", priceStr);
            request.setAttribute("quantity", quantityStr);
            request.getRequestDispatcher("add_product.jsp").forward(request, response);
            return;
        }
        
        // Check if product ID already exists
        if (productDAO.getProductById(productId) != null) {
            request.setAttribute("error", "Product ID " + productId + " already exists!");
            request.getRequestDispatcher("add_product.jsp").forward(request, response);
            return;
        }
        
        // Add product
        Product product = new Product(productId, productName.trim(), category, price, quantity);
        boolean success = productDAO.addProduct(product);
        
        if (success) {
            response.sendRedirect("DisplayProductsServlet?success=added");
        } else {
            request.setAttribute("error", "Database error: Failed to add product");
            request.getRequestDispatcher("add_product.jsp").forward(request, response);
        }
    }
}