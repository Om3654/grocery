<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product List - Grocery App</title>
    <style>
        body {
            background-image: url('images/product_background.jpg');
            background-size: cover;
            background-position: center;
            font-family: 'Arial', sans-serif;
            color: #333;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            background: rgba(255, 255, 255, 0.5);
            border-radius: 15px;
            padding: 35px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.2);
            width: 80%;
            max-width: 800px;
            overflow-y: auto;
            max-height: 80vh;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .product-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .product {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 10px;
            padding: 15px;
            background: rgba(236, 240, 241, 0.9);
            border-radius: 10px;
            transition: transform 0.2s;
            width: 150px;
        }

        .product:hover {
            transform: scale(1.05);
        }

        img {
            width: 150px;
            height: 150px;
            border-radius: 10px;
            margin-bottom: 10px;
        }

        .price {
            font-size: 18px;
            margin: 10px 0;
            color: #333;
        }

        .add-to-cart {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .add-to-cart:hover {
            background-color: #2980b9;
        }

        @media (max-width: 600px) {
            .container {
                width: 95%;
                padding: 20px;
            }

            h1 {
                font-size: 24px;
            }

            img {
                width: 80px;
                height: 80px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Products</h1>
        <div class="product-list">
        <%
            String[][] products = {
                {"Apple", "1.00", "1", "Fruits", "images/apple.jpg"},
                {"Banana", "0.50", "2", "Fruits", "images/banana.jpg"},
                {"Orange", "0.75", "3", "Fruits", "images/orange.jpg"},
                {"Grapes", "2.00", "4", "Fruits", "images/grapes.jpg"},
                {"Mango", "1.50", "5", "Fruits", "images/mango.jpg"},
                {"Carrot", "0.80", "6", "Vegetables", "images/carrots.jpg"},
                {"Broccoli", "1.20", "7", "Vegetables", "images/broccoli.jpg"},
                {"Spinach", "1.00", "8", "Vegetables", "images/spinach.jpg"},
                {"Potato", "0.40", "9", "Vegetables", "images/potato.jpg"},
                {"Onion", "0.60", "10", "Vegetables", "images/onion.jpg"},
                {"Milk", "1.25", "11", "Dairy", "images/milk.jpg"},
                {"Cheese", "2.50", "12", "Dairy", "images/cheese.jpg"},
                {"Yogurt", "0.90", "13", "Dairy", "images/yogurt.jpg"},
                {"Butter", "2.00", "14", "Dairy", "images/butter.jpg"},
                {"Cream", "1.75", "15", "Dairy", "images/cream1.jpg"},
                {"Bread", "1.50", "16", "Bakery", "images/bread.jpg"},
                {"Croissant", "1.00", "17", "Bakery", "images/croissant.jpg"},
                {"Bagel", "0.75", "18", "Bakery", "images/bagel.jpg"},
                {"Danish", "1.20", "19", "Bakery", "images/danish.jpg"},
                {"Bun", "0.50", "20", "Bakery", "images/bun.jpg"},
                {"Chicken", "5.00", "21", "Meat", "images/chicken.jpg"},
                {"Mutton", "7.00", "22", "Meat", "images/beef.jpg"},
                {"Pork", "6.00", "23", "Meat", "images/pork.jpg"},
                {"Fish", "8.00", "24", "Meat", "images/fish.jpg"},
                {"Lamb", "9.00", "25", "Meat", "images/lamb.jpg"},
                {"Salmon", "10.00", "26", "Seafood", "images/salmon.jpg"},
                {"Shrimp", "12.00", "27", "Seafood", "images/shrimp.jpg"},
                {"Tuna", "8.50", "28", "Seafood", "images/tuna.jpg"},
                {"Crab", "15.00", "29", "Seafood", "images/crab.jpg"},
                {"Lobster", "20.00", "30", "Seafood", "images/lobster.jpg"},
                {"Chips", "1.50", "31", "Snacks", "images/chips.jpg"},
                {"Cookies", "2.00", "32", "Snacks", "images/cookies.jpg"},
                {"Nuts", "3.00", "33", "Snacks", "images/nuts.jpg"},
                {"Popcorn", "1.00", "34", "Snacks", "images/popcorn.jpg"},
                {"Candy", "0.75", "35", "Snacks", "images/candy.jpg"},
                {"Soda", "1.25", "36", "Beverages", "images/soda.jpg"},
                {"Juice", "2.00", "37", "Beverages", "images/juice.jpg"},
                {"Water", "0.50", "38", "Beverages", "images/water.jpg"},
                {"Tea", "1.50", "39", "Beverages", "images/tea.jpg"},
                {"Coffee", "2.50", "40", "Beverages", "images/coffee.jpg"},
                {"Frozen Pizza", "5.00", "41", "Frozen Foods", "images/frozen_pizza.jpg"},
                {"Ice Cream", "3.00", "42", "Frozen Foods", "images/ice_cream.jpg"},
                {"Frozen Vegetables", "2.00", "43", "Frozen Foods", "images/frozen_vegetables.jpg"},
                {"Frozen Meals", "4.00", "44", "Frozen Foods", "images/frozen_meals.jpg"},
                {"Frozen Fruits", "3.50", "45", "Frozen Foods", "images/frozen_fruits.jpg"},
                {"Ketchup", "1.00", "46", "Condiments", "images/ketchup.jpg"},
                {"Mustard", "0.80", "47", "Condiments", "images/mustard.jpg"},
                {"Soy Sauce", "1.50", "48", "Condiments", "images/soy_sauce.jpg"},
                {"Hot Sauce", "1.25", "49", "Condiments", "images/hot_sauce.jpg"},
                {"Olive Oil", "5.00", "50", "Condiments", "images/olive_oil.jpg"}
            };

             String selectedCategory = request.getParameter("category");
            int count = 0;
            boolean foundProduct = false;
            for (int i = 0; i < products.length; i++) {
                if (products[i][3].equalsIgnoreCase(selectedCategory) && count < 5) {
                    out.println("<div class='product'>");
                    out.println("<img src='" + products[i][4] + "' alt='" + products[i][0] + "' />");
                    out.println("<div class='name'>" + products[i][0] + "</div>");
                    out.println("<div class='price'>$" + products[i][1] + "</div>");
                    out.println("<button class='add-to-cart' onclick=\"window.location.href='add_to_cart.jsp?product_id=" + products[i][2] + "&quantity=1'\">Add to Cart</button>");
                    out.println("</div>");
                    count++;
                    foundProduct = true;
                }
            }

            if (!foundProduct) {
                out.println("<div style='color: #333; text-align: center;'>No products found in this category.</div>");
            }
        %>
        </div>
    </div>
</body>
</html>
