package movieBooking.admin.services;

import movieBooking.admin.model.Movie;
import java.util.List;

public interface ManageMovieService {
    List<Movie> getAllMovies();
    boolean addMovie(Movie movie);
    boolean updateMovie(Movie movie);
    boolean deleteMovie(int id);
}
