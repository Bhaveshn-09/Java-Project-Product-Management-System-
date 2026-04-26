<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - Product Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 Inventory Reports</h1>
            <p>Generate and view product reports</p>
            <a href="index.jsp" class="btn btn-secondary" style="margin-top: 15px;">← Back to Home</a>
        </div>
        
        <!-- Report Type Selection -->
        <div class="report-forms">
            <!-- Report 1: Products with price above specified amount -->
            <div class="form-container" style="margin-bottom: 30px;">
                <h3>📈 Report 1: Products above price threshold</h3>
                <form action="ReportServlet" method="get">
                    <input type="hidden" name="type" value="priceAbove">
                    <div class="form-group">
                        <label>Minimum Price (₹)</label>
                        <input type="number" step="0.01" name="data" class="form-control" placeholder="Enter minimum price" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Generate Report</button>
                </form>
            </div>
            
            <!-- Report 2: Products in specific category -->
            <div class="form-container" style="margin-bottom: 30px;">
                <h3>🏷️ Report 2: Products by Category</h3>
                <form action="ReportServlet" method="get">
                    <input type="hidden" name="type" value="category">
                    <div class="form-group">
                        <label>Select Category</label>
                        <select name="data" class="form-control" required>
                            <option value="">-- Select Category --</option>
                            <%
                                List<String> categories = (List<String>) request.getAttribute("categories");
                                if (categories != null) {
                                    for (String cat : categories) {
                            %>
                                <option value="<%= cat %>"><%= cat %></option>
                            <%
                                    }
                                } else {
                                    // Fallback categories
                            %>
                                <option value="Electronics">Electronics</option>
                                <option value="Audio">Audio</option>
                                <option value="Footwear">Footwear</option>
                                <option value="Furniture">Furniture</option>
                                <option value="Clothing">Clothing</option>
                            <% } %>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Generate Report</button>
                </form>
            </div>
            
            <!-- Report 3: Top N products by quantity -->
            <div class="form-container" style="margin-bottom: 30px;">
                <h3>🏆 Report 3: Top N Products by Quantity</h3>
                <form action="ReportServlet" method="get">
                    <input type="hidden" name="type" value="topN">
                    <div class="form-group">
                        <label>Number of products (N)</label>
                        <input type="number" name="data" class="form-control" placeholder="Enter N (e.g., 5)" min="1" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Generate Report</button>
                </form>
            </div>
        </div>
        
        <!-- Report Results -->
        <% if (request.getAttribute("reportResult") != null) { 
            List<Product> reportResult = (List<Product>) request.getAttribute("reportResult");
            String reportTitle = (String) request.getAttribute("reportTitle");
            String reportType = (String) request.getAttribute("reportType");
            Object criteria = request.getAttribute("criteria");
            int resultCount = request.getAttribute("resultCount") != null ? (Integer) request.getAttribute("resultCount") : 0;
        %>
            <div class="report-summary">
                <h2><%= reportTitle %></h2>
                <p>Found <%= resultCount %> product(s) matching the criteria</p>
            </div>
            
            <div class="table-container">
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
                        </tr>
                    </thead>
                    <tbody>
                        <% if (reportResult != null && !reportResult.isEmpty()) {
                            for (Product p : reportResult) {
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
                            </tr>
                        <%      }
                            } else { %>
                            <tr>
                                <td colspan="7" style="text-align: center;">No products found matching the criteria</td>
                            </tr>
                        <% } %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="5"><strong>Total Value</strong></td>
                            <td colspan="2">
                                <strong>₹ 
                                <% 
                                    double total = 0;
                                    if (reportResult != null) {
                                        for (Product p : reportResult) {
                                            total += p.getTotalValue();
                                        }
                                    }
                                    out.print(String.format("%,.2f", total));
                                %>
                                </strong>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        <% } %>
        
        <!-- No results message -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <!-- Quick Stats Section -->
        <div class="stats-container" style="margin-top: 30px;">
            <div class="stat-card">
                <h3>📦 Total Products</h3>
                <% 
                    com.dao.ProductDAO dao = new com.dao.ProductDAO();
                    int totalProducts = dao.getProductCount();
                %>
                <p><%= totalProducts %></p>
            </div>
            <div class="stat-card">
                <h3>💰 Total Inventory Value</h3>
                <p>₹ <%= String.format("%,.2f", dao.getTotalInventoryValue()) %></p>
            </div>
            <div class="stat-card">
                <h3>🏷️ Categories</h3>
                <p><%= dao.getAllCategories().size() %></p>
            </div>
        </div>
    </div>
</body>
</html>