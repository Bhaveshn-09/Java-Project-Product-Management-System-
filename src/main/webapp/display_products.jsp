<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Display Products - Product Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/validation.js"></script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>👁️ Product Inventory</h1>
            <p>View and manage all products</p>
            <a href="index.jsp" class="btn btn-secondary" style="margin-top: 15px;">← Back to Home</a>
        </div>
        
        <!-- Statistics Cards -->
        <div class="stats-container">
            <div class="stat-card">
                <h3><%= request.getAttribute("totalProducts") != null ? request.getAttribute("totalProducts") : 0 %></h3>
                <p>Total Products</p>
            </div>
            <div class="stat-card">
                <h3>₹ <%= String.format("%,.2f", request.getAttribute("totalInventoryValue") != null ? request.getAttribute("totalInventoryValue") : 0) %></h3>
                <p>Total Inventory Value</p>
            </div>
        </div>
        
        <!-- Success/Error Messages -->
        <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("message") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <!-- Search Bar -->
        <div class="table-container">
            <div class="search-bar">
                <form action="DisplayProductsServlet" method="get" style="display: flex; gap: 10px; width: 100%;">
                    <div class="form-group" style="flex: 1; margin-bottom: 0;">
                        <input type="number" name="searchId" class="form-control" id="searchId" placeholder="Enter Product ID to search...">
                    </div>
                    <button type="submit" class="btn btn-primary" onclick="return validateSearchForm()">Search</button>
                    <a href="DisplayProductsServlet" class="btn btn-secondary">Show All</a>
                </form>
            </div>
            
            <!-- Search Result -->
            <% if (request.getAttribute("searchResult") != null) { 
                Product searchResult = (Product) request.getAttribute("searchResult");
            %>
                <div class="alert alert-info">
                    <strong>Search Result:</strong> Product found!
                </div>
                <table class="product-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Price (₹)</th>
                            <th>Quantity</th>
                            <th>Total Value</th>
                            <th>Stock Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><%= searchResult.getProductId() %></td>
                            <td><%= searchResult.getProductName() %></td>
                            <td><%= searchResult.getCategory() %></td>
                            <td>₹ <%= String.format("%,.2f", searchResult.getPrice()) %></td>
                            <td><%= searchResult.getQuantity() %></td>
                            <td>₹ <%= String.format("%,.2f", searchResult.getTotalValue()) %></td>
                            <td>
                                <span class="badge <%= searchResult.getQuantity() <= 0 ? "badge-danger" : (searchResult.getQuantity() < 10 ? "badge-warning" : "badge-success") %>">
                                    <%= searchResult.getQuantity() <= 0 ? "Out of Stock" : (searchResult.getQuantity() < 10 ? "Low Stock" : "In Stock") %>
                                </span>
                            </td>
                            <td class="action-buttons">
                                <a href="UpdateProductServlet?id=<%= searchResult.getProductId() %>" class="btn btn-warning btn-sm">Edit</a>
                                <a href="DeleteProductServlet?id=<%= searchResult.getProductId() %>" class="btn btn-danger btn-sm" onclick="return confirmDelete('<%= searchResult.getProductId() %>', '<%= searchResult.getProductName() %>')">Delete</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            <% } %>
            
            <!-- All Products Table -->
            <h3 style="margin: 30px 0 15px 0;">All Products</h3>
            <table class="product-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Price (₹)</th>
                        <th>Quantity</th>
                        <th>Total Value</th>
                        <th>Stock Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Product> products = (List<Product>) request.getAttribute("products");
                        if (products != null && !products.isEmpty()) {
                            for (Product p : products) {
                    %>
                        <tr>
                            <td><%= p.getProductId() %></td>
                            <td><%= p.getProductName() %></td>
                            <td><%= p.getCategory() %></td>
                            <td>₹ <%= String.format("%,.2f", p.getPrice()) %></td>
                            <td><%= p.getQuantity() %></td>
                            <td>₹ <%= String.format("%,.2f", p.getTotalValue()) %></td>
                            <td>
                                <span class="badge <%= p.getQuantity() <= 0 ? "badge-danger" : (p.getQuantity() < 10 ? "badge-warning" : "badge-success") %>">
                                    <%= p.getQuantity() <= 0 ? "Out of Stock" : (p.getQuantity() < 10 ? "Low Stock" : "In Stock") %>
                                </span>
                            </td>
                            <td class="action-buttons">
                                <a href="UpdateProductServlet?id=<%= p.getProductId() %>" class="btn btn-warning btn-sm">Edit</a>
                                <a href="DeleteProductServlet?id=<%= p.getProductId() %>" class="btn btn-danger btn-sm" onclick="return confirmDelete('<%= p.getProductId() %>', '<%= p.getProductName() %>')">Delete</a>
                            </td>
                        </tr>
                    <% 
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="8" style="text-align: center;">No products found in inventory</td>
                        </tr>
                    <% } %>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="5"><strong>Total</strong></td>
                        <td><strong>₹ <%= String.format("%,.2f", request.getAttribute("totalInventoryValue") != null ? request.getAttribute("totalInventoryValue") : 0) %></strong></td>
                        <td colspan="2"></td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</body>
</html>