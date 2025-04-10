<%@ page import="java.sql.*, com.carrentalsystem.DBConnection" %>
<%@ page session="true" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
    response.setHeader("Pragma", "no-cache"); 
    response.setHeader("Expires", "0");

    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");

    if (username == null || email == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <h1>Welcome, <%= username %></h1>
        <p id="quote">"Zindagi ki gaadi aage badhani hai? First, rent the right one!" ?</p>
        <h2>Available Cars</h2>
    </header>
    <div>
        <table border="1" cellspacing="0" cellpadding="10">
            <tr>
                <th>Car ID</th>
                <th>Car Name</th>
                <th>Model</th>
                <th>Price Per Day</th>
                <th>Availability</th>
                <th>Action</th>
            </tr>
            <%
                try (Connection conn = DBConnection.getConnection()) {
                    String query = "SELECT * FROM cars WHERE availability = TRUE";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("car_name") %></td>
                <td><%= rs.getString("car_model") %></td>
                <td><%= rs.getDouble("price_per_day") %></td>
                <td>Available</td>
                <td>
                    <form action="BookingForm.jsp" method="get">
                        <input type="hidden" name="car_id" value="<%= rs.getInt("id") %>">
                        <input type="hidden" name="car_name" value="<%= rs.getString("car_name") %>">
                        <input type="hidden" name="username" value="<%= username %>">
                        <input type="hidden" name="email" value="<%= email %>">
                        <button type="submit"class="book-now-btn">Book Now</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <tr>
                <td colspan="6" style="color: red;">Error loading cars.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
    <footer>
        <a href="LogoutServlet"class="logout-btn">Logout</a>
    </footer>
        
    <script src="script.js"></script> 
</body>
</html>
