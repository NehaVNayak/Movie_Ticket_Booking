<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Failed</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fbeaea;
            text-align: center;
            padding: 50px;
        }
        .container {
            background-color: #fff0f0;
            border: 1px solid #ff4d4d;
            border-radius: 10px;
            padding: 40px;
            display: inline-block;
            box-shadow: 0 0 10px #ffcccc;
        }
        h2 {
            color: #cc0000;
        }
        p {
            font-size: 16px;
            color: #333;
        }
        a {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            background-color: #ff4d4d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        a:hover {
            background-color: #e60000;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Booking Failed</h2>
        <p>Unfortunately, your seat booking could not be completed.</p>

        <%
            String error = request.getParameter("error");
            if (error != null) {
                if (error.equals("seat_unavailable")) {
        %>
            <p style="color:darkred;">One or more selected seats were already booked. Please choose different seats.</p>
        <%
                } else if (error.equals("seat_not_found")) {
        %>
            <p style="color:darkred;">Selected seat not found. Please try again.</p>
        <%
                } else if (error.equals("exception")) {
        %>
            <p style="color:darkred;">A server error occurred while processing your request.</p>
        <%
                }
            }
        %>

        <a href="javascript:history.back()">Try Again</a>
        <a href="index.jsp">Go to Home</a>
    </div>
</body>
</html>
