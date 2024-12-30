<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Products by Category</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            padding: 20px;
        }
        .product-item {
            border: 1px solid #ddd;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
        }
        .product-name {
            font-size: 1.2em;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h1>Products in Category</h1>
    <%
        String category = request.getParameter("category");
        if (category != null) {
            Connection con = null;
            CallableStatement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocerydb", "root", "Om##3654");
                
                // Call the stored procedure
                stmt = con.prepareCall("{call GetProductsByCategory(?)}");
                stmt.setString(1, category);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    String productName = rs.getString("product_name");
                    double price = rs.getDouble("price");
                    int stock = rs.getInt("stock");
    %>
                    <div class="product-item">
                        <span class="product-name"><%= productName %></span><br>
                        Price: $<%= price %><br>
                        Stock: <%= stock %><br>
                        <a href="add_to_cart.jsp?product_id=<%= productId %>&quantity=1">Add to Cart</a>
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
            out.println("<h2>No category selected.</h2>");
        }
    %>
</body>
</html>
