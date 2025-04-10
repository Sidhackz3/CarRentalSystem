package com.carrentalsystem;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/images/*")  // This will map all requests starting with /images/
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the requested image name from the URL
        String imageName = request.getPathInfo(); // e.g., /car1.jpg
        if (imageName == null || imageName.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Image name is missing.");
            return;
        }

        // Remove leading slash
        imageName = imageName.substring(1);

        // Get the real path of the image inside WEB-INF/images
        String imagePath = getServletContext().getRealPath("/WEB-INF/images/" + imageName);
        File imageFile = new File(imagePath);

        // Check if the file exists
        if (!imageFile.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found.");
            return;
        }

        // Set the content type based on the file extension
        String contentType = getServletContext().getMimeType(imageFile.getName());
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        response.setContentType(contentType);

        // Read the image file and write it to the response output stream
        try (FileInputStream fis = new FileInputStream(imageFile);
             OutputStream out = response.getOutputStream()) {

            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}
