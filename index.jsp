<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Product Management System</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{

    min-height:100vh;
    background:linear-gradient(135deg,#0f172a,#1e293b,#334155);
    overflow-x:hidden;
    color:white;
    position:relative;

}

/* Animated Background */

body::before{

    content:'';
    position:absolute;
    width:450px;
    height:450px;
    background:#00c6ff;
    border-radius:50%;
    top:-120px;
    left:-120px;
    filter:blur(120px);
    opacity:0.25;

}

body::after{

    content:'';
    position:absolute;
    width:400px;
    height:400px;
    background:#7c3aed;
    border-radius:50%;
    bottom:-100px;
    right:-100px;
    filter:blur(120px);
    opacity:0.25;

}

.container{

    position:relative;
    z-index:10;
    width:100%;
    max-width:1400px;
    margin:auto;
    padding:40px 25px;

}

/* Header */

.header{

    text-align:center;
    margin-bottom:50px;
    animation:fadeDown 1s ease;

}

.header h1{

    font-size:52px;
    font-weight:700;
    margin-bottom:15px;
    letter-spacing:1px;

}

.header p{

    font-size:18px;
    color:#cbd5e1;

}

@keyframes fadeDown{

    from{

        opacity:0;
        transform:translateY(-30px);

    }

    to{

        opacity:1;
        transform:translateY(0);

    }

}

/* Dashboard */

.dashboard{

    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
    gap:30px;

}

/* Cards */

.card{

    position:relative;
    background:rgba(255,255,255,0.12);
    backdrop-filter:blur(15px);
    border:1px solid rgba(255,255,255,0.15);
    border-radius:28px;
    padding:35px 25px;
    text-decoration:none;
    color:white;
    overflow:hidden;
    transition:0.4s ease;
    box-shadow:0 10px 30px rgba(0,0,0,0.25);

}

/* Glow Effect */

.card::before{

    content:'';
    position:absolute;
    width:120px;
    height:120px;
    background:rgba(255,255,255,0.15);
    border-radius:50%;
    top:-40px;
    right:-40px;

}

/* Hover */

.card:hover{

    transform:translateY(-10px) scale(1.03);
    box-shadow:0 20px 40px rgba(0,0,0,0.35);

}

/* Card Icon */

.card-icon{

    width:80px;
    height:80px;
    border-radius:20px;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:38px;
    margin-bottom:25px;
    background:rgba(255,255,255,0.18);
    box-shadow:0 5px 20px rgba(255,255,255,0.08);

}

/* Card Content */

.card h3{

    font-size:24px;
    margin-bottom:12px;
    font-weight:600;

}

.card p{

    color:#d1d5db;
    line-height:1.6;
    font-size:15px;

}

/* Individual Card Colors */

.card:nth-child(1) .card-icon{

    background:linear-gradient(45deg,#22c55e,#16a34a);

}

.card:nth-child(2) .card-icon{

    background:linear-gradient(45deg,#f59e0b,#fbbf24);

}

.card:nth-child(3) .card-icon{

    background:linear-gradient(45deg,#ef4444,#f87171);

}

.card:nth-child(4) .card-icon{

    background:linear-gradient(45deg,#3b82f6,#2563eb);

}

.card:nth-child(5) .card-icon{

    background:linear-gradient(45deg,#8b5cf6,#7c3aed);

}

/* Footer */

.footer{

    text-align:center;
    margin-top:60px;
    color:#cbd5e1;
    font-size:14px;

}

/* Responsive */

@media(max-width:768px){

    .header h1{

        font-size:38px;

    }

    .header p{

        font-size:15px;

    }

    .dashboard{

        gap:20px;

    }

    .card{

        padding:28px 20px;

    }

}

</style>

</head>

<body>

<div class="container">

    <!-- Header -->

    <div class="header">

        <h1>📦 Product Management System</h1>

        <p>

            Smart Inventory Management Dashboard

        </p>

    </div>

    <!-- Dashboard Cards -->

    <div class="dashboard">

        <!-- Add Product -->

        <a href="add_product.jsp" class="card">

            <div class="card-icon">

                ➕

            </div>

            <h3>Add Product</h3>

            <p>

                Add new products into your inventory database
                with automatic product ID generation.

            </p>

        </a>

        <!-- Update Product -->

        <a href="update_product.jsp" class="card">

            <div class="card-icon">

                ✏️

            </div>

            <h3>Update Product</h3>

            <p>

                Modify product details, pricing,
                stock quantity and category information.

            </p>

        </a>

        <!-- Delete Product -->

        <a href="DeleteProductServlet" class="card">

            <div class="card-icon">

                🗑️

            </div>

            <h3>Delete Product</h3>

            <p>

                Remove unavailable or unwanted products
                permanently from inventory.

            </p>

        </a>

        <!-- Display Products -->

        <a href="DisplayProductsServlet" class="card">

            <div class="card-icon">

                👁️

            </div>

            <h3>Display Products</h3>

            <p>

                View complete inventory records,
                stock status and product details.

            </p>

        </a>

        <!-- Reports -->

        <a href="reports.jsp" class="card">

            <div class="card-icon">

                📊

            </div>

            <h3>Reports</h3>

            <p>

                Generate inventory reports,
                sales analysis and stock summaries.

            </p>

        </a>

    </div>

    <!-- Footer -->

    <div class="footer">

        © 2026 Product Management System |
        Designed With Modern Glass UI ✨

    </div>

</div>

</body>

</html>