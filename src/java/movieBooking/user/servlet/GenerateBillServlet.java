package movieBooking.user.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import movieBooking.connection.ConnectionDB;

public class GenerateBillServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieID = request.getParameter("movieID");
        String showtime = request.getParameter("showtime");

        List<String> seatNumbers = new ArrayList<>();
        double total = 0;

        try (Connection con = ConnectionDB.getCon()) {
            // 1. Get base price for the movie
            PreparedStatement priceStmt = con.prepareStatement("SELECT Cost FROM movie_prices WHERE MovieID = ?");
            priceStmt.setInt(1, Integer.parseInt(movieID));
            ResultSet priceRs = priceStmt.executeQuery();

            double basePrice = 0;
            if (priceRs.next()) {
                basePrice = priceRs.getDouble("Cost");
            }

            // 2. Get all booked seats for the movie and showtime
            PreparedStatement seatStmt = con.prepareStatement(
                    "SELECT SeatNumber, SeatType FROM seatdatabase WHERE MovieID = ? AND ShowTime = ? AND Status = 'Booked'"
            );
            seatStmt.setInt(1, Integer.parseInt(movieID));
            seatStmt.setString(2, showtime);
            ResultSet seatRs = seatStmt.executeQuery();

            while (seatRs.next()) {
                String seatNum = seatRs.getString("SeatNumber");
                String seatType = seatRs.getString("SeatType");
                double price = basePrice;

                if ("Premium".equalsIgnoreCase(seatType)) {
                    price *= 1.5; // premium price multiplier
                }

                seatNumbers.add(seatNum + " (" + seatType + ")");
                total += price;
            }

            request.setAttribute("seats", seatNumbers);
            request.setAttribute("total", total);
            request.setAttribute("movieID", movieID);
            request.setAttribute("showtime", showtime);

            request.getRequestDispatcher("bill.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error generating bill.");
        }
    }
}
