package movieBooking.user.servlet;

import java.io.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.json.JSONArray;
import org.json.JSONObject;
import movieBooking.user.dao.BookSeatsDao;

import java.util.*;

public class BookSeatsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        StringBuilder jb = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                jb.append(line);
            }
        }

        try {
            JSONObject json = new JSONObject(jb.toString());
            int movieID = json.getInt("movieID");
            String showtime = json.getString("showtime");
            JSONArray seatsArray = json.getJSONArray("seats");

            List<String> seatList = new ArrayList<>();
            for (int i = 0; i < seatsArray.length(); i++) {
                seatList.add(seatsArray.getString(i));
            }

            BookSeatsDao dao = new BookSeatsDao();
            boolean success = dao.bookSelectedSeats(movieID, showtime, seatList);

            response.setContentType("text/plain");
            response.getWriter().write(success ? "Seats booked successfully!" : "No seats were booked. Try again.");
        } catch (Exception e) {
            response.setContentType("text/plain");
            response.getWriter().write("Error booking seats.");
            e.printStackTrace();
        }
    }
}
