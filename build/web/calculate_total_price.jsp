<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Calculate Total Price</title>
    <style>
       
      
        body {
            font-family: Arial, sans-serif;
            background-image: url('images/discount.jpg'); /* Replace with your image URL */
            background-size: cover;
            background-position: center;
            color: #fff;
            margin: 0;
            padding: 0;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            backdrop-filter: blur(10px);
            background-color: rgba(0, 0, 0, 0.5); /* Glassmorphism effect */
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <%
            // Database connection parameters
            String jdbcUrl = "jdbc:mysql://localhost:3306/grocerydb";
            String jdbcUser = "root";
            String jdbcPassword = "Om##3654";

            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;

            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the connection
                connection = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

                // Define the SQL call to the function
                double totalPrice = (double) session.getAttribute("Total"); // Example total price
                double discount = 10.00; // Example discount percentage
                String sql = "SELECT calculate_total_price(?, ?) AS final_price";

                // Create a PreparedStatement
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setDouble(1, totalPrice);
                preparedStatement.setDouble(2, discount);

                // Execute the query
                resultSet = preparedStatement.executeQuery();

                // Process the result
                if (resultSet.next()) {
                    double finalPrice = resultSet.getDouble("final_price");
        %>
                    <h2>Final Price: $<%= finalPrice %></h2>
        <%
                } else {
        %>
                    <h2>No result returned from the function.</h2>
        <%
                }
            } catch (SQLException sqlEx) {
                sqlEx.printStackTrace();
        %>
                <h2>SQL Error: <%= sqlEx.getMessage() %></h2>
        <%
            } catch (ClassNotFoundException cnfEx) {
                cnfEx.printStackTrace();
        %>
                <h2>Driver Error: <%= cnfEx.getMessage() %></h2>
        <%
            } catch (Exception ex) {
                ex.printStackTrace();
        %>
                <h2>Error: <%= ex.getMessage() %></h2>
        <%
            } finally {
                // Close resources
                if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
</body>
</html>
