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
        
        String idParam = request.getParameter("id");
        
        if(idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                boolean deleted = productDAO.deleteProduct(id);
                
                if(deleted) {
                    response.sendRedirect("DisplayProductsServlet?message=Product+deleted+successfully");
                } else {
                    response.sendRedirect("DisplayProductsServlet?error=Failed+to+delete+product");
                }
            } catch(NumberFormatException e) {
                response.sendRedirect("DisplayProductsServlet?error=Invalid+product+ID");
            }
        } else {
            response.sendRedirect("DisplayProductsServlet");
        }
    }
}