<%@ page import="java.sql.*, java.util.*, movieBooking.connection.ConnectionDB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Summary</title>
    <style>
        /* Global Styles */
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            background-color: #f7f9fc; /* Soft off-white background */
            color: #111827; /* Dark gray-black text */
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
        
        h3 {
            font-size: 32px; /* Increased font size */
            color: #007BFF; /* Matching color to movie section heading */
            letter-spacing: 1px; /* Similar to h4 style */
            padding-bottom: 10px; /* Padding for alignment */
            margin-top: 40px; /* Space before the section */
            text-align: center; /* Centers the text */
        }



        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 60%;
            background-color: #ffffff; /* Clean white table */
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 10px;
            border: 1px solid #e5e7eb; /* Light gray borders */
            text-align: center;
        }

        th {
            background-color: #f3f4f6; /* Light gray header background */
        }

        .pay-btn {
            margin-top: 30px;
            text-align: center;
        }

        .pay-btn a {
            background-color: #2563eb; /* Elegant royal blue */
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .pay-btn a:hover {
            background-color: #1d4ed8; /* Slightly deeper blue on hover */
        }

        .pay-btn a:focus {
            outline: 2px solid #3b82f6; /* Gentle blue outline for accessibility */
        }

        .total {
            font-size: 1.2rem;
            font-weight: bold;
            margin-top: 20px;
        }

        /* Footer Styling */
        footer {
            text-align: center;
            color: #6b7280; /* Muted gray for footer text */
            font-size: 0.9rem;
            margin-top: 50px;
        }
    </style>
</head>
<body>

<%
    // Use existing session without re-declaring it
    session = request.getSession(false);
    if (session == null) {
        out.println("<p style='color:red; text-align:center;'>Session expired. Please start booking again.</p>");
        return;
    }

    String[] selectedSeats = (String[]) session.getAttribute("selectedSeats");
    String showtime = (String) session.getAttribute("showtime");
    Integer movieID = (Integer) session.getAttribute("movieID");

    if (selectedSeats == null || selectedSeats.length == 0) {
        out.println("<p style='color:red; text-align:center;'>No seats selected!</p>");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    double total = 0;

    List<Map<String, String>> seatDetails = new ArrayList<>();

    try {
        conn = ConnectionDB.getCon();
        String sql = "SELECT SeatID, SeatNumber, SeatType FROM seats WHERE SeatID = ?";
        ps = conn.prepareStatement(sql);

        for (String seatIDStr : selectedSeats) {
            int seatID = Integer.parseInt(seatIDStr);
            ps.setInt(1, seatID);
            rs = ps.executeQuery();

            if (rs.next()) {
                String seatNum = rs.getString("SeatNumber");
                String seatType = rs.getString("SeatType");
                double cost = seatType.equalsIgnoreCase("Premium") ? 200.00 : 120.00;
                total += cost;

                Map<String, String> seatInfo = new HashMap<>();
                seatInfo.put("seatNumber", seatNum);
                seatInfo.put("seatType", seatType);
                seatInfo.put("cost", String.valueOf(cost));
                seatDetails.add(seatInfo);
            }
            rs.close();
        }
    } catch (Exception e) {
        out.println("<p style='color:red; text-align:center;'>Error calculating total.</p>");
        e.printStackTrace();
    } finally {
        try { if (ps != null) ps.close(); } catch (Exception ignored) {}
        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
    }
%>

<h2>Review Your Payment</h2>

<table>
    <tr>
        <th>Seat Number</th>
        <th>Seat Type</th>
        <th>Cost (₹)</th>
    </tr>
    <% for (Map<String, String> seat : seatDetails) { %>
        <tr>
            <td><%= seat.get("seatNumber") %></td>
            <td><%= seat.get("seatType") %></td>
            <td><%= seat.get("cost") %></td>
        </tr>
    <% } %>
</table>

<h3 class="total">Total Payment: ₹<%= total %></h3>

<div class="pay-btn">
    <a href="booking_success.jsp">Pay Now</a>
</div>



</body>
</html>
