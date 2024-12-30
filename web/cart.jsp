<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('images/cart.jpg'); /* Replace with your image path */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            color: #fff;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .cart-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
            width: 80%;
            max-width: 600px;
        }
        .cart-item {
            margin: 10px 0;
            padding: 10px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.3);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .btn {
            background-color: rgba(39, 174, 96, 0.8);
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            font-size: 16px;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin-top: 10px;
            display: inline-block;
        }
        .btn:hover {
            background-color: rgba(46, 204, 113, 1);
        }
        .remove-btn {
            background-color: rgba(231, 76, 60, 0.8);
            padding: 5px 10px;
            border: none;
            color: white;
            cursor: pointer;
        }
        .remove-btn:hover {
            background-color: rgba(231, 76, 60, 1);
        }
        .quantity-input {
            width: 50px;
            text-align: center;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="cart-container">
        <h1>Your Cart</h1>
        <ul>
            <%
                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;
                double total = 0;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocerydb", "root", "Om##3654");
                    stmt = con.createStatement();
                    
                    // Check for product addition
                    String productIdParam = request.getParameter("product_id");
                    String action = request.getParameter("action");

                    if (productIdParam != null && action != null && action.equals("add")) {
                        int productId = Integer.parseInt(productIdParam);
                        ResultSet productCheck = stmt.executeQuery("SELECT * FROM products WHERE product_id = " + productId);
                        if (productCheck.next()) {
                            stmt.executeUpdate("INSERT INTO cart (product_id, quantity) VALUES (" + productId + ", 1) ");
                        } else {
                            out.println("<div style='color: red;'>Product does not exist.</div>");
                        }
                    }

                    // Check for item removal
                    String removeIdParam = request.getParameter("remove_id");
                    if (removeIdParam != null) {
                        int removeId = Integer.parseInt(removeIdParam);
                        stmt.executeUpdate("DELETE FROM cart WHERE product_id = " + removeId);
                    }

                    // Check for quantity update
                    String updateIdParam = request.getParameter("update_id");
                    String quantityParam = request.getParameter("quantity");
                    if (updateIdParam != null && quantityParam != null) {
                        int updateId = Integer.parseInt(updateIdParam);
                        int quantity = Integer.parseInt(quantityParam);
                        stmt.executeUpdate("UPDATE cart SET quantity = " + quantity + " WHERE product_id = " + updateId);
                    }

                    // Display cart items
                    rs = stmt.executeQuery("SELECT c.product_id, p.product_name, c.quantity, p.price FROM cart c JOIN products p ON c.product_id = p.product_id");
                    boolean hasItems = false; // Flag to check if there are items in the cart
                    while (rs.next()) {
                        hasItems = true; // Found at least one item
                        String productName = rs.getString("product_name");
                        int quantity = rs.getInt("quantity");
                        double price = rs.getDouble("price");
                        total += price * quantity;
                        session.setAttribute("Total", total);
            %>
            <li class="cart-item">
                <span><%= productName %> (x<%= quantity %>)</span>
                <span>$<%= price * quantity %></span>
                <form action="cart.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="update_id" value="<%= rs.getInt("product_id") %>">
                    <input type="number" name="quantity" class="quantity-input" value="<%= quantity %>" min="1">
                    <button type="submit" class="btn">Update</button>
                </form>
                <form action="cart.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="remove_id" value="<%= rs.getInt("product_id") %>">
                    <button type="submit" class="remove-btn">Remove</button>
                </form>
            </li>
            <%
                    }
                    if (!hasItems) {
                        out.println("<li style='color: red;'>Your cart is empty.</li>");
                    }
                } catch (SQLException e) {
                    out.println("<div style='color: red;'>Database error: " + e.getMessage() + "</div>");
                } catch (ClassNotFoundException e) {
                    out.println("<div style='color: red;'>JDBC Driver not found: " + e.getMessage() + "</div>");
                } catch (Exception e) {
                    out.println("<div style='color: red;'>An error occurred: " + e.getMessage() + "</div>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        out.println("<div style='color: red;'>Error closing resources: " + e.getMessage() + "</div>");
                    }
                }
            %>
            </ul>
            <h3>Total: $<%= total %></h3>
            <a href="categories.jsp" class="btn">Add Another Item</a>
            <a href="orderFormPage.jsp" class="btn">Checkout</a>
        </div>
    </body>
</html>
