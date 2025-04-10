<%@ page language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link rel="stylesheet" href="adminLoginStyle.css">
</head>
<body>
    <header>
        <h1>Admin Login</h1>
    </header>
    <main>
        <div class="form-container">
            <form action="AdminLoginServlet" method="post">
                <h2>Login as Admin</h2>
                <!-- Display error message if redirected with an error -->
                <%
                    String message = request.getParameter("message");
                    if (message != null) {
                %>
                    <p style="color: red;"><%= message %></p>
                <%
                    }
                %>
                <input type="email" name="email" placeholder="Enter Email" required>
                <input type="password" name="password" placeholder="Enter Password" required>
                <button type="submit">Login</button>
            </form>
        </div>
    </main>
    <footer>
        <p>&copy; 2025 Car Rental System</p>
    </footer>
</body>
</html>
