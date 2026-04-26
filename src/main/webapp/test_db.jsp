<%@ page import="java.sql.*, com.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head><title>DB Test</title></head>
<body>
    <h1>Database Connection Test</h1>
    <%
        try {
            Connection conn = DBConnection.getConnection();
            if (conn != null) {
                out.println("<p style='color:green'>✓ Database connected successfully!</p>");
                out.println("<p>Connection: " + conn.toString() + "</p>");
                conn.close();
            } else {
                out.println("<p style='color:red'>✗ Connection is NULL! Check your DBConnection class.</p>");
            }
        } catch (Exception e) {
            out.println("<p style='color:red'>✗ Error: " + e.getMessage() + "</p>");
            e.printStackTrace(response.getWriter());
        }
    %>
</body>
</html>