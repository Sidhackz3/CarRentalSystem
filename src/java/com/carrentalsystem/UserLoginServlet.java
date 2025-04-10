package com.carrentalsystem;

import com.carrentalsystem.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class UserLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT username, password, role FROM users WHERE email = ?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");  // Get plain text password from DB

                // ✅ Simple text password comparison
                if (password.equals(storedPassword)) {  
                    HttpSession session = request.getSession();
                    session.setAttribute("username", rs.getString("username"));
                    session.setAttribute("email", email);
                    session.setAttribute("role", rs.getString("role"));

                    // ✅ Redirect user based on role
                    if ("admin".equals(rs.getString("role"))) {
                        response.sendRedirect("adminDashboard.jsp");
                    } else {
                        response.sendRedirect("userDashboard.jsp");
                    }
                } else {
                    response.sendRedirect("login.jsp?message=Invalid email or password.");
                }
            } else {
                response.sendRedirect("login.jsp?message=Invalid email or password.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: Unable to log in.");
        }
    }
}
