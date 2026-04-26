<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product - Product Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/validation.js"></script>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <div class="header">
                <h1>✏️ Update Product</h1>
                <p>Search by Product ID to update details</p>
                <a href="index.jsp" class="btn btn-secondary" style="margin-top: 15px;">← Back to Home</a>
            </div>
            
            <!-- Error Message Display -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <!-- Success Message Display -->
            <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success">
                    Product updated successfully!
                </div>
            <% } %>
            
            <!-- Search Form -->
            <div class="search-section">
                <h3>🔍 Step 1: Search Product by ID</h3>
                <form action="UpdateProductServlet" method="get" style="display: flex; gap: 10px; align-items: flex-end;">
                    <div class="form-group" style="flex: 1;">
                        <label>Enter Product ID</label>
                        <input type="number" name="id" class="form-control" id="searchId" 
                               placeholder="e.g., 101" required>
                    </div>
                    <button type="submit" class="btn btn-primary" onclick="return validateSearchForm()">Search Product</button>
                </form>
            </div>
            
            <!-- Update Form - Only shows when product is found -->
            <% 
                Product product = (Product) request.getAttribute("product");
                if (product != null) {
            %>
                <hr style="margin: 30px 0;">
                
                <div class="alert alert-info">
                    <strong>✓ Product Found!</strong> You can now update the details below.
                </div>
                
                <h3>📝 Step 2: Update Product Details</h3>
                <form action="UpdateProductServlet" method="post" onsubmit="return validateUpdateForm()">
                    <!-- Product ID (readonly) -->
                    <div class="form-group">
                        <label>Product ID (Cannot be changed)</label>
                        <input type="number" name="productId" class="form-control" 
                               value="<%= product.getProductId() %>" readonly 
                               style="background-color: #f5f5f5; cursor: not-allowed;">
                        <small>Product ID is permanent and cannot be modified</small>
                    </div>
                    
                    <!-- Product Name -->
                    <div class="form-group">
                        <label>Product Name *</label>
                        <input type="text" name="productName" class="form-control" id="productName" 
                               value="<%= product.getProductName() %>" required>
                        <span class="error" id="productNameError"></span>
                        <small>Enter product name (min 2 characters, letters and numbers only)</small>
                    </div>
                    
                    <!-- Category -->
                    <div class="form-group">
                        <label>Category *</label>
                        <select name="category" class="form-control" id="category" required>
                            <option value="">Select Category</option>
                            <option value="Electronics" <%= product.getCategory().equals("Electronics") ? "selected" : "" %>>Electronics</option>
                            <option value="Audio" <%= product.getCategory().equals("Audio") ? "selected" : "" %>>Audio</option>
                            <option value="Footwear" <%= product.getCategory().equals("Footwear") ? "selected" : "" %>>Footwear</option>
                            <option value="Furniture" <%= product.getCategory().equals("Furniture") ? "selected" : "" %>>Furniture</option>
                            <option value="Clothing" <%= product.getCategory().equals("Clothing") ? "selected" : "" %>>Clothing</option>
                            <option value="Accessories" <%= product.getCategory().equals("Accessories") ? "selected" : "" %>>Accessories</option>
                            <option value="Books" <%= product.getCategory().equals("Books") ? "selected" : "" %>>Books</option>
                        </select>
                        <span class="error" id="categoryError"></span>
                        <small>Select the product category</small>
                    </div>
                    
                    <!-- Price -->
                    <div class="form-group">
                        <label>Price (₹) *</label>
                        <input type="number" step="0.01" name="price" class="form-control" id="price" 
                               value="<%= product.getPrice() %>" required>
                        <span class="error" id="priceError"></span>
                        <small>Enter price in Indian Rupees (₹)</small>
                    </div>
                    
                    <!-- Quantity -->
                    <div class="form-group">
                        <label>Quantity *</label>
                        <input type="number" name="quantity" class="form-control" id="quantity" 
                               value="<%= product.getQuantity() %>" required>
                        <span class="error" id="quantityError"></span>
                        <small>Enter quantity in stock (non-negative integer)</small>
                    </div>
                    
                    <!-- Current Stock Status Display -->
                    <div class="form-group">
                        <label>Current Stock Status</label>
                        <div>
                            <span class="badge <%= product.getQuantity() <= 0 ? "badge-danger" : (product.getQuantity() < 10 ? "badge-warning" : "badge-success") %>">
                                <%= product.getQuantity() <= 0 ? "Out of Stock" : (product.getQuantity() < 10 ? "Low Stock" : "In Stock") %>
                            </span>
                        </div>
                        <small>This will update automatically based on new quantity</small>
                    </div>
                    
                    <!-- Additional Info -->
                    <div class="form-group">
                        <label>Total Value</label>
                        <input type="text" class="form-control" 
                               value="₹ <%= String.format("%,.2f", product.getTotalValue()) %>" 
                               readonly style="background-color: #f5f5f5; font-weight: bold;">
                        <small>Automatically calculated (Price × Quantity)</small>
                    </div>
                    
                    <!-- Form Buttons -->
                    <div class="form-buttons">
                        <button type="submit" class="btn btn-primary">💾 Update Product</button>
                        <button type="reset" class="btn btn-secondary">🔄 Reset Form</button>
                        <a href="DisplayProductsServlet" class="btn btn-info">👁️ View All Products</a>
                    </div>
                </form>
                
                <!-- Danger Zone -->
                <div class="danger-zone">
                    <h4>⚠️ Danger Zone</h4>
                    <p>If you want to delete this product instead:</p>
                    <a href="DeleteProductServlet?id=<%= product.getProductId() %>" 
                       class="btn btn-danger" 
                       onclick="return confirmDelete('<%= product.getProductId() %>', '<%= product.getProductName() %>')">
                        🗑️ Delete Product
                    </a>
                </div>
                
            <% } else if (request.getParameter("id") != null) { %>
                <!-- Product not found message -->
                <div class="alert alert-error">
                    <strong>❌ Product Not Found!</strong> No product exists with ID: <%= request.getParameter("id") %>
                </div>
            <% } %>
            
            <!-- Quick Tips -->
            <div class="tips-section">
                <h4>💡 Quick Tips:</h4>
                <ul>
                    <li>Product ID cannot be changed once created</li>
                    <li>Price and quantity fields accept only positive numbers</li>
                    <li>Stock status updates automatically based on quantity</li>
                    <li>Total value is calculated as Price × Quantity</li>
                </ul>
            </div>
        </div>
    </div>
    
    <script>
        // Override validation for update form
        function validateUpdateForm() {
            let isValid = true;
            
            // Clear previous errors
            document.getElementById('productNameError').innerHTML = '';
            document.getElementById('categoryError').innerHTML = '';
            document.getElementById('priceError').innerHTML = '';
            document.getElementById('quantityError').innerHTML = '';
            
            // Validate Product Name
            let productName = document.getElementById('productName').value;
            if (!productName || productName.trim().length < 2) {
                document.getElementById('productNameError').innerHTML = 'Product name must be at least 2 characters';
                document.getElementById('productNameError').style.color = '#e74c3c';
                isValid = false;
            } else if (!/^[A-Za-z0-9\s]+$/.test(productName)) {
                document.getElementById('productNameError').innerHTML = 'Product name can only contain letters, numbers and spaces';
                document.getElementById('productNameError').style.color = '#e74c3c';
                isValid = false;
            }
            
            // Validate Category
            let category = document.getElementById('category').value;
            if (!category) {
                document.getElementById('categoryError').innerHTML = 'Please select a category';
                document.getElementById('categoryError').style.color = '#e74c3c';
                isValid = false;
            }
            
            // Validate Price
            let price = document.getElementById('price').value;
            if (!price || price < 0) {
                document.getElementById('priceError').innerHTML = 'Please enter a valid price (>= 0)';
                document.getElementById('priceError').style.color = '#e74c3c';
                isValid = false;
            } else if (isNaN(price)) {
                document.getElementById('priceError').innerHTML = 'Price must be a number';
                document.getElementById('priceError').style.color = '#e74c3c';
                isValid = false;
            }
            
            // Validate Quantity
            let quantity = document.getElementById('quantity').value;
            if (quantity === '' || quantity < 0) {
                document.getElementById('quantityError').innerHTML = 'Please enter a valid quantity (>= 0)';
                document.getElementById('quantityError').style.color = '#e74c3c';
                isValid = false;
            } else if (isNaN(quantity)) {
                document.getElementById('quantityError').innerHTML = 'Quantity must be a number';
                document.getElementById('quantityError').style.color = '#e74c3c';
                isValid = false;
            }
            
            if (isValid) {
                return confirm('Are you sure you want to update this product?');
            }
            return false;
        }
        
        function validateSearchForm() {
            let searchId = document.getElementById('searchId').value;
            if (!searchId || searchId <= 0) {
                alert('Please enter a valid Product ID to search');
                return false;
            }
            return true;
        }
        
        function confirmDelete(productId, productName) {
            return confirm('⚠️ WARNING: Are you sure you want to delete product: ' + productName + ' (ID: ' + productId + ')?\n\nThis action cannot be undone!');
        }
    </script>
</body>
</html>