<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f7f9fc;
            font-family: 'Poppins', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .login-card {
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.06);
            width: 100%;
            max-width: 400px;
            padding: 30px 40px;
        }

        .login-card h2 {
            text-align: center;
            color: #111827;
            margin-bottom: 24px;
            font-size: 24px;
        }

        .input-field {
            margin-bottom: 20px;
        }

        .input-field label {
            display: block;
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 6px;
        }

        .input-field input {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
            background-color: #f9fafb;
            font-size: 15px;
            outline: none;
            transition: border 0.3s ease;
        }

        .input-field input:focus {
            border-color: #2563eb;
            background-color: #fff;
        }

        .btn-submit {
            width: 100%;
            background-color: #2563eb;
            color: #fff;
            border: none;
            padding: 14px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #1d4ed8;
        }

        .footer-links {
            display: flex;
            justify-content: space-between;
            margin-top: 16px;
        }

        .footer-links a {
            color: #3b82f6;
            text-decoration: none;
            font-size: 14px;
        }

        .footer-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-card">
    <h2>Login</h2>
    <form action="UserLoginServlet" method="post">
        <div class="input-field">
            <label for="email">Email</label>
            <input type="email" name="email" id="email" required>
        </div>
        <div class="input-field">
            <label for="password">Password</label>
            <input type="password" name="password" id="password" required>
        </div>
        <button type="submit" class="btn-submit">Login</button>
        <div class="footer-links">
            <a href="#">Forgot Password?</a>
            <a href="register.jsp">New Registration</a>
        </div>
    </form>
</div>

</body>
</html>
