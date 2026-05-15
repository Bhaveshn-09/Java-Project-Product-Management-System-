package com.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.ProductDAO;
import com.model.Product;

@WebServlet("/DisplayProductsServlet")
public class DisplayProductsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;
    
    @Override
    public void init() {
        productDAO = new ProductDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String searchIdStr = request.getParameter("searchId");
        
        // Search by ID if provided
        if (searchIdStr != null && !searchIdStr.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(searchIdStr);
                Product product = productDAO.getProductById(productId);
                if (product != null) {
                    request.setAttribute("searchResult", product);
                } else {
                    request.setAttribute("error", "No product found with ID: " + productId);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid Product ID format");
            }
        }
        
        // Get all products
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        request.setAttribute("totalProducts", productDAO.getProductCount());
        request.setAttribute("totalInventoryValue", productDAO.getTotalInventoryValue());
        
        // Success/Error messages
        if (request.getParameter("success") != null) {
            String success = request.getParameter("success");
            switch(success) {
                case "added": request.setAttribute("message", "✓ Product added successfully!"); break;
                case "updated": request.setAttribute("message", "✓ Product updated successfully!"); break;
                case "deleted": request.setAttribute("message", "✓ Product deleted successfully!"); break;
            }
        }
        
        if (request.getParameter("error") != null) {
            String error = request.getParameter("error");
            switch(error) {
                case "no_id": request.setAttribute("error", "No product ID provided"); break;
                case "not_found": request.setAttribute("error", "Product not found"); break;
                case "delete_failed": request.setAttribute("error", "Failed to delete product"); break;
                case "invalid_id": request.setAttribute("error", "Invalid product ID"); break;
                default: request.setAttribute("error", "Operation failed");
            }
        }
        
        request.getRequestDispatcher("display_products.jsp").forward(request, response);
    }
}