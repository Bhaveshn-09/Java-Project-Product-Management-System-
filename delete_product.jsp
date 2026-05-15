<!-- delete_product.jsp -->
<!-- src/main/webapp/delete_product.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
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

<title>Delete Product</title>

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

    min-height:100vh;
    background:linear-gradient(135deg,#141e30,#243b55);
    display:flex;
    justify-content:center;
    align-items:center;
    padding:30px;
    overflow-x:hidden;
    color:white;
}

.container{

    width:100%;
    max-width:1200px;
}

.card{

    background:rgba(255,255,255,0.1);
    backdrop-filter:blur(15px);
    border-radius:25px;
    padding:35px;
    box-shadow:0 10px 40px rgba(0,0,0,0.3);
}

h1{

    text-align:center;
    margin-bottom:20px;
}

.btn{

    padding:12px 20px;
    border:none;
    border-radius:12px;
    cursor:pointer;
    text-decoration:none;
    color:white;
    font-weight:600;
    transition:0.3s;
}

.btn-danger{

    background:linear-gradient(45deg,#ff416c,#ff4b2b);
}

.btn-danger:hover{

    transform:translateY(-2px);
}

.btn-home{

    background:#2196f3;
}

.form-control{

    width:100%;
    padding:14px;
    border:none;
    border-radius:12px;
    margin-top:10px;
    margin-bottom:20px;
}

table{

    width:100%;
    border-collapse:collapse;
    margin-top:25px;
}

table th{

    background:rgba(255,255,255,0.15);
    padding:15px;
}

table td{

    padding:15px;
    border-bottom:1px solid rgba(255,255,255,0.1);
}

table tr:hover{

    background:rgba(255,255,255,0.08);
}

.alert{

    padding:15px;
    border-radius:12px;
    margin-bottom:20px;
}

.success{

    background:#00c853;
}

.error{

    background:#ff5252;
}

</style>

</head>

<body>

<div class="container">

<div class="card">

<h1>🗑 Delete Product</h1>

<a href="index.jsp" class="btn btn-home">

⬅ Back To Home

</a>

<br><br>

<%

String success = request.getParameter("success");

if(success != null){

%>

<div class="alert success">

✅ Product Deleted Successfully

</div>

<% } %>

<%

String error = request.getParameter("error");

if(error != null){

%>

<div class="alert error">

❌ Operation Failed

</div>

<% } %>

<form action="DeleteProductServlet" method="get">

<label>Enter Product ID</label>

<input type="number"
name="id"
class="form-control"
required>

<button type="submit"
class="btn btn-danger">

Delete Product

</button>

</form>

<h2 style="margin-top:30px;">

📦 Product Inventory

</h2>

<div style="overflow-x:auto;">

<table>

<tr>

<th>ID</th>
<th>Name</th>
<th>Category</th>
<th>Price</th>
<th>Quantity</th>
<th>Action</th>

</tr>

<%

ProductDAO dao = new ProductDAO();

List<Product> products =
dao.getAllProducts();

if(products != null){

for(Product p : products){

%>

<tr>

<td><%= p.getId() %></td>

<td><%= p.getProductName() %></td>

<td><%= p.getCategory() %></td>

<td>
₹ <%= p.getPrice() %>
</td>

<td><%= p.getQuantity() %></td>

<td>

<a href="DeleteProductServlet?id=<%= p.getId() %>"
class="btn btn-danger"

onclick="return confirm('Delete Product?')">

Delete

</a>

</td>

</tr>

<%

}

}

%>

</table>

</div>

</div>

</div>

</body>

</html>