<!-- reports.jsp -->
<!-- src/main/webapp/reports.jsp -->

<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.model.Product" %>
<%@ page import="com.dao.ProductDAO" %>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Inventory Reports</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{

    background:linear-gradient(135deg,#0f172a,#1e293b);
    min-height:100vh;
    color:white;
    padding:30px;
}

.container{

    max-width:1400px;
    margin:auto;
}

.card{

    background:rgba(255,255,255,0.1);
    backdrop-filter:blur(15px);
    border-radius:25px;
    padding:30px;
    margin-bottom:25px;
}

h1{

    text-align:center;
    margin-bottom:20px;
}

.btn{

    padding:12px 18px;
    border:none;
    border-radius:12px;
    cursor:pointer;
    background:#2563eb;
    color:white;
    font-weight:600;
}

.form-control{

    width:100%;
    padding:14px;
    border:none;
    border-radius:12px;
    margin-top:10px;
    margin-bottom:15px;
}

table{

    width:100%;
    border-collapse:collapse;
    margin-top:20px;
}

table th{

    background:rgba(255,255,255,0.15);
    padding:15px;
}

table td{

    padding:15px;
    border-bottom:1px solid rgba(255,255,255,0.1);
}

.stat{

    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:20px;
}

.stat-card{

    background:rgba(255,255,255,0.1);
    padding:25px;
    border-radius:20px;
    text-align:center;
}

</style>

</head>

<body>

<div class="container">

<h1>📊 Inventory Reports</h1>

<div class="card">

<form action="ReportServlet" method="get">

<input type="hidden"
name="type"
value="priceAbove">

<label>Minimum Price</label>

<input type="number"
step="0.01"
name="data"
class="form-control"
required>

<button type="submit"
class="btn">

Generate Report

</button>

</form>

</div>

<div class="card">

<h2>📦 Products</h2>

<div style="overflow-x:auto;">

<table>

<tr>

<th>ID</th>
<th>Name</th>
<th>Category</th>
<th>Price</th>
<th>Quantity</th>
<th>Total Value</th>

</tr>

<%

List<Product> reportResult =
(List<Product>)request.getAttribute("reportResult");

if(reportResult != null){

for(Product p : reportResult){

%>

<tr>

<td><%= p.getId() %></td>

<td><%= p.getProductName() %></td>

<td><%= p.getCategory() %></td>

<td>

₹ <%= p.getPrice() %>

</td>

<td>

<%= p.getQuantity() %>

</td>

<td>

₹ <%= p.getTotalValue() %>

</td>

</tr>

<%

}

}

%>

</table>

</div>

</div>

<div class="stat">

<%

ProductDAO dao =
new ProductDAO();

%>

<div class="stat-card">

<h3>Total Products</h3>

<h2>

<%= dao.getProductCount() %>

</h2>

</div>

<div class="stat-card">

<h3>Total Inventory Value</h3>

<h2>

₹ <%= dao.getTotalInventoryValue() %>

</h2>

</div>

<div class="stat-card">

<h3>Total Categories</h3>

<h2>

<%= dao.getAllCategories().size() %>

</h2>

</div>

</div>

</div>

</body>

</html>