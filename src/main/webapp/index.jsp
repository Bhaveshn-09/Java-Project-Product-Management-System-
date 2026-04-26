<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📦 Product Management System</h1>
            <p>Manage your product inventory efficiently</p>
        </div>
        
        <div class="dashboard">
            <a href="add_product.jsp" class="card">
                <div class="card-icon">➕</div>
                <h3>Add Product</h3>
                <p>Add new products to inventory</p>
            </a>
            
            <a href="update_product.jsp" class="card">
                <div class="card-icon">✏️</div>
                <h3>Update Product</h3>
                <p>Update existing product details</p>
            </a>
            
            <a href="DeleteProductServlet" class="card">
                <div class="card-icon">🗑️</div>
                <h3>Delete Product</h3>
                <p>Remove products from inventory</p>
            </a>
            
            <a href="DisplayProductsServlet" class="card">
                <div class="card-icon">👁️</div>
                <h3>Display Products</h3>
                <p>View all products in inventory</p>
            </a>
            
            <a href="reports.jsp" class="card">
                <div class="card-icon">📊</div>
                <h3>Reports</h3>
                <p>Generate inventory reports</p>
            </a>
        </div>
    </div>
</body>
</html>