<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.ProductDAO" %>
<%
    ProductDAO dao = new ProductDAO();
    int nextId = dao.getNextProductId();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product - Inventory Management System</title>
    
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
            background: linear-gradient(135deg, #60a5fa, #c084fc);
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

        /* Auto ID Display */
        .auto-id-box {
            background: linear-gradient(135deg, rgba(59,130,246,0.15), rgba(168,85,247,0.15));
            border-radius: 20px;
            padding: 20px;
            margin-bottom: 30px;
            text-align: center;
            border: 1px solid rgba(59,130,246,0.3);
        }

        .auto-id-label {
            font-size: 14px;
            color: #94a3b8;
            letter-spacing: 1px;
            margin-bottom: 8px;
        }

        .auto-id-value {
            font-size: 48px;
            font-weight: 800;
            background: linear-gradient(135deg, #60a5fa, #c084fc);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .auto-id-note {
            font-size: 12px;
            color: #64748b;
            margin-top: 8px;
        }

        /* Form Body */
        .card-body {
            padding: 40px;
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 28px;
            position: relative;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #e2e8f0;
            margin-bottom: 10px;
            font-size: 14px;
            letter-spacing: 0.5px;
        }

        .form-group label i {
            margin-right: 8px;
            color: #60a5fa;
        }

        .form-group label .required {
            color: #f87171;
            margin-left: 4px;
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            font-size: 15px;
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            background: rgba(255, 255, 255, 0.07);
            color: white;
        }

        .form-control:focus {
            outline: none;
            border-color: #3b82f6;
            background: rgba(255, 255, 255, 0.12);
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.2);
        }

        .form-control::placeholder {
            color: #64748b;
        }

        select.form-control {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2360a5fa' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 16px center;
            background-size: 16px;
        }

        /* Error Messages */
        .error {
            color: #f87171;
            font-size: 12px;
            margin-top: 8px;
            display: block;
        }

        /* Button Styles */
        .form-buttons {
            display: flex;
            gap: 15px;
            margin-top: 35px;
            flex-wrap: wrap;
        }

        .btn {
            flex: 1;
            padding: 14px 24px;
            font-size: 16px;
            font-weight: 600;
            border: none;
            border-radius: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #3b82f6, #2563eb);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(59, 130, 246, 0.4);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .btn-info {
            background: linear-gradient(135deg, #8b5cf6, #7c3aed);
            color: white;
        }

        .btn-info:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(139, 92, 246, 0.4);
        }

        /* Alert Styles */
        .alert {
            padding: 16px 20px;
            border-radius: 16px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideDown 0.4s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-success {
            background: rgba(34, 197, 94, 0.15);
            color: #4ade80;
            border: 1px solid rgba(74, 222, 128, 0.3);
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.15);
            color: #f87171;
            border: 1px solid rgba(248, 113, 113, 0.3);
        }

        .alert i {
            font-size: 20px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .card-body {
                padding: 25px;
            }
            
            .form-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
            
            .auto-id-value {
                font-size: 36px;
            }
        }

        /* Input Number Spinner Hide */
        input[type=number]::-webkit-inner-spin-button,
        input[type=number]::-webkit-outer-spin-button {
            opacity: 0.5;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <i class="fas fa-box-open"></i>
                <h1>Add New Product</h1>
                <p>Fill in the product details below</p>
            </div>
            
            <div class="card-body">
                <!-- Auto-Generated ID Display -->
                <div class="auto-id-box">
                    <div class="auto-id-label">
                        <i class="fas fa-id-card"></i> AUTO-GENERATED PRODUCT ID
                    </div>
                    <div class="auto-id-value">
                        #<%= nextId %>
                    </div>
                    <div class="auto-id-note">
                        <i class="fas fa-info-circle"></i> ID will be automatically assigned by database
                    </div>
                </div>
                
                <!-- Success/Error Messages -->
                <%
                    String message = (String) request.getAttribute("message");
                    String error = (String) request.getAttribute("error");
                    Integer generatedId = (Integer) request.getAttribute("generatedId");
                    
                    if(message != null) {
                %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <strong><%= message %></strong>
                </div>
                <%
                    }
                    if(error != null) {
                %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle"></i>
                    <strong><%= error %></strong>
                </div>
                <%
                    }
                %>
                
                <form action="AddProductServlet" method="post" onsubmit="return validateProductForm()" novalidate>
                    
                    <!-- Product Name -->
                    <div class="form-group">
                        <label>
                            <i class="fas fa-tag"></i>
                            Product Name
                            <span class="required">*</span>
                        </label>
                        <input type="text"
                               name="productName"
                               class="form-control"
                               id="productName"
                               placeholder="Enter product name e.g., iPhone 15 Pro Max"
                               autocomplete="off">
                        <span class="error" id="productNameError"></span>
                    </div>
                    
                    <!-- Category -->
                    <div class="form-group">
                        <label>
                            <i class="fas fa-folder"></i>
                            Category
                            <span class="required">*</span>
                        </label>
                        <select name="category" class="form-control" id="category">
                            <option value="">-- Select Product Category --</option>
                            <option value="Electronics">📱 Electronics</option>
                            <option value="Audio">🎧 Audio</option>
                            <option value="Footwear">👟 Footwear</option>
                            <option value="Furniture">🪑 Furniture</option>
                            <option value="Clothing">👕 Clothing</option>
                            <option value="Books">📚 Books</option>
                            <option value="Sports">⚽ Sports</option>
                            <option value="Beauty">💄 Beauty</option>
                        </select>
                        <span class="error" id="categoryError"></span>
                    </div>
                    
                    <!-- Price -->
                    <div class="form-group">
                        <label>
                            <i class="fas fa-rupee-sign"></i>
                            Price (₹)
                            <span class="required">*</span>
                        </label>
                        <input type="number"
                               step="0.01"
                               name="price"
                               class="form-control"
                               id="price"
                               placeholder="Enter product price"
                               autocomplete="off">
                        <span class="error" id="priceError"></span>
                    </div>
                    
                    <!-- Quantity -->
                    <div class="form-group">
                        <label>
                            <i class="fas fa-boxes"></i>
                            Quantity
                            <span class="required">*</span>
                        </label>
                        <input type="number"
                               name="quantity"
                               class="form-control"
                               id="quantity"
                               placeholder="Enter stock quantity"
                               autocomplete="off">
                        <span class="error" id="quantityError"></span>
                    </div>
                    
                    <!-- Buttons -->
                    <div class="form-buttons">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-plus-circle"></i>
                            Add Product
                        </button>
                        <button type="reset" class="btn btn-secondary" onclick="resetForm()">
                            <i class="fas fa-undo-alt"></i>
                            Reset
                        </button>
                        <a href="index.jsp" class="btn btn-info">
                            <i class="fas fa-home"></i>
                            Home
                        </a>
                    </div>
                    
                </form>
            </div>
        </div>
    </div>
    
    <script>
        function clearErrors() {
            let errors = ['productNameError', 'categoryError', 'priceError', 'quantityError'];
            errors.forEach(function(errorId) {
                let errorElement = document.getElementById(errorId);
                if(errorElement) {
                    errorElement.textContent = '';
                }
            });
        }
        
        function showError(elementId, message) {
            let errorElement = document.getElementById(elementId);
            if(errorElement) {
                errorElement.textContent = message;
            }
        }
        
        function resetForm() {
            document.getElementById('productName').value = '';
            document.getElementById('category').value = '';
            document.getElementById('price').value = '';
            document.getElementById('quantity').value = '';
            clearErrors();
        }
        
        function validateProductForm() {
            let isValid = true;
            
            let productName = document.getElementById('productName').value;
            let category = document.getElementById('category').value;
            let price = document.getElementById('price').value;
            let quantity = document.getElementById('quantity').value;
            
            clearErrors();
            
            if (!productName || productName.trim().length < 2) {
                showError('productNameError', '❌ Product name must contain at least 2 characters');
                isValid = false;
                document.getElementById('productName').style.borderColor = '#ef4444';
            } else if (productName.trim().length > 100) {
                showError('productNameError', '❌ Product name must be less than 100 characters');
                isValid = false;
                document.getElementById('productName').style.borderColor = '#ef4444';
            } else {
                document.getElementById('productName').style.borderColor = '#22c55e';
            }
            
            if (!category) {
                showError('categoryError', '❌ Please select a category');
                isValid = false;
                document.getElementById('category').style.borderColor = '#ef4444';
            } else {
                document.getElementById('category').style.borderColor = '#22c55e';
            }
            
            if (!price || price < 0 || isNaN(price)) {
                showError('priceError', '❌ Enter a valid product price');
                isValid = false;
                document.getElementById('price').style.borderColor = '#ef4444';
            } else if (price > 9999999) {
                showError('priceError', '❌ Price is too high');
                isValid = false;
                document.getElementById('price').style.borderColor = '#ef4444';
            } else {
                document.getElementById('price').style.borderColor = '#22c55e';
            }
            
            if (!quantity || quantity < 0 || isNaN(quantity)) {
                showError('quantityError', '❌ Enter a valid quantity');
                isValid = false;
                document.getElementById('quantity').style.borderColor = '#ef4444';
            } else if (quantity > 100000) {
                showError('quantityError', '❌ Quantity is too high');
                isValid = false;
                document.getElementById('quantity').style.borderColor = '#ef4444';
            } else {
                document.getElementById('quantity').style.borderColor = '#22c55e';
            }
            
            if(isValid) {
                console.log('Form validation passed!');
            }
            
            return isValid;
        }
        
        // Real-time validation
        document.getElementById('productName').addEventListener('input', function() {
            if(this.value.trim().length >= 2) {
                this.style.borderColor = '#22c55e';
                document.getElementById('productNameError').textContent = '✓ Valid product name';
                document.getElementById('productNameError').style.color = '#4ade80';
            } else {
                this.style.borderColor = 'rgba(255, 255, 255, 0.1)';
                document.getElementById('productNameError').textContent = '';
            }
        });
        
        document.getElementById('price').addEventListener('input', function() {
            if(this.value > 0 && !isNaN(this.value)) {
                this.style.borderColor = '#22c55e';
                document.getElementById('priceError').textContent = '✓ ₹' + parseFloat(this.value).toLocaleString('en-IN');
                document.getElementById('priceError').style.color = '#4ade80';
            } else {
                this.style.borderColor = 'rgba(255, 255, 255, 0.1)';
                document.getElementById('priceError').textContent = '';
            }
        });
        
        document.getElementById('quantity').addEventListener('input', function() {
            if(this.value > 0 && !isNaN(this.value)) {
                this.style.borderColor = '#22c55e';
                document.getElementById('quantityError').textContent = '✓ Stock: ' + this.value + ' units';
                document.getElementById('quantityError').style.color = '#4ade80';
            } else {
                this.style.borderColor = 'rgba(255, 255, 255, 0.1)';
                document.getElementById('quantityError').textContent = '';
            }
        });
        
        document.getElementById('category').addEventListener('change', function() {
            if(this.value) {
                this.style.borderColor = '#22c55e';
                document.getElementById('categoryError').textContent = '✓ ' + this.options[this.selectedIndex].text;
                document.getElementById('categoryError').style.color = '#4ade80';
            } else {
                this.style.borderColor = 'rgba(255, 255, 255, 0.1)';
                document.getElementById('categoryError').textContent = '';
            }
        });
    </script>
</body>
</html>