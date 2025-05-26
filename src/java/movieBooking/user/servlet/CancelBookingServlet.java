package movieBooking.user.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import movieBooking.connection.ConnectionDB;

public class CancelBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingIDParam = request.getParameter("bookingID");

        if (bookingIDParam == null || bookingIDParam.isEmpty()) {
            response.sendRedirect("ViewCancelServlet?error=missingID");
            return;
        }

        int bookingID = Integer.parseInt(bookingIDParam);

        try (Connection conn = ConnectionDB.getCon()) {
            // 🔹 Step 1: Get SeatID before deleting the booking
            int seatID = -1;
            String getSeatQuery = "SELECT SeatID FROM bookings WHERE BookingID = ?";
            try (PreparedStatement ps = conn.prepareStatement(getSeatQuery)) {
                ps.setInt(1, bookingID);
                var rs = ps.executeQuery();
                if (rs.next()) {
                    seatID = rs.getInt("SeatID");
                }
            }
            // 🔹 Step 2: Delete the booking record
            String deleteQuery = "DELETE FROM bookings WHERE BookingID = ?";
            try (PreparedStatement ps = conn.prepareStatement(deleteQuery)) {
                ps.setInt(1, bookingID);
                ps.executeUpdate();
            }

            // 🔹 Step 3: Update the seat status to 'Available' if SeatID was found
            if (seatID != -1) {
                String updateSeatQuery = "UPDATE seats SET Status = 'Available' WHERE SeatID = ?";
                try (PreparedStatement ps = conn.prepareStatement(updateSeatQuery)) {
                    ps.setInt(1, seatID);
                    ps.executeUpdate();
                }
            }

            response.sendRedirect("ViewCancelServlet?success=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewCancelServlet?error=exception");
        }
    }
}
