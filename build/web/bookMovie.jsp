<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book a Movie</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>Book Your Movie</h2>

    <%
        String userName = (String) session.getAttribute("userName");
        String userEmail = (String) session.getAttribute("userEmail");
        String selectedMovieId = request.getParameter("movieId");
        String selectedShowtime = request.getParameter("showtime");

        if (selectedMovieId == null || selectedShowtime == null) {
    %>
        <p style="color:red;">Error: Movie or showtime not selected. Please go back.</p>
    <%
            return;
        }
    %>

    <form method="GET" action="selectSeats.jsp">
        <label>Name:</label>
        <input type="text" name="userName" value="<%= userName %>" readonly><br>

        <label>Email:</label>
        <input type="email" name="userEmail" value="<%= userEmail %>" readonly><br>

        <label>Movie:</label>
        <select name="movieID" readonly>
            <%
                try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/movieticket", "root", "123456");
                     PreparedStatement pstmt = con.prepareStatement("SELECT ID, Name FROM movie");
                     ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        String movieId = String.valueOf(rs.getInt("ID"));
                        String movieName = rs.getString("Name");
            %>
                <option value="<%= movieId %>" <%= movieId.equals(selectedMovieId) ? "selected" : "" %>><%= movieName %></option>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error fetching movies.</p>");
                }
            %>
        </select><br>

        <label>Showtime:</label>
        <input type="text" name="showtime" value="<%= selectedShowtime %>" readonly><br>

        <button type="submit">Proceed to Seat Selection</button>
    </form>
</body>
</html>
