<%@ page language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="loginStyle.css">
</head>
<body>
    <h2>Login</h2>
    <form action="UserLoginServlet" method="post">
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>
    <%
        String message = request.getParameter("message");
        if (message != null) {
    %>
        <p style="color: green;"><%= message %></p>
    <%
        }
    %>
</body>
</html>
