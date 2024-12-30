<html>
<head>
    <title>Welcome to the Grocery Shop</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-image: url('images/pexels-shvetsa-3962292.jpg'); /* Replace with your image URL */
            background-size: cover;
            background-position: center;
            color: #fff;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            background: rgba(255, 255, 255, 0.7); /* Increased opacity for better text visibility */
            border-radius: 10px;
            padding: 20px;
            backdrop-filter: blur(10px); /* Glassmorphism effect */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
        }
        h1 {
            color: black;
            margin-top: 20px;
        }
        p {
            color: black;
        }
        .btn {
            background: rgba(39, 174, 96, 0.8);
            color: black;
            padding: 10px 20px;
            text-decoration: none;
            font-size: 18px;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin-top: 20px;
        }
        .btn:hover {
            background-color: rgba(46, 204, 113, 1);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to the Grocery Shop</h1>
        <p>Your one-stop solution for all your grocery needs!</p>
        <a href="categories.jsp" class="btn">Start Shopping</a>
    </div>
</body>
</html>
