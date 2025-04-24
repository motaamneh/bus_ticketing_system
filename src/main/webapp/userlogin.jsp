<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Bus Ticketing System</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Arial', sans-serif;
    }

    body {
      background-color: #f4f4f4;
    }

    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #0056b3;
      padding: 15px 30px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .logo-container {
      display: flex;
      align-items: center;
    }

    .logo {
      width: 40px;
      height: 40px;
      margin-right: 10px;
      background-color: #fff;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .logo-icon {
      color: #0056b3;
      font-size: 24px;
      font-weight: bold;
    }

    .brand-name {
      color: white;
      font-size: 24px;
      font-weight: bold;
    }

    .nav-links {
      display: flex;
      gap: 20px;
    }

    .nav-links a {
      color: white;
      text-decoration: none;
      font-size: 16px;
      padding: 8px 15px;
      transition: background-color 0.3s;
      border-radius: 5px;
    }

    .nav-links a:hover {
      background-color: rgba(255, 255, 255, 0.1);
    }

    .container {
      max-width: 500px;
      margin: 80px auto;
      background-color: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    h2 {
      color: #0056b3;
      text-align: center;
      margin-bottom: 30px;
      font-size: 28px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    label {
      display: block;
      margin-bottom: 8px;
      color: #333;
      font-weight: bold;
    }

    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 12px;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 16px;
    }

    .btn {
      background-color: #ff6b00;
      color: white;
      padding: 12px 24px;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s;
      width: 100%;
      margin-top: 10px;
    }

    .btn:hover {
      background-color: #e05d00;
    }

    .register-link {
      text-align: center;
      margin-top: 20px;
    }

    .register-link a {
      color: #0056b3;
      text-decoration: none;
    }

    .register-link a:hover {
      text-decoration: underline;
    }

    .error-message {
      color: #e74c3c;
      background-color: #fde2e2;
      padding: 12px;
      border-radius: 5px;
      margin-top: 20px;
      text-align: center;
    }

    footer {
      background-color: #333;
      color: white;
      text-align: center;
      padding: 20px;
      margin-top: 30px;
    }
  </style>
</head>

<body>
<!-- Navigation Bar -->
<nav class="navbar">
  <div class="logo-container">
    <div class="logo">
      <span class="logo-icon">B</span>
    </div>
    <span class="brand-name">BusTickets</span>
  </div>

  <div class="nav-links">
    <a href="home">Home</a>
    <a href="register">Register</a>
    <a href="login" style="background-color: rgba(255, 255, 255, 0.1);">Login</a>
  </div>
</nav>

<div class="container">
  <h2>Login to Your Account</h2>

  <form action="<%= request.getContextPath() %>/login" method="post">
    <div class="form-group">
      <label for="username">Username</label>
      <input type="text" id="username" name="username" required>
    </div>

    <div class="form-group">
      <label for="password">Password</label>
      <input type="password" id="password" name="password" required>
    </div>

    <input type="submit" value="Login" class="btn">
  </form>

  <div class="register-link">
    <p>Don't have an account? <a href="register">Register here</a></p>
  </div>

  <% if (request.getParameter("error") != null) { %>
  <div class="error-message">
    Invalid username or password. Please try again.
  </div>
  <% } %>
</div>

<!-- Footer -->
<footer>
  <p>&copy; 2025 BusTickets. All rights reserved.</p>
</footer>
</body>
</html>