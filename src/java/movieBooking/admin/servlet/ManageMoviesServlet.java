package movieBooking.admin.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import movieBooking.admin.dao.MovieDao;
import movieBooking.admin.model.Movie;
import movieBooking.connection.ConnectionDB;

public class ManageMoviesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        MovieDao movieDao = new MovieDao(ConnectionDB.getCon());
        List<Movie> movies = movieDao.getAllMovies();
        request.setAttribute("movies", movies);
        request.getRequestDispatcher("/admin/manage_movies.jsp").forward(request, response);
    } catch (SQLException | ClassNotFoundException e) {
        throw new ServletException(e);
    }
}


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            MovieDao movieDao = new MovieDao(ConnectionDB.getCon());

            if ("add".equals(action)) {
                Movie movie = new Movie();
                movie.setName(request.getParameter("name"));
                movie.setDirector(request.getParameter("director"));
                movie.setDescription(request.getParameter("description"));
                movie.setReleaseDate(request.getParameter("releaseDate"));
                movie.setCasts(request.getParameter("casts"));
                movie.setPoster(request.getParameter("poster"));
                movie.setTrailer(request.getParameter("trailer"));
                movie.setDuration(request.getParameter("duration"));
                movie.setCategory(request.getParameter("category"));
                
                movieDao.addMovie(movie);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                movieDao.deleteMovie(id);
            }

            response.sendRedirect("ManageMoviesServlet");
        } catch (SQLException e) {
            throw new ServletException(e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ManageMoviesServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}

