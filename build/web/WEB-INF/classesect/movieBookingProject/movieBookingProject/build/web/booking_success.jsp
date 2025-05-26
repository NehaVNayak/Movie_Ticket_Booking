<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Successful</title>
    <style>
        body {
            font-family: Arial;
            background-color: #f0fff0;
            padding: 0;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        .success-box {
            padding: 40px;
            border-radius: 10px;
            border: 2px solid #28a745;
            background-color: #e6ffe6;
            box-shadow: 0 0 10px #b2ffb2;
        }
        h2 {
            color: #28a745;
        }
        p {
            font-size: 18px;
        }
        a {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 20px;
            background: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        a:hover {
            background: #218838;
        }
    </style>
</head>
<body>

<div class="success-box">
    <h2>Booking Confirmed!</h2>
    <p>Your payment was successful and your seats are booked.</p>
    <a href="userpanel.jsp">Back to Home</a>
</div>

</body>
</html>
