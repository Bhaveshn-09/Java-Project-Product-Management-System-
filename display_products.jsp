<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Inventory - Advanced Dashboard</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    
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
            padding: 30px;
            color: #fff;
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
            max-width: 1600px;
            margin: 0 auto;
        }

        /* Header */
        .header {
            text-align: center;
            margin-bottom: 40px;
            animation: slideDown 0.6s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header h1 {
            font-size: 48px;
            font-weight: 800;
            background: linear-gradient(135deg, #60a5fa, #a78bfa, #f472b6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 12px;
        }

        .header p {
            color: #94a3b8;
            font-size: 16px;
            margin-bottom: 20px;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(12px);
            border-radius: 24px;
            padding: 28px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #3b82f6, #a855f7, #ec4899);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.12);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }

        .stat-icon {
            font-size: 40px;
            margin-bottom: 16px;
        }

        .stat-value {
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 8px;
        }

        .stat-label {
            color: #94a3b8;
            font-size: 14px;
            font-weight: 500;
        }

        /* Main Card */
        .main-card {
            background: rgba(255, 255, 255, 0.06);
            backdrop-filter: blur(12px);
            border-radius: 28px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            overflow: hidden;
            animation: fadeInUp 0.6s ease;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card-header {
            padding: 28px 32px;
            background: rgba(255, 255, 255, 0.05);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .card-header h2 {
            font-size: 24px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .search-area {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .search-input {
            padding: 12px 20px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 14px;
            color: white;
            font-size: 14px;
            width: 250px;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #3b82f6;
            background: rgba(255, 255, 255, 0.15);
        }

        .search-input::placeholder {
            color: #94a3b8;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
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
            background: rgba(255, 255, 255, 0.15);
            color: white;
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-2px);
        }

        .btn-warning {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            color: white;
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(245, 158, 11, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(239, 68, 68, 0.4);
        }

        .btn-sm {
            padding: 8px 16px;
            font-size: 12px;
        }

        /* Table Styles */
        .table-wrapper {
            overflow-x: auto;
            padding: 0 32px 32px 32px;
        }

        .product-table {
            width: 100%;
            border-collapse: collapse;
        }

        .product-table thead {
            background: rgba(255, 255, 255, 0.08);
            border-radius: 16px;
        }

        .product-table th {
            padding: 18px 16px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            color: #cbd5e1;
        }

        .product-table td {
            padding: 16px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            color: #e2e8f0;
            font-size: 14px;
        }

        .product-table tbody tr {
            transition: all 0.3s ease;
        }

        .product-table tbody tr:hover {
            background: rgba(255, 255, 255, 0.05);
            transform: scale(1.01);
        }

        /* Badges */
        .badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .badge-success {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
        }

        .badge-warning {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            color: white;
        }

        .badge-danger {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
        }

        .badge-info {
            background: linear-gradient(135deg, #3b82f6, #2563eb);
            color: white;
        }

        /* Action Buttons Group */
        .action-group {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        /* Alert */
        .alert {
            padding: 16px 24px;
            border-radius: 16px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideIn 0.4s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.2);
            border-left: 4px solid #10b981;
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.2);
            border-left: 4px solid #ef4444;
        }

        .alert-info {
            background: rgba(59, 130, 246, 0.2);
            border-left: 4px solid #3b82f6;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px;
        }

        .empty-state i {
            font-size: 80px;
            color: #475569;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-size: 20px;
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #94a3b8;
        }

        /* Footer */
        .table-footer {
            padding: 20px 32px;
            background: rgba(255, 255, 255, 0.05);
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .total-value {
            font-size: 18px;
            font-weight: 700;
        }

        .total-value span {
            color: #fbbf24;
            font-size: 24px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .header h1 {
                font-size: 32px;
            }
            
            .card-header {
                flex-direction: column;
            }
            
            .search-area {
                width: 100%;
            }
            
            .search-input {
                width: 100%;
            }
            
            .action-group {
                flex-direction: column;
            }
            
            .product-table th,
            .product-table td {
                padding: 12px 8px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    
    <!-- Header -->
    <div class="header">
        <h1><i class="fas fa-boxes"></i> Product Inventory</h1>
        <p>View, Search, Edit and Manage Products</p>
        <a href="index.jsp" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Back To Home
        </a>
    </div>
    
    <!-- Statistics Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-box"></i>
            </div>
            <div class="stat-value">
                <%= request.getAttribute("totalProducts") != null ? request.getAttribute("totalProducts") : 0 %>
            </div>
            <div class="stat-label">Total Products</div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-rupee-sign"></i>
            </div>
            <div class="stat-value">
                ₹ <%= String.format("%,.2f", request.getAttribute("totalInventoryValue") != null ? 
                    Double.parseDouble(request.getAttribute("totalInventoryValue").toString()) : 0) %>
            </div>
            <div class="stat-label">Total Inventory Value</div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-tags"></i>
            </div>
            <div class="stat-value">
                <%= request.getAttribute("totalCategories") != null ? request.getAttribute("totalCategories") : 0 %>
            </div>
            <div class="stat-label">Categories</div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-chart-line"></i>
            </div>
            <div class="stat-value">
                <%= request.getAttribute("avgPrice") != null ? 
                    String.format("₹ %,d", (int)Double.parseDouble(request.getAttribute("avgPrice").toString())) : "₹ 0" %>
            </div>
            <div class="stat-label">Average Price</div>
        </div>
    </div>
    
    <!-- Alerts -->
    <% if(request.getAttribute("message") != null) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i>
            <strong>Success!</strong> <%= request.getAttribute("message") %>
        </div>
    <% } %>
    
    <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <i class="fas fa-exclamation-triangle"></i>
            <strong>Error!</strong> <%= request.getAttribute("error") %>
        </div>
    <% } %>
    
    <% if(request.getAttribute("searchResult") != null) { 
        Product searchResult = (Product) request.getAttribute("searchResult");
    %>
        <div class="alert alert-info">
            <i class="fas fa-search"></i>
            <strong>Product Found!</strong> Showing details for ID: <%= searchResult.getId() %>
        </div>
    <% } %>
    
    <!-- Main Card -->
    <div class="main-card">
        <div class="card-header">
            <h2>
                <i class="fas fa-list-ul"></i>
                Product List
            </h2>
            <div class="search-area">
                <form action="DisplayProductsServlet" method="get" style="display: flex; gap: 12px; flex-wrap: wrap;">
                    <input type="number" 
                           name="searchId" 
                           class="search-input" 
                           placeholder="🔍 Enter Product ID To Search"
                           value="<%= request.getParameter("searchId") != null ? request.getParameter("searchId") : "" %>">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search"></i> Search
                    </button>
                    <a href="DisplayProductsServlet" class="btn btn-secondary">
                        <i class="fas fa-sync-alt"></i> Show All
                    </a>
                    <a href="add-product.jsp" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New Product
                    </a>
                </form>
            </div>
        </div>
        
        <div class="table-wrapper">
            <table class="product-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total Value</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Product> products = (List<Product>) request.getAttribute("products");
                        if(products != null && !products.isEmpty()) {
                            for(Product p : products) {
                    %>
                        <tr>
                            <td><strong>#<%= p.getId() %></strong></td>
                            <td><%= p.getProductName() %></td>
                            <td><span class="badge badge-info"><%= p.getCategory() %></span></td>
                            <td>₹ <%= String.format("%,.2f", p.getPrice()) %></td>
                            <td><%= p.getQuantity() %></td>
                            <td>₹ <%= String.format("%,.2f", p.getTotalValue()) %></td>
                            <td>
                                <span class="badge <%= p.getStockBadgeClass() %>">
                                    <i class="fas <%= p.getQuantity() <= 0 ? "fa-times-circle" : (p.getQuantity() < 10 ? "fa-exclamation-triangle" : "fa-check-circle") %>"></i>
                                    <%= p.getStockStatus() %>
                                </span>
                            </td>
                            <td>
                                <div class="action-group">
                                    <a href="UpdateProductServlet?id=<%= p.getId() %>" class="btn btn-warning btn-sm">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <a href="DeleteProductServlet?id=<%= p.getId() %>" 
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirmDelete('<%= p.getId() %>', '<%= p.getProductName() %>')">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </div>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="8">
                                <div class="empty-state">
                                    <i class="fas fa-box-open"></i>
                                    <h3>No Products Found</h3>
                                    <p>Click "Add New Product" to get started</p>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <div class="table-footer">
            <div>
                <i class="fas fa-database"></i> 
                Showing <%= products != null ? products.size() : 0 %> products
            </div>
            <div class="total-value">
                <i class="fas fa-chart-simple"></i>
                Total Inventory Value: 
                <span>₹ <%= String.format("%,.2f", request.getAttribute("totalInventoryValue") != null ? 
                    Double.parseDouble(request.getAttribute("totalInventoryValue").toString()) : 0) %></span>
            </div>
        </div>
    </div>
</div>

<script>
function confirmDelete(productId, productName) {
    return confirm(
        "⚠️ Confirm Deletion\n\n" +
        "Are you sure you want to delete:\n\n" +
        "📦 Product: " + productName + "\n" +
        "🆔 ID: " + productId + "\n\n" +
        "This action cannot be undone!"
    );
}

// Auto-hide alerts after 5 seconds
setTimeout(function() {
    let alerts = document.querySelectorAll('.alert');
    alerts.forEach(function(alert) {
        alert.style.opacity = '0';
        alert.style.transition = 'opacity 0.5s ease';
        setTimeout(function() {
            if(alert.parentNode) alert.remove();
        }, 500);
    });
}, 5000);
</script>
</body>
</html>