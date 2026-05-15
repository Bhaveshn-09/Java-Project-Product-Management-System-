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

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get Form Data
            String productName = request.getParameter("productName");
            String category = request.getParameter("category");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Create Product Object (id will be auto-generated)
            Product product = new Product();
            product.setProductName(productName);
            product.setCategory(category);
            product.setPrice(price);
            product.setQuantity(quantity);

            // DAO Object
            ProductDAO dao = new ProductDAO();
            int generatedId = dao.addProduct(product);

            // Success / Failure Message
            if (generatedId > 0) {
                request.setAttribute("message", "Product Added Successfully! Generated ID: " + generatedId);
                request.setAttribute("generatedId", generatedId);
            } else {
                request.setAttribute("error", "Failed To Add Product!");
            }

        } catch (Exception e) {
            request.setAttribute("error", "Error : " + e.getMessage());
            e.printStackTrace();
        }

        // Forward back to JSP page
        request.getRequestDispatcher("add_product.jsp")
               .forward(request, response);
    }
}