package movieBooking.user.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import movieBooking.admin.model.User;
import movieBooking.connection.ConnectionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class BookMovieServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Step 1: Read form data from request
        String[] selectedSeats = request.getParameterValues("selectedSeats");
        String showTime = request.getParameter("showtime");
        int movieID = Integer.parseInt(request.getParameter("movieID"));

        // ✅ Step 1.1: Get user ID from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedAdmin") == null) {
            response.sendRedirect("userlogin.jsp");
            return;
        }
        User loggedUser = (User) session.getAttribute("loggedAdmin");
        int userID = loggedUser.getId(); // Assuming getId() returns the user ID

        // ✅ Step 2: Validate seat selection
        if (selectedSeats == null || selectedSeats.length == 0) {
            response.sendRedirect("booking_failed.jsp");
            return;
        }

        try (Connection conn = ConnectionDB.getCon()) {
            conn.setAutoCommit(false);

            for (String seat : selectedSeats) {
                int seatID = Integer.parseInt(seat);

                // Insert booking
                String insertBooking = "INSERT INTO bookings (UserID, MovieID, SeatID, ShowTime, PaymentStatus, BookingDate)\n" +
"VALUES (?, ?, ?, ?, 'Paid', CURRENT_DATE);";
                try (PreparedStatement ps = conn.prepareStatement(insertBooking)) {
                    ps.setInt(1, userID);
                    ps.setInt(2, movieID);
                    ps.setInt(3, seatID);
                    ps.setString(4, showTime);
                    ps.executeUpdate();
                }

                // Update seat status
                String updateSeat = "UPDATE seats SET Status = 'Booked' WHERE SeatID = ?";
                try (PreparedStatement ps = conn.prepareStatement(updateSeat)) {
                    ps.setInt(1, seatID);
                    ps.executeUpdate();
                }
            }

            conn.commit();

            // ✅ Step 3: Save booking info into existing session for payment.jsp
            session.setAttribute("selectedSeats", selectedSeats);
            session.setAttribute("movieID", movieID);
            session.setAttribute("showtime", showTime);

            // ✅ Step 4: Redirect to payment page
            response.sendRedirect("payment.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("booking_failed.jsp");
        }
    }
}
