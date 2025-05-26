<%@ page import="movieBooking.admin.model.Movie" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Movie List</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
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
            margin-bottom: 20px;
        }

        th {
            background-color: #0366d6;
            color: white;
            padding: 12px;
            text-align: left;
        }

        td {
            background-color: #f9f9f9;
            padding: 12px;
            vertical-align: top;
        }

        tr:hover td {
            background-color: #eef3fb;
        }

        .movie-poster {
            width: 70px;
            height: auto;
            border-radius: 4px;
        }

        .btn-small {
            display: inline-block;
            padding: 6px 12px;
            background-color: #0366d6;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
        }

        .btn-small:hover {
            background-color: #024eaa;
        }

        .center {
            text-align: center;
            font-weight: bold;
            color: #888;
        }

        @media screen and (max-width: 768px) {
            th, td {
                font-size: 14px;
                padding: 8px;
            }

            .movie-poster {
                width: 50px;
            }
            
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Available Movies</h2>
        <div id="movieTable" <% if (request.getAttribute("movies") == null) { %> style="display: none;" <% } %>>
            <table>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Director</th>
                        <th>Release Date</th>
                        <th>Casts</th>
                        <th>Description</th>
                        <th>Poster</th>
                        <th>Duration</th>
                        <th>Trailer</th>
                        <th>Category</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Movie> movies = (List<Movie>) request.getAttribute("movies");
                        if (movies != null && !movies.isEmpty()) {
                            for (Movie movie : movies) {
                    %>
                    <tr>
                        <td><%= movie.getName() %></td>
                        <td><%= movie.getDirector() %></td>
                        <td><%= movie.getReleaseDate() %></td>
                        <td><%= movie.getCasts() %></td>
                        <td><%= movie.getDescription() %></td>
                        <td><img src="<%= request.getContextPath() %>/image/<%= movie.getPoster() %>" class="movie-poster" alt="Poster"></td>
                        <td><%= movie.getDuration() %></td>
                        <td><a href="<%= movie.getTrailer() %>" target="_blank" class="btn-small">Watch</a></td>
                        <td><%= movie.getCategory() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="9" class="center">No movies available.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
