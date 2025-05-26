<%@page import="java.util.List"%>
<%@page import="movieBooking.admin.model.Movie"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Movies</title>
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

        /* Table Styles */
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

        .movie-poster {
            width: 80px;
            height: auto;
            border-radius: 5px;
        }

        .table-actions {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn-small {
            width: auto;
            background-color: #388e3c;
            color: white;
        }
        
        h5.green-text.text-darken-2 {
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            color: #388e3c; /* Green */
            background-color: #f1f8e9; /* Light green background */
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            letter-spacing: 1px;
        }
        
        
    </style>
</head>
<body>
    <nav class="blue darken-3">
        <div class="nav-wrapper">
            <a href="#" class="brand-logo center">Manage Movies</a>
        </div>
    </nav>
    
    <div class="container">
        <!-- Buttons to Show Form or View/Delete -->
        <button class="btn blue" id="addMovieBtn">Add Movie</button>
        <a href="ManageMoviesServlet?action=view" class="btn green">View & Delete Movies</a>

        <!-- Add Movie Form (Initially Hidden) -->
        <div class="card" id="addMovieForm" style="display: none;">
            <div class="card-title">Add a New Movie</div>
            <form action="ManageMoviesServlet" method="POST" class="col s12">
                <input type="hidden" name="action" value="add">
                <div class="input-field"><input type="text" name="name" required><label for="name">Name</label></div>
                <div class="input-field"><input type="text" name="director" required><label for="director">Director</label></div>
                <div class="input-field"><input type="text" name="releaseDate" required><label for="releasing_date">Releasing Date</label></div>
                <div class="input-field"><input type="text" name="casts" required><label for="casts">Casts</label></div>
                <div class="input-field"><input type="text" name="description" required><label for="description">Description</label></div>
                <div class="input-field"><input type="text" name="poster" required><label for="poster">Poster URL</label></div>
                <div class="input-field"><input type="text" name="duration" required><label for="duration">Duration</label></div>
                <div class="input-field"><input type="text" name="trailer" required><label for="trailer">Trailer URL</label></div>
                <div class="input-field"><input type="text" name="category" required><label for="category">Category</label></div>
                <button type="submit" class="btn blue">Submit</button>
            </form>
        </div>
    </div>
    
    <!-- Movie List Table -->
    <div id="movieTable" <% if (request.getAttribute("movies") == null) { %> style="display: none;" <% } %>>
        <h5 class="green-text text-darken-2">Movie List</h5>
        <table class="highlight responsive-table">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Director</th>
                    <th>Releasing Date</th>
                    <th>Casts</th>
                    <th>Description</th>
                    <th>Poster</th>
                    <th>Duration</th>
                    <th>Trailer</th>
                    <th>Category</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="movieList">
                <% List<Movie> movies = (List<Movie>) request.getAttribute("movies");
                   if (movies != null && !movies.isEmpty()) {
                       for (Movie movie : movies) { %>
                <tr>
                    <td><%= movie.getName() %></td>
                    <td><%= movie.getDirector() %></td>
                    <td><%= movie.getReleaseDate() %></td>
                    <td><%= movie.getCasts() %></td>
                    <td><%= movie.getDescription() %></td>
                    <td><img src="<%= request.getContextPath() %>/image/<%= movie.getPoster() %>" alt="Poster" class="movie-poster"></td>
                    <td><%= movie.getDuration() %></td>
                    <td><a href="<%= movie.getTrailer() %>" target="_blank" class="btn-small">Watch</a></td>
                    <td><%= movie.getCategory() %></td>
                    <td class="table-actions">
                        <form action="ManageMoviesServlet" method="POST">
                            <input type="hidden" name="id" value="<%= movie.getId() %>">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit" class="btn-small red" onclick="return confirm('Are you sure you want to delete this movie?');">Delete</button>
                        </form>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="10" class="center">No movies available.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script>
        document.getElementById("addMovieBtn").addEventListener("click", function() {
            document.getElementById("addMovieForm").style.display = "block";
        });
    </script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>
</html>
