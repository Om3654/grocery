<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Summary</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('images/cart3.jsp.jpeg'); /* Replace with the actual image URL or path */
            background-size: 100% 165vh; /* Ensures the image covers the entire background */
            background-position: center; /* Centers the background image */
            background-repeat: no-repeat; /* Prevents the image from repeating */
            color: #000; /* Text color */
            text-align: center;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #333; /* Optional text styling */
        }
        .summary {
            background: rgba(255, 255, 255, 0.2); /* Slight transparency for glass effect */
            backdrop-filter: blur(10px); /* Glassmorphism effect */
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            display: inline-block;
            margin-top: 20px;
        }
        a {
            text-decoration: none;
            color: blue;
            margin-top: 15px;
            display: inline-block;
        }
        .logout-btn {
            background-color: rgba(255, 0, 0, 0.8);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin-top: 15px;
        }
        .logout-btn:hover {
            background-color: rgba(255, 0, 0, 1);
        }
        .continue-shopping-btn {
            background-color: rgba(39, 174, 96, 0.8);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin-top: 15px;
            display: inline-block;
        }
        .continue-shopping-btn:hover {
            background-color: rgba(46, 204, 113, 1);
        }
    </style>
</head>
<body>
    <h1>Order Summary</h1>
    <div class="summary">
        <p><strong>Name:</strong> <%= session.getAttribute("name") %></p>
        <p><strong>Address:</strong> <%= session.getAttribute("address") %></p>
        <p><strong>Contact:</strong> <%= session.getAttribute("contact") %></p>
        <p><strong>Payment Method:</strong> <%= session.getAttribute("paymentMethod") %></p>
        <p><strong>Total Amount:</strong> $<%= session.getAttribute("Total") %></p>
        
        <a href="categories.jsp" class="continue-shopping-btn">Continue Shopping</a>
        
    </div>
    
    <form action="index.jsp" method="get" style="margin-top: 15px;">
        <button type="submit" class="logout-btn">Logout</button>
    </form>
        <a href="calculate_total_price.jsp"> GET 10% DISCOUNT </a>
        
</body>
</html>
