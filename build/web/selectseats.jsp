<%@ page import="java.sql.*, movieBooking.connection.ConnectionDB" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Seats</title>
    <style>
        /* Global Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f7f7;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }

        h2 {
            text-align: center;
            color: #0366d6;
            margin-bottom: 30px;
            font-size: 32px;
            font-weight: bold;
            letter-spacing: 1px;
            border-bottom: 3px solid #0366d6;
            padding-bottom: 10px;
        }

        .container {
            max-width: 960px;
            margin: 40px auto;
            padding: 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }
        /* Seat container grid */
        #seat-container {
            display: grid;
            grid-template-columns: repeat(10, 1fr);
            grid-gap: 15px;
            justify-content: center;
            margin-top: 30px;
            max-width: 900px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Seat styles */
        .seat {
            width: 60px;
            height: 60px;
            border-radius: 10px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            justify-content: center;
            align-items: center;
            border: 2px solid #ddd;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            background-color: #e4e4e4;
        }

        .seat:hover {
            transform: scale(1.1);
            box-shadow: 0 8px 12px rgba(0, 123, 255, 0.3);
        }

        /* Available seat styling */
        .available {
            background-color: #28a745;
            color: white;
        }

        /* Booked seat styling */
        .booked {
            background-color: #dc3545;
            color: white;
            cursor: not-allowed;
        }

        /* Selected seat styling */
        .selected {
            background-color: #007bff;
            color: white;
        }

        /* Submit button */
        input[type="submit"] {
            display: block;
            width: 100%;
            padding: 15px;
            font-size: 1.1rem;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 30px;
            text-transform: uppercase;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        input[type="submit"]:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }

        /* Accessibility Improvements */
        .seat:focus {
            outline: 2px solid #007bff;
            outline-offset: 4px;
        }

        /* Footer Styling */
        footer {
            text-align: center;
            margin-top: 50px;
            color: #777;
            font-size: 0.9rem;
        }

        /* Mobile Responsiveness */
        @media screen and (max-width: 768px) {
            #seat-container {
                grid-template-columns: repeat(5, 1fr); /* Adjust grid for smaller screens */
            }

            .seat {
                width: 45px;
                height: 45px;
            }

            input[type="submit"] {
                font-size: 1rem;
            }
        }

        /* Center the form */
        form {
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
        }

        .form-group {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<h2>Select Your Seats</h2>

<%
    String movieID = request.getParameter("movieID");
    String showtime = request.getParameter("showtime");

    if (movieID == null || showtime == null) {
        out.println("<p style='color:red;'>Error: Missing parameters.</p>");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = ConnectionDB.getCon();
        ps = conn.prepareStatement("SELECT SeatID, SeatNumber, Status FROM seats WHERE MovieID=? AND ShowTime=? ORDER BY SeatID");
        ps.setInt(1, Integer.parseInt(movieID));
        ps.setString(2, showtime);
        rs = ps.executeQuery();
%>
<div class="container">
    <form id="bookingForm" action="BookMovieServlet" method="post">
    
    <input type="hidden" name="movieID" value="<%= movieID %>">
    <input type="hidden" name="showtime" value="<%= showtime %>">
    <div id="seat-container">
        <%
            while (rs.next()) {
                int seatID = rs.getInt("SeatID");
                String seatNumber = rs.getString("SeatNumber");
                String status = rs.getString("Status");

                String cssClass = status.equalsIgnoreCase("Booked") ? "seat booked" : "seat available";
        %>
            <div class="<%= cssClass %>" data-seatid="<%= seatID %>"><%= seatNumber %></div>
        <%
            }
        %>
    </div>

    <div id="selectedSeatsInputs"></div>
    <input type="submit" id="bookSeatsBtn" value="Book Selected Seats" style="display:none;">
</form>
</div>


<script>
    let selectedSeatIDs = [];

    $(".seat.available").on("click", function () {
        const seatID = $(this).data("seatid").toString();
        const seatDiv = $(this);

        seatDiv.toggleClass("selected");

        if (selectedSeatIDs.includes(seatID)) {
            selectedSeatIDs = selectedSeatIDs.filter(s => s !== seatID);
        } else {
            selectedSeatIDs.push(seatID);
        }

        // Update hidden inputs
        $("#selectedSeatsInputs").empty();
        selectedSeatIDs.forEach(seat => {
            $("#selectedSeatsInputs").append('<input type="hidden" name="selectedSeats" value="' + seat + '">');
        });

        $("#bookSeatsBtn").toggle(selectedSeatIDs.length > 0);
    });
</script>

<%
    } catch (Exception e) {
        out.println("<p>Error loading seats.</p>");
        e.printStackTrace(); // For logs
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (ps != null) ps.close(); } catch (Exception ignored) {}
        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
    }
%>

<footer>
    <p>&copy; 2025 Movie Booking. All Rights Reserved.</p>
</footer>

</body>
</html>
