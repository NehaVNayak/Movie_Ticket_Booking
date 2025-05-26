<%@ page import="java.util.List" %>
<%@ page import="movieBooking.admin.model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Cancel Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            padding: 20px;
            display: flex;
            justify-content: center; /* Centering the content horizontally */
            align-items: center; /* Centering the content vertically */
            height: 100vh; /* Full viewport height */
            margin: 0;
            margin-top: 80px;
        }

        .container {
            width: 80%; /* Adjusted to make sure the content is not too wide */
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        table th, table td {
            padding: 10px 15px;
            text-align: center;
            border: 1px solid #e0e0e0;
        }

        table th {
            background-color: #007BFF;
            color: white;
        }

        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        form input[type="submit"] {
            background-color: #ff4d4d;
            color: white;
            padding: 6px 12px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        form input[type="submit"]:hover {
            background-color: #e60000;
        }

        td {
            vertical-align: middle;
        }

        .no-booking {
            text-align: center;
            color: red;
            font-weight: bold;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Today's Bookings</h2>

        <table>
            <tr>
                <th>Booking ID</th>
                <th>Movie</th>
                <th>Seat</th>
                <th>Show Time</th>
                <th>Payment</th>
                <th>Date</th>
                <th>Action</th>
            </tr>

            <%
                List<Book> bookings = (List<Book>) request.getAttribute("bookings");
                if (bookings != null && !bookings.isEmpty()) {
                    for (Book b : bookings) {
                        String movieName = (String) request.getAttribute("movie_" + b.getBookingID());
                        String seatNumber = (String) request.getAttribute("seat_" + b.getBookingID());
            %>
            <tr>
                <td><%= b.getBookingID() %></td>
                <td><%= movieName %></td>
                <td><%= seatNumber %></td>
                <td><%= b.getShowTime() %></td>
                <td><%= b.getPaymentStatus() %></td>
                <td><%= b.getBookingDate() %></td>
                <td>
                    <form action="CancelBookingServlet" method="post">
                        <input type="hidden" name="bookingID" value="<%= b.getBookingID() %>">
                        <input type="submit" value="Cancel">
                    </form>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr><td colspan="7" class="no-booking">No bookings made today.</td></tr>
            <%
                }
            %>
        </table>
    </div>
</body>
</html>
