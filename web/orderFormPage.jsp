<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Form - Grocery App</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-image: url('images/cart2.jpg');
            background-size: cover;
            background-position: center;
            color: #000; /* Changed text color to black */
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            filter: brightness(0.9);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 2.5em;
            text-shadow: 1px 1px 5px rgba(255, 255, 255, 0.7);
        }
        .order-container {
            background: rgba(255, 255, 255, 0.5); /* Increased opacity for better visibility */
            backdrop-filter: blur(15px);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            max-width: 600px;
            width: 100%;
        }
        label {
            display: block;
            margin: 10px 0 5px;
            font-size: 18px;
            color: #000; /* Changed label color to black */
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            margin-bottom: 15px;
            background: rgba(255, 255, 255, 0.2);
            color: #000; /* Changed input text color to black */
            transition: background 0.3s, border 0.3s;
            font-size: 16px;
        }
        input[type="text"]:focus {
            background: rgba(255, 255, 255, 0.3);
            outline: none;
            border: 1px solid rgba(39, 174, 96, 1);
        }
        .btn {
            background-color: rgba(39, 174, 96, 0.8);
            color: white;
            padding: 10px 0.5px;
            text-decoration: none;
            font-size: 16px;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.2s;
            margin-top: 10px;
            display: inline-block;
            border: none;
            cursor: pointer;
            width: 100%;
            text-align: center; /* Center text in button */
        }
        .btn:hover {
            background-color: rgba(46, 204, 113, 1);
            transform: scale(1.05);
        }
        .btn:active {
            transform: scale(0.95);
        }
        .payment-option {
            margin: 10px 0;
            color: #000; /* Changed payment option text color to black */
        }
    </style>
</head>
<body>
    <div class="order-container">
        <h1>Order Form</h1>
        <form action="orderFormPage.jsp" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" required>
            <label for="contact">Contact:</label>
            <input type="text" id="contact" name="contact" required>
            <label for="paymentMethod">Select Payment Method:</label>
            <div class="payment-option">
                <label>
                    <input type="radio" name="paymentMethod" value="creditCard" required>
                    Credit Card
                </label>
            </div>
            <div class="payment-option">
                <label>
                    <input type="radio" name="paymentMethod" value="paypal" required>
                    PayPal
                </label>
            </div>
            <div class="payment-option">
                <label>
                    <input type="radio" name="paymentMethod" value="bankTransfer" required>
                    Cash On Delivery
                </label>
            </div>
            <input type='hidden' name='total' value="<%= session.getAttribute("Total") %>">
            <input type="submit" value="Submit Order" class="btn">
        </form>
        <a href="cart.jsp" class="btn" style="margin-top: 10px;">Back to Cart</a>
    </div><!-- Your form fields -->
          
       
        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                String contact = request.getParameter("contact");
                String paymentMethod = request.getParameter("paymentMethod");
                double total = Double.parseDouble(request.getParameter("total"));
                session.setAttribute("name",name);
                session.setAttribute("address",address);
                session.setAttribute("contact",contact);
                session.setAttribute("paymentMethod",paymentMethod);
                Connection con = null;
                CallableStatement stmt = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocerydb", "root", "Om##3654");

                    
                    stmt = con.prepareCall("{CALL insert_order(?, ?, ?, ?, ?)}");
                    stmt.setString(1, name);
                    stmt.setString(2, address);
                    stmt.setString(3, contact);
                    stmt.setString(4, paymentMethod);
                    stmt.setDouble(5, total);

                    stmt.execute();

                    // Redirect on success
                    response.sendRedirect("orderSummary.jsp");
                } catch (SQLException e) {
                    out.println("<div class='error-message'>Database error: " + e.getMessage() + "</div>");
                } catch (ClassNotFoundException e) {
                    out.println("<div class='error-message'>JDBC Driver not found: " + e.getMessage() + "</div>");
                } catch (Exception e) {
                    out.println("<div class='error-message'>An error occurred: " + e.getMessage() + "</div>");
                } finally {
                    try {
                        if (stmt != null) stmt.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        out.println("<div class='error-message'>Error closing resources: " + e.getMessage() + "</div>");
                    }
                }
            }
        %>
    
</body>
</html>
