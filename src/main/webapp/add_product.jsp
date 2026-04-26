<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/validation.js"></script>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <div class="header">
                <h1>➕ Add New Product</h1>
                <p>Enter product details below</p>
            </div>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("error") %></div>
            <% } %>
            
            <form action="AddProductServlet" method="post" onsubmit="return validateProductForm()">
                <div class="form-group">
                    <label>Product ID *</label>
                    <input type="number" name="productId" class="form-control" id="productId" 
                           value="<%= request.getAttribute("productId") != null ? request.getAttribute("productId") : "" %>">
                    <span class="error" id="productIdError"><%= request.getAttribute("idError") != null ? request.getAttribute("idError") : "" %></span>
                </div>
                
                <div class="form-group">
                    <label>Product Name *</label>
                    <input type="text" name="productName" class="form-control" id="productName"
                           value="<%= request.getAttribute("productName") != null ? request.getAttribute("productName") : "" %>">
                    <span class="error" id="productNameError"><%= request.getAttribute("nameError") != null ? request.getAttribute("nameError") : "" %></span>
                </div>
                
                <div class="form-group">
                    <label>Category *</label>
                    <select name="category" class="form-control" id="category">
                        <option value="">Select Category</option>
                        <option value="Electronics" <%= request.getAttribute("category") != null && request.getAttribute("category").equals("Electronics") ? "selected" : "" %>>Electronics</option>
                        <option value="Audio" <%= request.getAttribute("category") != null && request.getAttribute("category").equals("Audio") ? "selected" : "" %>>Audio</option>
                        <option value="Footwear" <%= request.getAttribute("category") != null && request.getAttribute("category").equals("Footwear") ? "selected" : "" %>>Footwear</option>
                        <option value="Furniture" <%= request.getAttribute("category") != null && request.getAttribute("category").equals("Furniture") ? "selected" : "" %>>Furniture</option>
                        <option value="Clothing" <%= request.getAttribute("category") != null && request.getAttribute("category").equals("Clothing") ? "selected" : "" %>>Clothing</option>
                    </select>
                    <span class="error" id="categoryError"><%= request.getAttribute("categoryError") != null ? request.getAttribute("categoryError") : "" %></span>
                </div>
                
                <div class="form-group">
                    <label>Price (₹) *</label>
                    <input type="number" step="0.01" name="price" class="form-control" id="price"
                           value="<%= request.getAttribute("price") != null ? request.getAttribute("price") : "" %>">
                    <span class="error" id="priceError"><%= request.getAttribute("priceError") != null ? request.getAttribute("priceError") : "" %></span>
                </div>
                
                <div class="form-group">
                    <label>Quantity *</label>
                    <input type="number" name="quantity" class="form-control" id="quantity"
                           value="<%= request.getAttribute("quantity") != null ? request.getAttribute("quantity") : "" %>">
                    <span class="error" id="quantityError"><%= request.getAttribute("quantityError") != null ? request.getAttribute("quantityError") : "" %></span>
                </div>
                
                <div class="form-buttons">
                    <button type="submit" class="btn btn-primary">Add Product</button>
                    <button type="reset" class="btn btn-secondary">Clear</button>
                    <a href="index.jsp" class="btn btn-secondary">Back to Home</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>