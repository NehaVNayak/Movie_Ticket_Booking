import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import movieBooking.connection.ConnectionDB;

public class GetMoviePosterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String movieID = request.getParameter("movieID");

        try (Connection conn = ConnectionDB.getCon()) {
            String query = "SELECT Poster FROM movie WHERE ID = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, Integer.parseInt(movieID));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String posterURL = rs.getString("Poster");
                out.println("<img src='" + posterURL + "' alt='Movie Poster' class='poster-img'>");
            } else {
                out.println("<p class='center-align red-text'>No poster found</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p class='center-align red-text'>Error fetching poster</p>");
        }
    }
}
