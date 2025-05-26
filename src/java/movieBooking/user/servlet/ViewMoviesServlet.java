package movieBooking.user.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import movieBooking.admin.dao.MovieDao;
import movieBooking.admin.model.Movie;
import movieBooking.connection.ConnectionDB;

/**
 * Servlet to handle viewing of movies.
 */
public class ViewMoviesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            MovieDao movieDao = new MovieDao(ConnectionDB.getCon());
            List<Movie> movies = movieDao.getAllMovies();
            request.setAttribute("movies", movies);
            request.getRequestDispatcher("viewmovies.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }
}
