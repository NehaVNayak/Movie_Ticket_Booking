package movieBooking.admin.dao;

import movieBooking.admin.model.Movie;
import movieBooking.admin.services.ManageMovieService;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieDao implements ManageMovieService {
    private final Connection conn;

    public MovieDao(Connection conn) {
        this.conn = conn;
    }

    // 1️⃣ Get all movies
    @Override
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

    // 2️⃣ Add a movie
    @Override
    public boolean addMovie(Movie movie) {
        String sql = "INSERT INTO movie (Name, Director, Releasing_Date, Casts, Description,  Poster, Duration, Trailer,  Category) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, movie.getName());
            stmt.setString(2, movie.getDirector());
            stmt.setString(3, movie.getReleaseDate());
            stmt.setString(4, movie.getCasts());
            stmt.setString(5, movie.getDescription());
            stmt.setString(6, movie.getPoster());
            stmt.setString(7, movie.getDuration());
            stmt.setString(8, movie.getTrailer());
            stmt.setString(9, movie.getCategory());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 3️⃣ Update a movie
    @Override
    public boolean updateMovie(Movie movie) {
        String sql = "UPDATE movie SET Name=?, Director=?, Description=?, Releasing_Date=?, Casts=?, Poster=?, Trailer=?, Duration=?, Category=? WHERE ID=?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, movie.getName());
            stmt.setString(2, movie.getDirector());
            stmt.setString(3, movie.getDescription());
            stmt.setString(4, movie.getReleaseDate());
            stmt.setString(5, movie.getCasts());
            stmt.setString(6, movie.getPoster());
            stmt.setString(7, movie.getTrailer());
            stmt.setString(8, movie.getDuration());
            stmt.setString(9, movie.getCategory());
            stmt.setInt(10, movie.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 4️⃣ Delete a movie
    @Override
    public boolean deleteMovie(int id) {
        String sql = "DELETE FROM movie WHERE ID=?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
