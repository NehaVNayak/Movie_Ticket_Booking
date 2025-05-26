<!DOCTYPE html>
<html>
<head>
    <title>Select Movie & Showtime</title>
    <meta charset="UTF-8">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
        }

        .container {
            max-width: 960px;
            margin: 40px auto;
            padding: 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        h4, h5 {
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
        }

        h4 {
            font-size: 32px;
            color: #007BFF;
            letter-spacing: 1px;
            border-bottom: 3px solid #007BFF;
            padding-bottom: 10px;
            margin-bottom: 40px;
        }

        h5 {
            font-size: 32px; /* Increased font size */
            color: #007BFF;  /* Matching color to movie section heading */
            letter-spacing: 1px; /* Similar to h4 style */
            border-bottom: 3px solid #007BFF; /* Border to match styling */
            padding-bottom: 10px; /* Padding for alignment */
            margin-top: 40px; /* Space before the section */
        }

        .poster-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .poster-img {
            width: 160px;
            height: 240px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            cursor: pointer;
            transition: transform 0.2s, border 0.2s;
        }

        .poster-img:hover {
            transform: scale(1.05);
        }

        .selected {
            border: 4px solid #007BFF;
        }

        .radio-group {
            text-align: center;
            margin-top: 30px;
        }

        .radio-group label {
            margin: 0 15px;
            font-size: 16px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .radio-group input[type="radio"] {
            accent-color: #007BFF;
            transform: scale(1.2);
        }

        .center-align {
            text-align: center;
        }

        button {
            padding: 10px 25px;
            background-color: #007BFF;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s;
        }

        button:hover {
            background-color: #0056b3;
        }

        @media screen and (max-width: 768px) {
            .poster-img {
                width: 120px;
                height: 180px;
            }

            .radio-group label {
                display: block;
                margin: 10px 0;
            }
        }
    </style>

    <script>
        function selectMovie(movieID) {
            document.getElementById("selectedMovieID").value = movieID;
            let posters = document.querySelectorAll(".poster-img");
            posters.forEach(poster => poster.classList.remove("selected"));
            document.getElementById("poster-" + movieID).classList.add("selected");
        }

        function validateSelection() {
            let selectedMovie = document.getElementById("selectedMovieID").value;
            let selectedShowtime = document.querySelector('input[name="showtime"]:checked');
            if (!selectedMovie) {
                alert("Please select a movie.");
                return false;
            }
            if (!selectedShowtime) {
                alert("Please select a showtime.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <form action="selectseats.jsp" method="POST" onsubmit="return validateSelection()">
            <h4>Select Your Movie</h4>

            <!-- Movie Posters -->
            <div class="poster-container">
                <img src="./image/inception.jpeg" id="poster-1" class="poster-img" onclick="selectMovie('1')">
                <img src="./image/dark_knight.jpeg" id="poster-3" class="poster-img" onclick="selectMovie('3')">
                <img src="./image/3idiots.jpeg" id="poster-4" class="poster-img" onclick="selectMovie('4')">
                <img src="./image/ddlj.jpeg" id="poster-5" class="poster-img" onclick="selectMovie('5')">
                <img src="./image/znmd.jpeg" id="poster-6" class="poster-img" onclick="selectMovie('6')">
                <img src="./image/sholay.jpeg" id="poster-7" class="poster-img" onclick="selectMovie('7')">
                <img src="./image/bajrangi.jpeg" id="poster-9" class="poster-img" onclick="selectMovie('9')">
            </div>

            <!-- Showtime Selection -->
            <h5>Select Showtime</h5>
            <input type="hidden" name="movieID" id="selectedMovieID">

            <div class="radio-group">
                <label><input name="showtime" type="radio" value="Morning"> Morning</label>
                <label><input name="showtime" type="radio" value="Afternoon"> Afternoon</label>
                <label><input name="showtime" type="radio" value="Evening"> Evening</label>
                <label><input name="showtime" type="radio" value="Night"> Night</label>
            </div>

            <!-- Proceed Button -->
            <div class="center-align" style="margin-top: 30px;">
                <button type="submit">Proceed ?</button>
            </div>
        </form>
    </div>
</body>
</html>
