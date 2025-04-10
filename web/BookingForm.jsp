<%@ page session="true" %>
<%
    String carId = request.getParameter("car_id");
    String carName = request.getParameter("car_name");
    String username = request.getParameter("username");
    String email = request.getParameter("email");

    if (username == null || email == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book <%= carName %></title>
    <link rel="stylesheet" href="BookingStyle.css">
</head>
<body>

    <!-- ? Header -->
    <div class="header">
        <h1>Welcome, <%= username %></h1>
        <p>You are booking: <span class="car-name"><%= carName %></span></p>
        <p id="quote">"Zindagi ki gaadi aage badhani hai? First, rent the right one!" ?</p>
        <h2>Fill in your details to confirm</h2>
    </div>

    <!-- ? Form Wrapper -->
    <div class="form-wrapper">
        <div class="form-container">
            <form action="BookCarServlet" method="post" onsubmit="return calculatePrice()">
                <input type="hidden" name="car_id" value="<%= carId %>">
                <input type="hidden" name="username" value="<%= username %>">
                <input type="hidden" name="email" value="<%= email %>">
                <input type="hidden" name="total_price" id="total_price">

                <label>Name:</label>
                <input type="text" name="name" required>

                <label>Address:</label>
                <input type="text" name="address" required>

                <label>Booking Purpose:</label>
                <input type="text" name="purpose" required>

                <label>Number of Days:</label>
                <input type="number" name="days" id="days" required>

                <label>Cost per Day (?):</label>
                <input type="number" id="cost_per_day" value="1000" readonly> <!-- Default value, can be set dynamically -->

                <label>Start Date:</label>
                <input type="date" name="start_date" required>

                <label>End Date:</label>
                <input type="date" name="end_date" required>

                <button type="submit">Confirm Booking</button>
            </form>
        </div>
    </div>

</body>
</html>
