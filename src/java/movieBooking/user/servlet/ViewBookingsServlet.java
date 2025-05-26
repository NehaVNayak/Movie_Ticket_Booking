package movieBooking.user.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import movieBooking.admin.model.Book;
import movieBooking.admin.model.User;
import movieBooking.connection.ConnectionDB;

public class ViewBookingsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedAdmin") == null) {
            response.sendRedirect("userlogin.jsp");
            return;
        }
        User loggedUser = (User) session.getAttribute("loggedAdmin");
        int userID = loggedUser.getId(); // Assuming getId() returns the user ID

        List<Book> bookings = new ArrayList<>();

        try (Connection conn = ConnectionDB.getCon()) {
            String query = "SELECT b.BookingID, b.UserID, b.MovieID, b.SeatID, b.ShowTime, b.PaymentStatus, b.bookingDate, " +
                           "m.Name AS MovieName, s.SeatNumber " +
                           "FROM bookings b " +
                           "JOIN movie m ON b.MovieID = m.ID " +
                           "JOIN seats s ON b.SeatID = s.SeatID " +
                           "WHERE b.UserID = ?";

            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setInt(1, userID);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    // Retrieving bookingDate as Date
                    Date bookingDate = rs.getDate("bookingDate");
                    String formattedDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(bookingDate);

                    Book booking = new Book(
                        rs.getInt("BookingID"),
                        rs.getInt("UserID"),
                        rs.getInt("MovieID"),
                        rs.getInt("SeatID"),
                        rs.getString("ShowTime"),
                        rs.getString("PaymentStatus"),
                        formattedDate // Store the formatted date as a string
                    );

                    // Setting movie name and seat number as request attributes
                    request.setAttribute("movie_" + booking.getBookingID(), rs.getString("MovieName"));
                    request.setAttribute("seat_" + booking.getBookingID(), rs.getString("SeatNumber"));

                    bookings.add(booking);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("view_booking.jsp").forward(request, response);
    }
}
