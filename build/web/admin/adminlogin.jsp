<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f8;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            width: 360px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        .login-header {
            background-color: #1976d2;
            padding: 20px;
            border-radius: 12px 12px 0 0;
            text-align: center;
        }

        .login-header h2 {
            color: white;
            font-size: 22px;
        }

        .form-group {
            margin: 20px 0 15px;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }

        input {
            width: 100%;
            padding: 10px 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #f9f9f9;
        }

        input:focus {
            border-color: #1976d2;
            outline: none;
            background-color: #fff;
        }

        .submit-btn {
            width: 100%;
            background-color: #1976d2;
            color: white;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 10px;
        }

        .submit-btn:hover {
            background-color: #125ea3;
        }

        .forgot-link {
            text-align: center;
            margin-top: 14px;
        }

        .forgot-link a {
            text-decoration: none;
            font-size: 14px;
            color: #1976d2;
        }

        .forgot-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="login-header">
        <h2>Admin Login</h2>
    </div>
    <form action="AdminLoginServlet" method="post">
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" name="email" id="email" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" name="password" id="password" required>
        </div>
        <button type="submit" class="submit-btn">Sign In</button>
        <div class="forgot-link">
            <a href="#">Forgot Password?</a>
        </div>
    </form>
</div>

</body>
</html>
