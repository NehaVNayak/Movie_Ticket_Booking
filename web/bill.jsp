<%@ page import="java.util.*" %>
<%
    String movieID = request.getAttribute("movieID").toString();
    String showtime = request.getAttribute("showtime").toString();
    List<String> seats = (List<String>) request.getAttribute("seats");
    double total = (double) request.getAttribute("total");
%>

<h2>Booking Bill</h2>
<p><strong>Movie ID:</strong> <%= movieID %></p>
<p><strong>Showtime:</strong> <%= showtime %></p>
<p><strong>Seats Booked:</strong><br/>
    <ul>
        <% for(String seat : seats) { %>
            <li><%= seat %></li>
        <% } %>
    </ul>
</p>
<p><strong>Total Amount:</strong> ?<%= String.format("%.2f", total) %></p>
