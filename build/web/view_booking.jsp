<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="movieBooking.admin.model.Book"%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Bookings</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            padding: 20px;
        }
        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h4.center-align {
            margin-bottom: 20px;
            text-align: center;
            color: #0366d6;
            margin-bottom: 30px;
            font-size: 32px;
            font-weight: bold;
            letter-spacing: 1px;
            border-bottom: 3px solid #0366d6;
            padding-bottom: 10px;
        }
        table.striped {
            width: 100%;
            border-collapse: collapse;
        }
        table.striped th, table.striped td {
            padding: 15px;
            text-align: center;
            border: 1px solid #e0e0e0;
        }
        table.striped th {
            background-color: #007BFF;
            color: white;
            font-size: 16px;
            font-weight: bold;
        }
        table.striped tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        table.striped tbody tr:nth-child(odd) {
            background-color: #ffffff;
        }
        table.striped tbody tr:hover {
            background-color: #f1f1f1;
        }
        .red-text {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h4 class="center-align">Your Booking History</h4>
        <table class="striped highlight">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Movie</th>
                    <th>Seat</th>
                    <th>Show Time</th>
                    <th>Payment Status</th>
                    <th>Booking Date</th>
                </tr>
            </thead>
            <tbody>
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
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="6" class="center-align red-text">No bookings found.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
