<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*, com.carrentalsystem.DBConnection" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
    response.setHeader("Pragma", "no-cache"); 
    response.setHeader("Expires", "0");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="adminDashStyle.css">
</head>
<body>
    <header>
        <h1>Admin Dashboard</h1>
        <h2>Welcome, <%= session.getAttribute("username") %></h2>
    </header>

    <div class="content">
        <h2>Add a New Car</h2>
        <form action="ManageCarsServlet" method="post">
            <input type="text" name="car_name" placeholder="Car Name" required>
            <input type="text" name="car_model" placeholder="Car Model" required>
            <input type="number" step="0.01" name="price_per_day" placeholder="Price Per Day" required>
            <button type="submit" name="action" value="add">Add Car</button>
        </form>

        <!-- Available Cars List -->
        <h2>Available Cars</h2>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Car ID</th>
                        <th>Car Name</th>
                        <th>Model</th>
                        <th>Price Per Day</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try (Connection conn = DBConnection.getConnection()) {
                            String availableCarsQuery = "SELECT * FROM cars WHERE availability = true";
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery(availableCarsQuery);

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("car_name") %></td>
                        <td><%= rs.getString("car_model") %></td>
                        <td><%= rs.getDouble("price_per_day") %></td>
                        <td>
                            <form action="ManageCarsServlet" method="post">
                                <input type="hidden" name="car_id" value="<%= rs.getInt("id") %>">
                                <button type="submit" name="action" value="delete">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                    %>
                    <tr>
                        <td colspan="5" class="error">Error loading available cars.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Booked Cars List -->
        <h2>Booked Cars</h2>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Car ID</th>
                        <th>Car Name</th>
                        <th>Model</th>
                        <th>Price Per Day</th>
                        <th>Booked By</th>
                        <th>Booker Email</th>
                        <th>Purpose</th>
                        <th>Booking Dates</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try (Connection conn = DBConnection.getConnection()) {
                            String bookedCarsQuery = "SELECT c.id, c.car_name, c.car_model, c.price_per_day, " +
                                                     "b.username, b.email, b.purpose, b.start_date, b.end_date " +
                                                     "FROM cars c INNER JOIN booked b ON c.id = b.car_id";
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery(bookedCarsQuery);

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("car_name") %></td>
                        <td><%= rs.getString("car_model") %></td>
                        <td><%= rs.getDouble("price_per_day") %></td>
                        <td><%= rs.getString("username") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("purpose") %></td>
                        <td><%= rs.getDate("start_date") %> to <%= rs.getDate("end_date") %></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                    %>
                    <tr>
                        <td colspan="8" class="error">Error loading booked cars.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <footer>
        <a href="LogoutServlet">Logout</a>
    </footer>
</body>
</html>
