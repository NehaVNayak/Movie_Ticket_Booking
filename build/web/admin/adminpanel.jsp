<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Dummy admin object (for testing only)
    class Admin {
        String getName() { return "AdminUser"; }
    }

    Admin admin = new Admin(); // Replace this line with: (Admin) session.getAttribute("loggedAdmin");

    // Dummy data
    int totalUsers = 20;
    int totalBookings = 340;
    double totalRevenue = 2450.75;
    int registrationsToday = 2;
    String monthLabels = "[\"Jan\", \"Feb\", \"Mar\", \"Apr\", \"May\"]";
    String monthlyBookingCounts = "[30, 50, 40, 60, 80]";

    class LogEntry {
        private Date timestamp;
        private String user;
        private String action;
        public LogEntry(Date timestamp, String user, String action) {
            this.timestamp = timestamp;
            this.user = user;
            this.action = action;
        }
        public Date getTimestamp() { return timestamp; }
        public String getUser() { return user; }
        public String getAction() { return action; }
    }

    List<LogEntry> logs = new ArrayList<>();
    logs.add(new LogEntry(new Date(), "admin1", "Logged in"));
    logs.add(new LogEntry(new Date(), "user23", "Booked 'Inception'"));
    logs.add(new LogEntry(new Date(), "admin1", "Upadted movie'"));
    logs.add(new LogEntry(new Date(), "user99", "Cancelled a booking"));
    logs.add(new LogEntry(new Date(), "admin2", "Viewed daily report"));

    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* CSS STYLES */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', sans-serif; background-color: #f2f4f8; }
        nav {
            background-color: #1565c0; padding: 15px 30px;
            display: flex; justify-content: space-between; align-items: center; color: white;
        }
        nav .brand-logo { font-size: 20px; font-weight: bold; }
        nav ul { list-style: none; display: flex; align-items: center; }
        nav ul li { margin-left: 20px; }
        nav ul li a { color: white; text-decoration: none; font-weight: 500; }

        .container { max-width: 1000px; margin: 40px auto; padding: 20px; }
        .admin-card {
            background-color: #ffffff; padding: 30px;
            border-radius: 12px; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
        }
        .admin-card .card-title { font-size: 22px; color: #333; margin-bottom: 10px; }
        .admin-card p { color: #666; font-size: 16px; }

        .card-action { margin-top: 20px; display: flex; flex-wrap: wrap; gap: 15px; }
        .card-action a {
            padding: 12px 20px; border-radius: 8px;
            text-decoration: none; font-weight: 600;
            display: inline-flex; align-items: center; gap: 8px; color: #fff;
        }
        .btn { font-size: 15px; }
        .btn.blue { background-color: #1e88e5; }
        .btn.green { background-color: #43a047; }
        .btn.red { background-color: #e53935; }
        .btn:hover { opacity: 0.9; }

        .dashboard-metrics {
            display: grid; grid-template-columns: repeat(4, 1fr);
            gap: 15px; margin: 30px 0;
        }
        .metric {
            background: #ffffff; padding: 20px; border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            text-align: center;
        }
        .metric h3 { margin-bottom: 10px; color: #555; }
        .metric p { font-size: 20px; font-weight: bold; color: #222; }

        .chart-container {
            background: #fff; padding: 25px; border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin: 30px 0;
        }

        .logs {
            background: #fff; padding: 25px; border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        .logs table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        .logs th, .logs td { padding: 10px; border: 1px solid #ccc; text-align: left; }
        .logs th { background: #1565c0; color: white; }
    </style>
</head>
<body>

<nav>
    <div class="brand-logo">Admin Panel</div>
    <ul>
        <li>
            <a href="adminlogin.jsp">
                <span class="material-icons">exit_to_app</span> Logout
            </a>
        </li>
    </ul>
</nav>

<div class="container">

    <div class="admin-card">
        <div class="card-content">
            <h2 class="card-title">Welcome, <%= admin.getName() %>!</h2>
            <p>Manage the movie booking system.</p>
        </div>
        <div class="card-action">
            <a href="ManageMoviesServlet" class="btn blue">
                <span class="material-icons">movie</span> Manage Movies
            </a>
            <a href="ManageUsersServlet" class="btn green">
                <span class="material-icons">group</span> Manage Users
            </a>
        </div>
    </div>

    <!-- Metrics -->
    <div class="dashboard-metrics">
        <div class="metric"><h3>Total Users</h3><p><%= totalUsers %></p></div>
        <div class="metric"><h3>Total Bookings</h3><p><%= totalBookings %></p></div>
        <div class="metric"><h3>Total Revenue</h3><p>$<%= totalRevenue %></p></div>
        <div class="metric"><h3>Registrations Today</h3><p><%= registrationsToday %></p></div>
    </div>

    <!-- Chart -->
    <div class="chart-container">
        <h3>Monthly Bookings</h3>
        <canvas id="bookingChart" height="100"></canvas>
    </div>

    <!-- Logs -->
    <div class="logs">
        <h3>Recent Activity Logs</h3>
        <table>
            <tr><th>Timestamp</th><th>User</th><th>Action</th></tr>
            <%
                for (LogEntry log : logs) {
            %>
                <tr>
                    <td><%= sdf.format(log.getTimestamp()) %></td>
                    <td><%= log.getUser() %></td>
                    <td><%= log.getAction() %></td>
                </tr>
            <%
                }
            %>
        </table>
    </div>
</div>

<script>
    const ctx = document.getElementById('bookingChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: <%= monthLabels %>,
            datasets: [{
                label: 'Bookings per Month',
                data: <%= monthlyBookingCounts %>,
                backgroundColor: '#1e88e5'
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
</script>

</body>
</html>
