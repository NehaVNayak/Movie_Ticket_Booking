<%@page import="movieBooking.admin.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    User user = (User) session.getAttribute("loggedAdmin"); 
    if (user == null) { 
        response.sendRedirect("userlogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Panel</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f7f9fc;
            font-family: 'Poppins', sans-serif;
        }

        nav {
            background-color: #2563eb;
            padding: 0 20px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            color: white;
        }

        .brand-logo {
            font-size: 20px;
            font-weight: 600;
            color: white;
            text-decoration: none;
        }

        nav ul {
            list-style: none;
            display: flex;
            margin: 0;
            padding: 0;
        }

        nav ul li {
            margin-left: 20px;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-size: 14px;
            display: flex;
            align-items: center;
        }

        .container {
            max-width: 800px;
            margin: 60px auto;
            padding: 0 20px;
        }

        .admin-card {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.06);
            text-align: center;
        }

        .card-title {
            font-size: 24px;
            font-weight: 600;
            color: #111827;
            margin-bottom: 10px;
        }

        .card-content p {
            color: #6b7280;
            font-size: 15px;
            margin-bottom: 30px;
        }

        .btn-custom {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 14px 20px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 8px;
            border: none;
            color: white;
            margin: 10px 0;
            cursor: pointer;
            text-decoration: none;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .btn-custom i {
            font-size: 20px;
        }

        .btn-blue { background-color: #2563eb; }
        .btn-blue:hover { background-color: #1e40af; }

        .btn-green { background-color: #10b981; }
        .btn-green:hover { background-color: #059669; }

        .btn-purple { background-color: #7c3aed; }
        .btn-purple:hover { background-color: #5b21b6; }

        .btn-red { background-color: #ef4444; }
        .btn-red:hover { background-color: #dc2626; }

        .btn-custom:hover {
            transform: scale(1.04);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }
    </style>
</head>
<body>

    <nav>
        <a href="#" class="brand-logo">User Panel</a>
        <ul>
            <li><a href="userlogin.jsp"><i class="material-icons">exit_to_app</i>&nbsp;Logout</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="admin-card">
            <div class="card-content">
                <div class="card-title">Welcome, <%= user.getName() %>!</div>
                <p>Start booking some amazing movies 😍</p>
            </div>
            <div class="card-action">
                <a href="ViewMoviesServlet" class="btn-custom btn-blue"><i class="material-icons">movie</i>View Movies</a>
                <a href="selectMovie.jsp" class="btn-custom btn-green"><i class="material-icons">group</i>Movie Selection and Booking</a>
                <a href="ViewBookingsServlet" class="btn-custom btn-purple"><i class="material-icons">event</i>View Booking History</a>
                <a href="ViewCancelServlet" class="btn-custom btn-red"><i class="material-icons">cancel</i>Cancel Booking</a>
            </div>
        </div>
    </div>

</body>
</html>
