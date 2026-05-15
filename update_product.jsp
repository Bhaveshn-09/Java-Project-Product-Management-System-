<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product - Inventory Management System</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
            min-height: 100vh;
            padding: 40px 20px;
            position: relative;
            overflow-x: hidden;
        }

        /* Animated Background */
        body::before {
            content: '';
            position: fixed;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(59,130,246,0.3) 0%, rgba(0,0,0,0) 70%);
            top: -200px;
            left: -200px;
            border-radius: 50%;
            pointer-events: none;
        }

        body::after {
            content: '';
            position: fixed;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(168,85,247,0.3) 0%, rgba(0,0,0,0) 70%);
            bottom: -200px;
            right: -200px;
            border-radius: 50%;
            pointer-events: none;
        }

        .container {
            position: relative;
            z-index: 10;
            max-width: 700px;
            margin: 0 auto;
        }

        /* Card Design */
        .card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(12px);
            border-radius: 32px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            overflow: hidden;
            animation: slideUp 0.5s ease;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Header */
        .card-header {
            background: linear-gradient(135deg, rgba(59,130,246,0.2) 0%, rgba(168,85,247,0.2) 100%);
            padding: 35px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .card-header i {
            font-size: 56px;
            margin-bottom: 15px;
            background: linear-gradient(135deg, #f59e0b, #ef4444);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .card-header h1 {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 8px;
            color: white;
        }

        .card-header p {
            font-size: 14px;
            color: #94a3b8;
        }

        /* Form Body */
        .card-body {
            padding: 40px;
        }

        /* Search Section */
        .search-section {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 30px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .search-section h3 {
            margin-bottom: 20px;
            color: white;
            font-size: 20px;
        }

        .search-box {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .search-input {
            flex: 1;
            padding: 14px 18px;
            font-size: 15px;
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.07);
            color: white;
            font-family: 'Inter', sans-serif;
        }

        .search-input:focus {
            outline: none;
            border-color: #3b82f6;
            background: rgba(255, 255, 255, 0.12);
        }

        .search-input::placeholder {
            color: #64748b;
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #e2e8f0;
            margin-bottom: 10px;
            font-size: 14px;
        }

        .form-group label i {
            margin-right: 8px;
            color: #f59e0b;
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            font-size: 15px;
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.07);
            color: white;
            font-family: 'Inter', sans-serif;
        }

        .form-control:focus {
            outline: none;
            border-color: #f59e0b;
            background: rgba(255, 255, 255, 0.12);
        }

        .form-control[readonly] {
            background: rgba(255, 255, 255, 0.03);
            cursor: not-allowed;
            color: #94a3b8;
        }

        select.form-control {
            cursor: pointer;
        }

        /* Error Messages */
        .error {
            color: #f87171;
            font-size: 12px;
            margin-top: 8px;
            display: block;
        }

        /* Badge */
        .badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-success {
            background: rgba(34, 197, 94, 0.2);
            color: #4ade80;
            border: 1px solid rgba(74, 222, 128, 0.3);
        }

        .badge-warning {
            background: rgba(245, 158, 11, 0.2);
            color: #facc15;
            border: 1px solid rgba(250, 204, 21, 0.3);
        }

        .badge-danger {
            background: rgba(239, 68, 68, 0.2);
            color: #f87171;
            border: 1px solid rgba(248, 113, 113, 0.3);
        }

        /* Button Styles */
        .btn {
            padding: 12px 24px;
            font-size: 14px;
            font-weight: 600;
            border: none;
            border-radius: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(245, 158, 11, 0.4);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .btn-info {
            background: linear-gradient(135deg, #3b82f6, #2563eb);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
        }

        .form-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .form-buttons .btn {
            flex: 1;
            justify-content: center;
        }

        /* Alert Styles */
        .alert {
            padding: 16px 20px;
            border-radius: 16px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .alert-success {
            background: rgba(34, 197, 94, 0.15);
            color: #4ade80;
            border: 1px solid rgba(74, 222, 128, 0.3);
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.15);
            color: #f87171;
            border: 1px solid rgba(248, 113, 113, 0.3);
        }

        .alert-info {
            background: rgba(59, 130, 246, 0.15);
            color: #60a5fa;
            border: 1px solid rgba(96, 165, 250, 0.3);
        }

        hr {
            margin: 25px 0;
            border: none;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        /* Danger Zone */
        .danger-zone {
            margin-top: 30px;
            padding: 20px;
            background: rgba(239, 68, 68, 0.1);
            border-radius: 20px;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .danger-zone h4 {
            color: #f87171;
            margin-bottom: 10px;
        }

        .danger-zone p {
            color: #fca5a5;
            font-size: 14px;
            margin-bottom: 15px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .card-body {
                padding: 25px;
            }
            
            .form-buttons {
                flex-direction: column;
            }
            
            .search-box {
                flex-direction: column;
            }
            
            .search-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <i class="fas fa-edit"></i>
                <h1>Update Product</h1>
                <p>Search by Product ID to update details</p>
            </div>
            
            <div class="card-body">
                <!-- Error Message Display -->
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-triangle"></i>
                        <strong><%= request.getAttribute("error") %></strong>
                    </div>
                <% } %>
                
                <!-- Search Form -->
                <div class="search-section">
                    <h3><i class="fas fa-search"></i> Step 1: Search Product by ID</h3>
                    <form action="UpdateProductServlet" method="get">
                        <div class="search-box">
                            <input type="number" 
                                   name="id" 
                                   class="search-input" 
                                   placeholder="Enter Product ID (e.g., 1, 2, 3...)" 
                                   required>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-search"></i> Search Product
                            </button>
                        </div>
                    </form>
                </div>
                
                <!-- Update Form - Only shows when product is found -->
                <% 
                    Product product = (Product) request.getAttribute("product");
                    if (product != null) {
                %>
                    <hr>
                    
                    <div class="alert alert-info">
                        <i class="fas fa-check-circle"></i>
                        <strong>✓ Product Found!</strong> You can now update the details below.
                    </div>
                    
                    <h3 style="color: white; margin-bottom: 20px;">
                        <i class="fas fa-pen"></i> Step 2: Update Product Details
                    </h3>
                    
                    <form action="UpdateProductServlet" method="post">
                        <!-- Product ID (readonly) -->
                        <div class="form-group">
                            <label><i class="fas fa-id-card"></i> Product ID (Cannot be changed)</label>
                            <input type="number" 
                                   name="productId" 
                                   class="form-control" 
                                   value="<%= product.getId() %>" 
                                   readonly>
                        </div>
                        
                        <!-- Product Name -->
                        <div class="form-group">
                            <label><i class="fas fa-tag"></i> Product Name *</label>
                            <input type="text" 
                                   name="productName" 
                                   class="form-control" 
                                   id="productName"
                                   value="<%= product.getProductName() %>" 
                                   required>
                            <span class="error" id="productNameError"></span>
                        </div>
                        
                        <!-- Category -->
                        <div class="form-group">
                            <label><i class="fas fa-folder"></i> Category *</label>
                            <select name="category" class="form-control" id="category" required>
                                <option value="">Select Category</option>
                                <option value="Electronics" <%= product.getCategory().equals("Electronics") ? "selected" : "" %>>📱 Electronics</option>
                                <option value="Audio" <%= product.getCategory().equals("Audio") ? "selected" : "" %>>🎧 Audio</option>
                                <option value="Footwear" <%= product.getCategory().equals("Footwear") ? "selected" : "" %>>👟 Footwear</option>
                                <option value="Furniture" <%= product.getCategory().equals("Furniture") ? "selected" : "" %>>🪑 Furniture</option>
                                <option value="Clothing" <%= product.getCategory().equals("Clothing") ? "selected" : "" %>>👕 Clothing</option>
                                <option value="Books" <%= product.getCategory().equals("Books") ? "selected" : "" %>>📚 Books</option>
                                <option value="Sports" <%= product.getCategory().equals("Sports") ? "selected" : "" %>>⚽ Sports</option>
                                <option value="Beauty" <%= product.getCategory().equals("Beauty") ? "selected" : "" %>>💄 Beauty</option>
                            </select>
                            <span class="error" id="categoryError"></span>
                        </div>
                        
                        <!-- Price -->
                        <div class="form-group">
                            <label><i class="fas fa-rupee-sign"></i> Price (₹) *</label>
                            <input type="number" 
                                   step="0.01" 
                                   name="price" 
                                   class="form-control" 
                                   id="price"
                                   value="<%= product.getPrice() %>" 
                                   required>
                            <span class="error" id="priceError"></span>
                        </div>
                        
                        <!-- Quantity -->
                        <div class="form-group">
                            <label><i class="fas fa-boxes"></i> Quantity *</label>
                            <input type="number" 
                                   name="quantity" 
                                   class="form-control" 
                                   id="quantity"
                                   value="<%= product.getQuantity() %>" 
                                   required>
                            <span class="error" id="quantityError"></span>
                        </div>
                        
                        <!-- Current Stock Status -->
                        <div class="form-group">
                            <label><i class="fas fa-chart-line"></i> Current Stock Status</label>
                            <div>
                                <span class="badge <%= product.getStockBadgeClass() %>">
                                    <i class="fas <%= product.getQuantity() <= 0 ? "fa-times-circle" : (product.getQuantity() < 10 ? "fa-exclamation-triangle" : "fa-check-circle") %>"></i>
                                    <%= product.getStockStatus() %>
                                </span>
                            </div>
                        </div>
                        
                        <!-- Total Value -->
                        <div class="form-group">
                            <label><i class="fas fa-calculator"></i> Total Value</label>
                            <input type="text" 
                                   class="form-control" 
                                   value="₹ <%= String.format("%,.2f", product.getTotalValue()) %>" 
                                   readonly>
                        </div>
                        
                        <!-- Form Buttons -->
                        <div class="form-buttons">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Update Product
                            </button>
                            <button type="reset" class="btn btn-secondary">
                                <i class="fas fa-undo"></i> Reset
                            </button>
                            <a href="DisplayProductsServlet" class="btn btn-info">
                                <i class="fas fa-eye"></i> View All Products
                            </a>
                        </div>
                    </form>
                    
                    <!-- Danger Zone -->
                    <div class="danger-zone">
                        <h4><i class="fas fa-exclamation-triangle"></i> Danger Zone</h4>
                        <p>If you want to delete this product instead, click the button below.</p>
                        <a href="DeleteProductServlet?id=<%= product.getId() %>" 
                           class="btn btn-danger"
                           onclick="return confirm('Are you sure you want to delete product: <%= product.getProductName() %>? This action cannot be undone!')">
                            <i class="fas fa-trash"></i> Delete Product
                        </a>
                    </div>
                    
                <% } else if (request.getParameter("id") != null) { %>
                    <div class="alert alert-error">
                        <i class="fas fa-search"></i>
                        <strong>No product found with ID: <%= request.getParameter("id") %></strong>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
    
    <script>
        // Form validation
        function validateUpdateForm() {
            let isValid = true;
            
            let productName = document.getElementById('productName')?.value;
            let category = document.getElementById('category')?.value;
            let price = document.getElementById('price')?.value;
            let quantity = document.getElementById('quantity')?.value;
            
            // Clear previous errors
            document.getElementById('productNameError').innerHTML = '';
            document.getElementById('categoryError').innerHTML = '';
            document.getElementById('priceError').innerHTML = '';
            document.getElementById('quantityError').innerHTML = '';
            
            if (!productName || productName.trim().length < 2) {
                document.getElementById('productNameError').innerHTML = 'Product name must be at least 2 characters';
                isValid = false;
            }
            
            if (!category) {
                document.getElementById('categoryError').innerHTML = 'Please select a category';
                isValid = false;
            }
            
            if (!price || price < 0 || isNaN(price)) {
                document.getElementById('priceError').innerHTML = 'Please enter a valid price';
                isValid = false;
            }
            
            if (!quantity || quantity < 0 || isNaN(quantity)) {
                document.getElementById('quantityError').innerHTML = 'Please enter a valid quantity';
                isValid = false;
            }
            
            if (isValid) {
                return confirm('Are you sure you want to update this product?');
            }
            return false;
        }
        
        // Attach validation to form if it exists
        const updateForm = document.querySelector('form[action="UpdateProductServlet"]');
        if (updateForm && updateForm.method === 'post') {
            updateForm.onsubmit = validateUpdateForm;
        }
    </script>
</body>
</html>