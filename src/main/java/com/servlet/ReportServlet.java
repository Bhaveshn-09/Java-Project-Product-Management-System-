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

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;
    
    @Override
    public void init() {
        productDAO = new ProductDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String reportType = request.getParameter("type");
        String reportData = request.getParameter("data");
        
        if (reportType == null) {
            response.sendRedirect("reports.jsp");
            return;
        }
        
        try {
            if (reportType.equals("priceAbove")) {
                if (reportData != null && !reportData.isEmpty()) {
                    double minPrice = Double.parseDouble(reportData);
                    if (minPrice >= 0) {
                        List<Product> result = productDAO.getProductsByPriceAbove(minPrice);
                        request.setAttribute("reportTitle", "Products with price ≥ ₹" + String.format("%,.2f", minPrice));
                        request.setAttribute("reportResult", result);
                        request.setAttribute("reportType", "priceAbove");
                        request.setAttribute("criteria", minPrice);
                        request.setAttribute("resultCount", result.size());
                    } else {
                        request.setAttribute("error", "Price must be non-negative");
                    }
                }
            } 
            else if (reportType.equals("category")) {
                if (reportData != null && !reportData.isEmpty()) {
                    List<Product> result = productDAO.getProductsByCategory(reportData);
                    request.setAttribute("reportTitle", "Products in Category: " + reportData);
                    request.setAttribute("reportResult", result);
                    request.setAttribute("reportType", "category");
                    request.setAttribute("criteria", reportData);
                    request.setAttribute("resultCount", result.size());
                }
            } 
            else if (reportType.equals("topN")) {
                if (reportData != null && !reportData.isEmpty()) {
                    int n = Integer.parseInt(reportData);
                    if (n > 0) {
                        List<Product> result = productDAO.getTopNProductsByQuantity(n);
                        request.setAttribute("reportTitle", "Top " + n + " Products by Quantity");
                        request.setAttribute("reportResult", result);
                        request.setAttribute("reportType", "topN");
                        request.setAttribute("criteria", n);
                        request.setAttribute("resultCount", result.size());
                    } else {
                        request.setAttribute("error", "N must be positive");
                    }
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format");
        }
        
        // Get categories for dropdown
        List<String> categories = productDAO.getAllCategories();
        request.setAttribute("categories", categories);
        
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}