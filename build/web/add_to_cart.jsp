<%@ page import="java.sql.*" %>
<%
    String productId = request.getParameter("product_id");
    String quantity = request.getParameter("quantity");

    if (productId != null && quantity != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocerydb", "root", "Om##3654");
            CallableStatement stmt = conn.prepareCall("{call AddProductToCart(?, ?)}");
            stmt.setInt(1, Integer.parseInt(productId));
            stmt.setInt(2, Integer.parseInt(quantity));
            stmt.execute();
            stmt.close();
            conn.close();
            
            // Redirect back to the product list or cart page
            response.sendRedirect("cart.jsp");  // Modify based on the category selected
        } catch (Exception e) {
            out.println("Error adding product to cart: " + e.getMessage());
        }
    } else {
        out.println("Invalid product or quantity.");
    }
%>
