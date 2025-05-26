<%@ page import="java.util.List, movieBooking.admin.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Users</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <style>
        body {
            background-color: #eceff1;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 1200px;
            margin: 50px auto;
        }
        .card {
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .card-title {
            background-color: #1976d2;
            color: white;
            text-align: center;
            padding: 10px;
            font-size: 20px;
            border-radius: 5px 5px 0 0;
        }
        .btn {
            width: 100%;
            margin-top: 15px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #388e3c;
            color: white;
            font-weight: bold;
        }
        td {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .table-actions {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
    </style>
</head>
<body>
    <nav class="blue darken-3">
        <div class="nav-wrapper">
            <a href="#" class="brand-logo center">Manage Users</a>
        </div>
    </nav>
    
    <div class="container">
        <button class="btn blue" id="addUserBtn">Add User</button>
        
        <div class="card" id="addUserForm" style="display: none;">
            <div class="card-title">Add a New User</div>
            <form action="ManageUsersServlet" method="POST">
                <input type="hidden" name="action" value="add">
                <div class="input-field"><input type="text" name="name" required><label for="name">Name</label></div>
                <div class="input-field"><input type="email" name="email" required><label for="email">Email</label></div>
                <div class="input-field"><input type="password" name="password" required><label for="password">Password</label></div>
                <div class="input-field"><input type="text" name="dob" required><label for="dob">Date of Birth</label></div>
                <div class="input-field"><input type="text" name="gender" required><label for="gender">Gender</label></div>
                <button type="submit" class="btn blue">Submit</button>
            </form>
        </div>
    </div>
    
    <div class="container">
        <h5 class="green-text text-darken-2">User List</h5>
        <table class="highlight responsive-table">
            <thead>
                <tr>
                    <th>Password</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Gender</th>
                    <th>DOB</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% List<User> users = (List<User>) request.getAttribute("users");
                   if (users != null && !users.isEmpty()) {
                       for (User user : users) { %>
                <tr>
                    <td><%= user.getName() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getPassword() %></td>
                    <td><%= user.getDob() %></td>
                    <td><%= user.getGender() %></td>
                    <td class="table-actions">
                        
                        <form action="ManageUsersServlet" method="POST">
                            <input type="hidden" name="id" value="<%= user.getId() %>">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit" class="btn-small red" onclick="return confirm('Are you sure you want to delete this user?');">Delete</button>
                        </form>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="6" class="center">No users available.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script>
        document.getElementById("addUserBtn").addEventListener("click", function() {
            document.getElementById("addUserForm").style.display = "block";
        });
    </script>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>
</html>


