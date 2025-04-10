package com.carrentalsystem;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

//@WebServlet("/BookCarServlet")
public class BookCarServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("car_id"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String purpose = request.getParameter("purpose");
        int days = Integer.parseInt(request.getParameter("days"));
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");

        try (Connection conn = DBConnection.getConnection()) {
            // 🔹 Get price per day of the car
            String priceQuery = "SELECT price_per_day, car_name FROM cars WHERE id = ?";
            PreparedStatement priceStmt = conn.prepareStatement(priceQuery);
            priceStmt.setInt(1, carId);
            ResultSet rs = priceStmt.executeQuery();

            if (rs.next()) {
                int pricePerDay = rs.getInt("price_per_day");
                String carName = rs.getString("car_name");
                int totalPrice = pricePerDay * days;

                // 🔹 Store booking details
                String insertQuery = "INSERT INTO booked (car_id, username, email, name, address, purpose, days, start_date, end_date, total_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(insertQuery);
                stmt.setInt(1, carId);
                stmt.setString(2, username);
                stmt.setString(3, email);
                stmt.setString(4, name);
                stmt.setString(5, address);
                stmt.setString(6, purpose);
                stmt.setInt(7, days);
                stmt.setString(8, startDate);
                stmt.setString(9, endDate);
                stmt.setInt(10, totalPrice);
                stmt.executeUpdate();

                // 🔹 Update car availability
                String updateCar = "UPDATE cars SET availability = FALSE WHERE id = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateCar);
                updateStmt.setInt(1, carId);
                updateStmt.executeUpdate();

                // 🔹 Send confirmation email
                String subject = "Booking Confirmation";
                String content = "Dear " + name + ",\n\nYour booking for " + purpose + " from " + startDate + " to " + endDate + " has been confirmed.\n\nTotal Amount: ₹" + totalPrice + "\n\nThank you!";
                SendEmail.send(email, subject, content);

                // 🔹 Store in session and forward to popup
                HttpSession session = request.getSession();
                session.setAttribute("carName", carName);
                session.setAttribute("name", name);
                session.setAttribute("startDate", startDate);
                session.setAttribute("endDate", endDate);
                session.setAttribute("days", days);
                session.setAttribute("totalPrice", totalPrice);

                response.sendRedirect("BookingPopup.jsp"); // 🚨 Make sure this JSP exists
            } else {
                response.sendRedirect("userDashboard.jsp?msg=Car not found!");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("userDashboard.jsp?msg=Error booking car!");
        }
    }
}
