package movieBooking.user.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import movieBooking.admin.model.Seat;
import movieBooking.connection.ConnectionDB;

public class FetchSeatsDao {
    public List<Seat> getSeatsByMovie(int movieID, String showTime) throws ClassNotFoundException {
        List<Seat> seats = new ArrayList<>();
        String query = "SELECT * FROM seats WHERE MovieID = ? AND ShowTime = ?";

        try (Connection con = ConnectionDB.getCon();
             PreparedStatement ps = con.prepareStatement(query)) {
             
            ps.setInt(1, movieID);
            ps.setString(2, showTime);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                seats.add(new Seat(
                    rs.getInt("SeatID"),
                    rs.getInt("MovieID"),
                    rs.getString("ShowTime"),
                    rs.getString("SeatNumber"),
                    rs.getString("Status"),
                    rs.getString("SeatType")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seats;
    }
}
