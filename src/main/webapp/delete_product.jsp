<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Product, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Product - Product Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/validation.js"></script>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <div class="header">
                <h1>🗑️ Delete Product</h1>
                <p>Search and remove products from inventory</p>
                <a href="index.jsp" class="btn btn-secondary" style="margin-top: 15px;">← Back to Home</a>
            </div>
            
            <!-- Success/Error Messages -->
            <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success">
                    Product deleted successfully!
                </div>
            <% } %>
            <% if (request.getParameter("error") != null) { 
                String error = request.getParameter("error");
                String errorMsg = "";
                if ("no_id".equals(error)) errorMsg = "No product ID provided";
                else if ("not_found".equals(error)) errorMsg = "Product not found";
                else if ("delete_failed".equals(error)) errorMsg = "Failed to delete product";
                else errorMsg = "Operation failed";
            %>
                <div class="alert alert-error"><%= errorMsg %></div>
            <% } %>
            
            <!-- Search Form -->
            <div class="search-section">
                <h3>Search Product by ID</h3>
                <form action="DeleteProductServlet" method="get" style="display: flex; gap: 10px; align-items: flex-end;">
                    <div class="form-group" style="flex: 1;">
                        <label>Enter Product ID</label>
                        <input type="number" name="id" class="form-control" id="searchId" required>
                    </div>
                    <button type="submit" class="btn btn-danger" onclick="return validateSearchForm()">Search & Delete</button>
                </form>
            </div>
            
            <hr style="margin: 30px 0;">
            
            <!-- Alternative: View all products and delete -->
            <div class="all-products-section">
                <h3>All Products (Click Delete to remove)</h3>
                <div style="overflow-x: auto; margin-top: 20px;">
                    <table class="product-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Product Name</th>
                                <th>Category</th>
                                <th>Price (₹)</th>
                                <th>Quantity</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                com.dao.ProductDAO productDAO = new com.dao.ProductDAO();
                                List<Product> products = productDAO.getAllProducts();
                                if (products != null && !products.isEmpty()) {
                                    for (Product p : products) {
                            %>
                                <tr>
                                    <td><%= p.getProductId() %></td>
                                    <td><%= p.getProductName() %></td>
                                    <td><%= p.getCategory() %></td>
                                    <td>₹ <%= String.format("%,.2f", p.getPrice()) %></td>
                                    <td><%= p.getQuantity() %></td>
                                    <td>
                                        <a href="DeleteProductServlet?id=<%= p.getProductId() %>" class="btn btn-danger btn-sm" 
                                           onclick="return confirmDelete('<%= p.getProductId() %>', '<%= p.getProductName() %>')">
                                            Delete
                                        </a>
                                    </td>
                                </tr>
                            <% 
                                    }
                                } else {
                            %>
                                <tr>
                                    <td colspan="6" style="text-align: center;">No products found</td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Delete Confirmation Note -->
            <div class="alert alert-info" style="margin-top: 20px;">
                <strong>⚠️ Note:</strong> Deletion is permanent and cannot be undone. Please be careful.
            </div>
        </div>
    </div>
    
    <script>
        function confirmDelete(productId, productName) {
            return confirm('Are you sure you want to delete product: ' + productName + ' (ID: ' + productId + ')?\n\nThis action cannot be undone!');
        }
        
        function validateSearchForm() {
            let searchId = document.getElementById('searchId').value;
            if (!searchId || searchId <= 0) {
                alert('Please enter a valid Product ID to search');
                return false;
            }
            let confirmDelete = confirm('Are you sure you want to delete product with ID: ' + searchId + '?\n\nThis action cannot be undone!');
            return confirmDelete;
        }
    </script>
</body>
</html>