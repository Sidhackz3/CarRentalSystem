<%@ page language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="registerStyle.css">
</head>
<body>
    <h2>Register</h2>
    <form action="UserRegisterServlet" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Register</button>
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
