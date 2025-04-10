package com.carrentalsystem;


import com.carrentalsystem.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/ManageCarsServlet")
public class ManageCarsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try (Connection conn = DBConnection.getConnection()) {
            if ("add".equals(action)) {
                String carName = request.getParameter("car_name");
                String carModel = request.getParameter("car_model");
                double pricePerDay = Double.parseDouble(request.getParameter("price_per_day"));

                String query = "INSERT INTO cars (car_name, car_model, price_per_day, availability) VALUES (?, ?, ?, TRUE)";
                PreparedStatement pst = conn.prepareStatement(query);
                pst.setString(1, carName);
                pst.setString(2, carModel);
                pst.setDouble(3, pricePerDay);
                pst.executeUpdate();
            } else if ("delete".equals(action)) {
                int carId = Integer.parseInt(request.getParameter("car_id"));

                String query = "DELETE FROM cars WHERE id = ?";
                PreparedStatement pst = conn.prepareStatement(query);
                pst.setInt(1, carId);
                pst.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminDashboard.jsp");
    }
}
