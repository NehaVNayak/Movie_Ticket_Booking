package movieBooking.user.dao;

import java.sql.*;
import java.util.List;
import movieBooking.connection.ConnectionDB;

public class BookSeatsDao {

    public boolean bookSelectedSeats(int movieID, String showtime, List<String> seatNumbers) throws SQLException, ClassNotFoundException {
        String query = "UPDATE seats SET Status = 'Booked' WHERE MovieID = ? AND ShowTime = ? AND SeatNumber = ? AND Status = 'Available'";

        try (Connection con = ConnectionDB.getCon();
             PreparedStatement ps = con.prepareStatement(query)) {

            for (String seatNumber : seatNumbers) {
                ps.setInt(1, movieID);
                ps.setString(2, showtime);
                ps.setString(3, seatNumber);
                ps.addBatch();
            }

            int[] updateCounts = ps.executeBatch();
            int successful = 0;
            for (int count : updateCounts) successful += count;

            return successful > 0;
        }
    }
}
