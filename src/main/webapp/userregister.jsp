<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register - Bus Ticketing System</title>
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
      max-width: 600px;
      margin: 50px auto;
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

    input[type="text"], input[type="password"], select {
      width: 100%;
      padding: 12px;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 16px;
    }

    select {
      background-color: #f9f9f9;
    }

    select:disabled {
      background-color: #e9e9e9;
      color: #666;
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

    .login-link {
      text-align: center;
      margin-top: 20px;
    }

    .login-link a {
      color: #0056b3;
      text-decoration: none;
    }

    .login-link a:hover {
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
  <%
    Boolean success = (Boolean) request.getAttribute("success");
  %>
  <script>
    window.onload = function () {
      <% if (success != null && success) { %>
      alert("Registered successfully!");
      <% } %>
    };
  </script>
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
    <a href="home">Home</a> <a href="register"
                                    style="background-color: rgba(255, 255, 255, 0.1);">Register</a> <a
          href="login">Login</a>
  </div>
</nav>

<div class="container">
  <h2>Create Your Account</h2>

  <form action="<%=request.getContextPath()%>/register" method="post">
    <div class="form-group">
      <label for="first_name">First Name</label> <input type="text"
                                                        id="first_name" name="first_name" required>
    </div>

    <div class="form-group">
      <label for="last_name">Last Name</label> <input type="text"
                                                      id="last_name" name="last_name" required>
    </div>

    <div class="form-group">
      <label for="username">Username</label> <input type="text"
                                                    id="username" name="username" required>
    </div>

    <div class="form-group">
      <label for="password">Password</label> <input type="password"
                                                    id="password" name="password" required>
    </div>

    <div class="form-group">
      <label for="role">Role</label> <select id="role" name="role">
      <option value="passenger">Passenger</option>
<%--      <option value="admin">Admin</option>--%>
    </select>
    </div>

    <div class="form-group">
      <label for="category">Category</label> <select id="category"
                                                     name="category">
      <option value="regular">Regular</option>
      <option value="student">Student</option>
      <option value="senior">Senior</option>
    </select>
    </div>

    <input type="submit" value="Register Now" class="btn">
  </form>

  <div class="login-link">
    <p>
      Already have an account? <a href="login">Login here</a>
    </p>
  </div>

  <%
    if (request.getParameter("error") != null) {
  %>
  <div class="error-message">
    <%
      if ("registration_failed".equals(request.getParameter("error"))) {
    %>
    Registration failed. Please try again.
    <%
    } else if ("database_error".equals(request.getParameter("error"))) {
    %>
    Database error occurred. Contact support.
    <%
      }
    %>
  </div>
  <%
    }
  %>
</div>

<!-- Footer -->
<footer>
  <p>&copy; 2025 BusTickets. All rights reserved.</p>
</footer>
</body>

</html>