package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.ProductDAO;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;
    
    @Override
    public void init() {
        productDAO = new ProductDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String productIdStr = request.getParameter("id");
        
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.sendRedirect("DisplayProductsServlet?error=no_id");
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdStr);
            
            // Check if product exists
            if (productDAO.getProductById(productId) == null) {
                response.sendRedirect("DisplayProductsServlet?error=not_found");
                return;
            }
            
            boolean success = productDAO.deleteProduct(productId);
            if (success) {
                response.sendRedirect("DisplayProductsServlet?success=deleted");
            } else {
                response.sendRedirect("DisplayProductsServlet?error=delete_failed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("DisplayProductsServlet?error=invalid_id");
        }
    }
}