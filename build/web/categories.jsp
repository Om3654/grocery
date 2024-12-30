<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Categories</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            color: #fff;
            margin: 0;
            padding: 20px;
            text-align: center;
            position: relative; /* Make body position relative for absolute positioning of the overlay */
            overflow: hidden; /* Prevent overflow */
        }
        h1 {
            color: #fff;
            margin-top: 20px;
            position: relative; /* Ensure it appears above the overlay */
            z-index: 2; /* Bring it above the background */
        }
        ul {
            list-style-type: none;
            padding: 10px;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            position: relative; /* Ensure it appears above the overlay */
            z-index: 2; /* Bring it above the background */
        }
        .background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('images/gemma-stpjHJGqZyw-unsplash.jpg');
            background-size: cover;
            background-position: center;
            filter: blur(8px); /* Adjust blur level here */
            z-index: 1; /* Place behind other content */
        }
        .category-item {
            position: relative;
            margin: 10px; /* Space between images */
            width: 220px; /* Increased width */
            height: 180px; /* Decreased height */
            overflow: hidden;
            transition: transform 0.3s;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        .category-item:hover {
            transform: scale(1.05);
        }
        .category-item img {
            width: 100%; /* Full width */
            height: 90%; /* Decreased height to fit the new dimensions */
            object-fit: cover; /* Maintain aspect ratio while covering the area */
            filter: brightness(1.2);
            z-index: 1;
        }
        .category-name {
            margin-top: 5px; /* Space above the name */
            color: #fff; /* Text color */
            font-weight: bold; /* Bold text */
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.7); /* Add shadow for better visibility */
            margin-bottom: 20px;
        }
        .category-item a {
            text-decoration: none; /* Remove underline */
            color: #fff; /* Text color */
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 2;
            padding: 10px;
        }
    </style>
</head>
<body>
    <div class="background"></div> <!-- Blurred background -->
    <h1>Product Categories</h1>
    <ul>
      
        <%
            String[][] categories = {
                {"Fruits", "images/2e0e582530e34a1a196bdcb75140be15.jpg"},
                {"Vegetables", "images/lovepik-fruits-and-vegetables-poster-picture_501615020.jpg"},
                {"Dairy", "images/diary2.jpg"},
                {"Bakery", "images/pngtree-large-display-of-bread-image_2579762.jpg"},
                {"Meat", "images/360_F_226538033_C42p96JDNwkSdQs86Agxd1TtaVJsyJ71.jpg"},
                {"Seafood", "images/360_F_316349769_DMsbtix2INNH3qkrsaFfZRqT59MiLcTP.jpg"},
                {"Snacks", "images/still-life-salty-potato-dip-6.jpg"},
                {"Beverages", "images/d-oing-products-coca-cola-c3437.jpg"},
                {"Frozen Foods", "images/frozen_foods.jpg"},
                {"Condiments", "images/condiments1.jpg"}
            };

            for (int i = 0; i < categories.length; i++) {
        %>
            <li class="category-item">
                <a href="products.jsp?category=<%= categories[i][0] %>">
                    <img src="<%= categories[i][1] %>" alt="<%= categories[i][0] %>">
                    <div class="category-name"><%= categories[i][0] %></div> <!-- Category name below the image -->
                </a>
            </li>
        <%
            }
        %>
    </ul>
</body>
</html>
