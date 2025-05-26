package movieBooking.user.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import movieBooking.connection.ConnectionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class FetchSeatsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String movieID = request.getParameter("movieID");
        String showtime = request.getParameter("showtime");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (movieID == null || showtime == null) {
            out.println("<p style='color:red;'>Error: Missing movie ID or showtime.</p>");
            return;
        }

        try (Connection con = ConnectionDB.getCon();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT SeatNumber, Status FROM seats WHERE MovieID = ? AND ShowTime = ?")) {
            ps.setInt(1, Integer.parseInt(movieID));
            ps.setString(2, showtime);

            ResultSet rs = ps.executeQuery();

            boolean seatsFound = false;
            while (rs.next()) {
                String seat = rs.getString("SeatNumber");
                String status = rs.getString("Status");

                String cssClass = "seat " + (status.equalsIgnoreCase("Booked") ? "booked" : "available");

                // Display the seat with its status, and allow selection if available
                out.println("<div id='" + seat + "' class='" + cssClass + "' onclick='selectSeat(\"" + seat + "\")'>" + seat + "</div>");
                seatsFound = true;
            }

            // If no seats found for the given movie/showtime, show an appropriate message
            if (!seatsFound) {
                out.println("<p style='color:red;'>No seats available for this movie/showtime.</p>");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>Error loading seat map. Please try again later.</p>");
        }
    }
}
