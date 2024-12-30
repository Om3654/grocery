<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Product Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #2c3e50, #4ca1af);
            text-align: center;
            color: #fff;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        h1 {
            margin-top: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        ul {
            list-style-type: none;
            padding: 0;
            width: 80%;
            max-width: 600px;
            margin: auto;
        }
        .product-item {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 20px;
            margin: 10px 0;
            backdrop-filter: blur(15px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s;
        }
        .product-item:hover {
            transform: scale(1.05);
        }
        a {
            color: #4ca1af;
            text-decoration: none;
            font-weight: bold;
        }
        .btn {
            margin-top: 20px;
            padding: 10px 20px;
            background: rgba(255, 255, 255, 0.2);
            border: none;
            border-radius: 5px;
            color: #fff;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.3s;
        }
        .btn:hover {
            background: rgba(255, 255, 255, 0.4);
        }
        /* Dark Theme */
        .dark-theme {
            background: linear-gradient(to right, #1a1a1a, #333);
            color: #fff;
        }
        .dark-theme .product-item {
            background: rgba(255, 255, 255, 0.1);
        }
        .dark-theme a {
            color: #4ca1af;
        }
    </style>
</head>
<body class="dark-theme">
    <h1>Product Details</h1>
    <ul>
        <%
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocerydb", "root", "Om##3654");
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT * FROM Products WHERE category_id=" + categoryId);
                while (rs.next()) {
        %>
            <li class="product-item">
                <strong><%= rs.getString("product_name") %></strong><br/>
                Price: <%= rs.getDouble("price") %><br/>
                Stock: <%= rs.getInt("stock") %><br/>
                Description: <%= rs.getString("description") %><br/>
                <a href="cartPage.jsp?productId=<%=rs.getInt("product_id")%>&action=add">Add to Cart</a>
            </li>
        <%
                }
            } catch(Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(con != null) con.close();
            }
        %>
    </ul>
    <a href="categories.jsp" class="btn">Back to Categories</a>
</body>
</html>
