<%@ page import="java.sql.*, com.util.DBConnection" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Database Connection Test</title>

<style>

@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{

    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#0f172a,#1e293b,#334155);
    overflow:hidden;
    position:relative;
    color:white;

}

/* Animated Background */

body::before{

    content:'';
    position:absolute;
    width:450px;
    height:450px;
    background:#2563eb;
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
    bottom:-120px;
    right:-120px;
    filter:blur(120px);
    opacity:0.25;

}

/* Main Card */

.db-card{

    position:relative;
    z-index:10;
    width:90%;
    max-width:650px;
    padding:40px;
    border-radius:30px;
    background:rgba(255,255,255,0.12);
    backdrop-filter:blur(15px);
    border:1px solid rgba(255,255,255,0.1);
    box-shadow:0 10px 40px rgba(0,0,0,0.35);
    text-align:center;
    animation:fadeIn 1s ease;

}

@keyframes fadeIn{

    from{

        opacity:0;
        transform:translateY(30px);

    }

    to{

        opacity:1;
        transform:translateY(0);

    }

}

/* Header */

.db-card h1{

    font-size:38px;
    margin-bottom:15px;
    font-weight:700;

}

.subtitle{

    color:#d1d5db;
    margin-bottom:35px;
    font-size:15px;

}

/* Status Box */

.status-box{

    padding:25px;
    border-radius:20px;
    margin-top:20px;
    text-align:left;
    word-wrap:break-word;

}

.success{

    background:rgba(34,197,94,0.15);
    border:1px solid rgba(74,222,128,0.3);

}

.error{

    background:rgba(239,68,68,0.15);
    border:1px solid rgba(248,113,113,0.3);

}

/* Status Text */

.status-title{

    font-size:24px;
    margin-bottom:12px;
    font-weight:600;

}

.success .status-title{

    color:#4ade80;

}

.error .status-title{

    color:#f87171;

}

.status-message{

    color:#f1f5f9;
    line-height:1.7;
    font-size:15px;

}

/* Connection Details */

.connection-info{

    margin-top:20px;
    padding:18px;
    border-radius:15px;
    background:rgba(255,255,255,0.08);
    border:1px solid rgba(255,255,255,0.08);

}

.connection-info h3{

    margin-bottom:12px;
    color:#93c5fd;

}

.connection-info p{

    color:#e2e8f0;
    line-height:1.6;
    font-size:14px;

}

/* Button */

.btn{

    display:inline-block;
    margin-top:30px;
    padding:14px 22px;
    border-radius:14px;
    text-decoration:none;
    font-weight:600;
    color:white;
    background:linear-gradient(45deg,#2563eb,#3b82f6);
    transition:0.3s ease;

}

.btn:hover{

    transform:translateY(-3px);
    box-shadow:0 10px 20px rgba(59,130,246,0.4);

}

/* Footer */

.footer{

    margin-top:25px;
    color:#cbd5e1;
    font-size:13px;

}

/* Responsive */

@media(max-width:768px){

    .db-card{

        padding:25px;

    }

    .db-card h1{

        font-size:30px;

    }

}

</style>

</head>

<body>

<div class="db-card">

    <h1>🛢 Database Connection Test</h1>

    <p class="subtitle">

        Verify your MySQL database connection status

    </p>

    <%

    try{

        Connection conn = DBConnection.getConnection();

        if(conn != null){

    %>

        <!-- SUCCESS -->

        <div class="status-box success">

            <div class="status-title">

                ✅ Connection Successful

            </div>

            <div class="status-message">

                Your database is connected successfully.
                The Product Management System is now able
                to communicate with MySQL database properly.

            </div>

            <div class="connection-info">

                <h3>🔗 Connection Details</h3>

                <p>

                    <strong>Status:</strong> Active Connection

                </p>

                <p>

                    <strong>Connection Object:</strong><br>

                    <%= conn.toString() %>

                </p>

            </div>

        </div>

    <%

            conn.close();

        } else {

    %>

        <!-- NULL ERROR -->

        <div class="status-box error">

            <div class="status-title">

                ❌ Connection Failed

            </div>

            <div class="status-message">

                Database connection returned NULL.
                Please check your DBConnection.java file,
                MySQL server status and database credentials.

            </div>

        </div>

    <%

        }

    } catch(Exception e){

    %>

        <!-- EXCEPTION -->

        <div class="status-box error">

            <div class="status-title">

                ⚠ Database Error

            </div>

            <div class="status-message">

                <strong>Error Message:</strong><br><br>

                <%= e.getMessage() %>

            </div>

            <div class="connection-info">

                <h3>🛠 Possible Solutions</h3>

                <p>

                    • Check MySQL Server is running<br>
                    • Verify Database Username & Password<br>
                    • Check JDBC Driver<br>
                    • Verify Database URL<br>
                    • Ensure MySQL Connector JAR is added

                </p>

            </div>

        </div>

    <%

        e.printStackTrace(response.getWriter());

    }

    %>

    <!-- Home Button -->

    <a href="index.jsp" class="btn">

        ⬅ Back To Dashboard

    </a>

    <div class="footer">

        Product Management System • Database Monitor Panel

    </div>

</div>

</body>

</html>