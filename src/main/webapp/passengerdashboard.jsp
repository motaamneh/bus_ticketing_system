<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Passenger Dashboard - Bus Ticketing System</title>
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

    .user-info {
      color: white;
      display: flex;
      align-items: center;
    }

    .user-info span {
      margin-right: 15px;
    }

    .logout-btn {
      background-color: rgba(255, 255, 255, 0.2);
      color: white;
      border: none;
      padding: 8px 15px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 14px;
      transition: background-color 0.3s;
    }

    .logout-btn:hover {
      background-color: rgba(255, 255, 255, 0.3);
    }

    .container {
      max-width: 1200px;
      margin: 30px auto;
      padding: 0 20px;
    }

    .welcome-message {
      background-color: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      margin-bottom: 30px;
    }

    .welcome-message h1 {
      color: #0056b3;
      margin-bottom: 15px;
    }

    .dashboard-cards {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 20px;
    }

    .card {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      padding: 25px;
      transition: transform 0.3s;
    }

    .card:hover {
      transform: translateY(-5px);
    }

    .card-icon {
      font-size: 36px;
      color: #0056b3;
      margin-bottom: 15px;
    }

    .card h3 {
      color: #333;
      margin-bottom: 15px;
    }

    .card p {
      color: #666;
      margin-bottom: 20px;
    }

    .card-btn {
      background-color: #ff6b00;
      color: white;
      padding: 10px 15px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 14px;
      transition: background-color 0.3s;
      text-decoration: none;
      display: inline-block;
    }

    .card-btn:hover {
      background-color: #e05d00;
    }

    .activity-section {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      padding: 25px;
      margin-top: 30px;
    }

    .activity-section h2 {
      color: #0056b3;
      margin-bottom: 20px;
    }

    .activity-list {
      list-style: none;
    }

    .activity-item {
      padding: 15px 0;
      border-bottom: 1px solid #eee;
      display: flex;
      align-items: center;
    }

    .activity-icon {
      width: 40px;
      height: 40px;
      background-color: #e9f2ff;
      color: #0056b3;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 15px;
      font-size: 20px;
    }

    .activity-details {
      flex: 1;
    }

    .activity-title {
      font-weight: bold;
      margin-bottom: 5px;
    }

    .activity-time {
      color: #999;
      font-size: 14px;
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
<%
  // Check if user is logged in and is not an admin
  if (session.getAttribute("username") == null) {
    response.sendRedirect(request.getContextPath() + "/userlogin.jsp");
  } else if ("admin".equals(session.getAttribute("role"))) {
    response.sendRedirect(request.getContextPath() + "/admindashboard.jsp");
  }
%>

<!-- Navigation Bar -->
<nav class="navbar">
  <div class="logo-container">
    <div class="logo">
      <span class="logo-icon">B</span>
    </div>
    <span class="brand-name">BusTickets</span>
  </div>

  <div class="user-info">
    <span>Welcome, <%= session.getAttribute("username") %></span>
    <form action="<%= request.getContextPath() %>/logout" method="post">
      <button type="submit" class="logout-btn">Logout</button>
    </form>
  </div>
</nav>

<div class="container">
  <div class="welcome-message">
    <h1>Passenger Dashboard</h1>
    <p>Welcome back to your BusTickets account. Search for trips, book tickets, and manage your journey all in one place.</p>
  </div>

  <div class="dashboard-cards">
    <div class="card">
      <div class="card-icon">🔍</div>
      <h3>Search Trips</h3>
      <p>Find available bus trips by entering your destination and travel date.</p>
      <a href="<%= request.getContextPath() %>/search-trips" class="card-btn">Search Now</a>
    </div>

    <div class="card">
      <div class="card-icon">💰</div>
      <h3>Calculate Fare</h3>
      <p>Check fare prices for different routes and passenger categories.</p>
      <a href="<%= request.getContextPath() %>/calculate-fare" class="card-btn">Calculate</a>
    </div>

    <div class="card">
      <div class="card-icon">🎫</div>
      <h3>Purchase Tickets</h3>
      <p>Buy tickets for your selected trips securely and instantly.</p>
      <a href="<%= request.getContextPath() %>/buy-tickets" class="card-btn">Buy Tickets</a>
    </div>

    <div class="card">
      <div class="card-icon">📋</div>
      <h3>My Bookings</h3>
      <p>View and manage your current and past ticket bookings.</p>
      <a href="<%= request.getContextPath() %>/my-bookings" class="card-btn">View Bookings</a>
    </div>
  </div>

  <div class="activity-section">
    <h2>Recent Activities</h2>
    <ul class="activity-list">
      <li class="activity-item">
        <div class="activity-icon">🔍</div>
        <div class="activity-details">
          <div class="activity-title">Searched for trip to Boston</div>
          <div class="activity-time">Today, 10:30 AM</div>
        </div>
      </li>
      <li class="activity-item">
        <div class="activity-icon">🎫</div>
        <div class="activity-details">
          <div class="activity-title">Purchased ticket #BT-5872</div>
          <div class="activity-time">Yesterday, 3:45 PM</div>
        </div>
      </li>
      <li class="activity-item">
        <div class="activity-icon">💰</div>
        <div class="activity-details">
          <div class="activity-title">Calculated fare for NYC to Washington</div>
          <div class="activity-time">Apr 22, 2025, 11:20 AM</div>
        </div>
      </li>
    </ul>
  </div>
</div>

<!-- Footer -->
<footer>
  <p>&copy; 2025 BusTickets. All rights reserved.</p>
</footer>
</body>
</html>