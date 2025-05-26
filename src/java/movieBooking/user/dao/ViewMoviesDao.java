package movieBooking.user.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import movieBooking.admin.model.Movie;
import movieBooking.admin.model.Seat;
import movieBooking.admin.model.Seat;
import movieBooking.connection.ConnectionDB;

public class ViewMoviesDao {
    private Connection conn;

    public ViewMoviesDao(Connection conn) {
        this.conn = conn;
    }

    public List<Movie> getAllMovies() {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT * FROM movie";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                movies.add(new Movie(
                    rs.getInt("ID"),
                    rs.getString("Name"),
                    rs.getString("Director"),
                    rs.getString("Description"),
                    rs.getString("Releasing_Date"),
                    rs.getString("Casts"),
                    rs.getString("Poster"),
                    rs.getString("Trailer"),
                    rs.getString("Duration"),
                    rs.getString("Category")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movies;
    }
}
