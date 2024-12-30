<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Your Orders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            padding: 20px;
        }
        .order-item {
            border: 1px solid #ddd;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
        }
        .order-date {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h1>Your Orders</h1>
    <%
        Integer userId = (Integer) session.getAttribute("user_id"); // Assuming user_id is stored in the session
        if (userId != null) {
            Connection con = null;
            CallableStatement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocerydb", "root", "Om##3654");
                
                // Call the stored procedure
                stmt = con.prepareCall("{call get_user_orders(?)}");
                stmt.setInt(1, userId);
                rs = stmt.executeQuery(); // Use executeQuery to get the ResultSet directly

                while (rs.next()) {
                    int orderId = rs.getInt("order_id");
                    Date orderDate = rs.getDate("order_date");
                    double totalPrice = rs.getDouble("total_price");
                    String status = rs.getString("status");
    %>
                    <div class="order-item">
                        <span class="order-date">Order ID: <%= orderId %> | Date: <%= orderDate %></span><br>
                        Total Price: $<%= totalPrice %><br>
                        Status: <%= status %>
                    </div>
    <%
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            }
        } else {
            out.println("<h2>Please log in to view your orders.</h2>");
        }
    %>
</body>
</html>
