<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard - Bus Ticketing System</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Arial', sans-serif;
    }

    body {
      background-color: #f4f4f4;
      display: flex;
      min-height: 100vh;
    }

    .sidebar {
      width: 250px;
      background-color: #0056b3;
      color: white;
      padding: 20px 0;
      height: 100vh;
      position: fixed;
    }

    .sidebar-header {
      display: flex;
      align-items: center;
      padding: 0 20px;
      margin-bottom: 30px;
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
      font-size: 20px;
      font-weight: bold;
    }

    .sidebar-menu {
      list-style: none;
    }

    .sidebar-menu li {
      margin-bottom: 5px;
    }

    .sidebar-menu a {
      display: block;
      padding: 12px 20px;
      color: white;
      text-decoration: none;
      transition: background-color 0.3s;
    }

    .sidebar-menu a:hover, .sidebar-menu a.active {
      background-color: rgba(255, 255, 255, 0.1);
      border-left: 4px solid #ff6b00;
    }

    .sidebar-menu a i {
      margin-right: 10px;
    }

    .admin-content {
      flex: 1;
      margin-left: 250px;
      padding: 20px;
    }

    .admin-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
      background-color: white;
      padding: 15px 20px;
      border-radius: 8px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .page-title h1 {
      color: #0056b3;
      font-size: 24px;
    }

    .admin-user-info {
      display: flex;
      align-items: center;
    }

    .admin-user-info span {
      margin-right: 15px;
    }

    .logout-btn {
      background-color: #ff6b00;
      color: white;
      border: none;
      padding: 8px 15px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 14px;
      transition: background-color 0.3s;
    }

    .logout-btn:hover {
      background-color: #e05d00;
    }

    .stats-container {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
    }

    .stat-card {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      padding: 20px;
      display: flex;
      flex-direction: column;
    }

    .stat-card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
    }

    .stat-card-title {
      color: #666;
      font-size: 16px;
    }

    .stat-card-icon {
      width: 40px;
      height: 40px;
      background-color: #e9f2ff;
      color: #0056b3;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
    }

    .stat-card-value {
      font-size: 28px;
      font-weight: bold;
      color: #333;
    }

    .stat-card-change {
      font-size: 14px;
      color: #28a745;
      margin-top: 5px;
    }

    .stat-card-change.negative {
      color: #dc3545;
    }

    .content-area {
      display: grid;
      grid-template-columns: 2fr 1fr;
      gap: 20px;
      margin-bottom: 30px;
    }

    @media screen and (max-width: 1024px) {
      .content-area {
        grid-template-columns: 1fr;
      }
    }

    .trip-management, .fare-management, .reports {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      padding: 20px;
      margin-bottom: 20px;
    }

    .section-title {
      color: #0056b3;
      margin-bottom: 20px;
      font-size: 18px;
      font-weight: bold;
      padding-bottom: 10px;
      border-bottom: 1px solid #eee;
    }

    .action-btn {
      background-color: #0056b3;
      color: white;
      border: none;
      padding: 8px 15px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 14px;
      transition: background-color 0.3s;
    }

    .action-btn:hover {
      background-color: #003d7a;
    }

    .data-table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 15px;
    }

    .data-table th, .data-table td {
      padding: 12px 15px;
      text-align: left;
      border-bottom: 1px solid #eee;
    }

    .data-table th {
      background-color: #f9f9f9;
      color: #333;
      font-weight: bold;
    }

    .data-table tbody tr:hover {
      background-color: #f5f5f5;
    }

    .status-active {
      color: #28a745;
      font-weight: bold;
    }

    .status-cancelled {
      color: #dc3545;
      font-weight: bold;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      color: #333;
      font-weight: bold;
    }

    .form-group input, .form-group select {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 14px;
    }

    .form-group textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 14px;
      height: 100px;
      resize: vertical;
    }

    .form-actions {
      display: flex;
      justify-content: flex-end;
      gap: 10px;
    }

    .btn-primary {
      background-color: #0056b3;
      color: white;
    }

    .btn-danger {
      background-color: #dc3545;
      color: white;
    }
  </style>
</head>

<body>
<%
  // Check if user is logged in and is an admin
  if (session.getAttribute("username") == null) {
    response.sendRedirect(request.getContextPath() + "/userlogin.jsp");
  } else if (!"admin".equals(session.getAttribute("role"))) {
    response.sendRedirect(request.getContextPath() + "/passengerdashboard.jsp");
  }
%>

<!-- Sidebar -->
<div class="sidebar">
  <div class="sidebar-header">
    <div class="logo">
      <span class="logo-icon">B</span>
    </div>
    <span class="brand-name">BusTickets</span>
  </div>

  <ul class="sidebar-menu">
    <li><a href="#" class="active">Dashboard</a></li>
    <li><a href="<%= request.getContextPath() %>/admin/trips">Trip Management</a></li>
    <li><a href="<%= request.getContextPath() %>/admin/fares">Fare Configuration</a></li>
    <li><a href="<%= request.getContextPath() %>/admin/reports">Reports</a></li>
    <li><a href="<%= request.getContextPath() %>/admin/users">User Management</a></li>
    <li><a href="<%= request.getContextPath() %>/admin/settings">Settings</a></li>
  </ul>
</div>

<!-- Main Content -->
<div class="admin-content">
  <div class="admin-header">
    <div class="page-title">
      <h1>Admin Dashboard</h1>
    </div>

    <div class="admin-user-info">
      <span>Admin: <%= session.getAttribute("username") %></span>
      <form action="<%= request.getContextPath() %>/logout" method="post">
        <button type="submit" class="logout-btn">Logout</button>
      </form>
    </div>
  </div>

  <!-- Stats Overview -->
  <div class="stats-container">
    <div class="stat-card">
      <div class="stat-card-header">
        <div class="stat-card-title">City Trips</div>
        <div class="stat-card-icon">🚌</div>
      </div>
      <div class="stat-card-value">124</div>
      <div class="stat-card-change">+8% from last month</div>
    </div>

    <div class="stat-card">
      <div class="stat-card-header">
        <div class="stat-card-title">Inter-City Trips</div>
        <div class="stat-card-icon">🚍</div>
      </div>
      <div class="stat-card-value">83</div>
      <div class="stat-card-change">+15% from last month</div>
    </div>

    <div class="stat-card">
      <div class="stat-card-header">
        <div class="stat-card-title">Total Revenue</div>
        <div class="stat-card-icon">💰</div>
      </div>
      <div class="stat-card-value">$34,582</div>
      <div class="stat-card-change">+15% from last month</div>
    </div>

    <div class="stat-card">
      <div class="stat-card-header">
        <div class="stat-card-title">New Users</div>
        <div class="stat-card-icon">👤</div>
      </div>
      <div class="stat-card-value">126</div>
      <div class="stat-card-change negative">-3% from last month</div>
    </div>
  </div>

  <!-- Content Area -->
  <div class="content-area">
    <div>
      <div class="trip-management">
        <h2 class="section-title">Trip Management</h2>
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
          <span>Showing recent trips</span>
          <a href="<%= request.getContextPath() %>/admin/trips/add" class="action-btn">Add New Trip</a>
        </div>

        <table class="data-table">
          <thead>
          <tr>
            <th>Trip ID</th>
            <th>Route</th>
            <th>Type</th>
            <th>Departure</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>BT-1045</td>
            <td>New York to Boston</td>
            <td>Inter-City</td>
            <td>Apr 25, 2025 | 08:30 AM</td>
            <td><span class="status-active">Active</span></td>
            <td>
              <a href="#" class="action-btn">Edit</a>
            </td>
          </tr>
          <tr>
            <td>BT-1046</td>
            <td>Boston Downtown Routes</td>
            <td>City</td>
            <td>Apr 25, 2025 | 10:00 AM</td>
            <td><span class="status-active">Active</span></td>
            <td>
              <a href="#" class="action-btn">Edit</a>
            </td>
          </tr>
          <tr>
            <td>BT-1047</td>
            <td>Philadelphia to Washington</td>
            <td>Inter-City</td>
            <td>Apr 25, 2025 | 12:45 PM</td>
            <td><span class="status-cancelled">Cancelled</span></td>
            <td>
              <a href="#" class="action-btn">Edit</a>
            </td>
          </tr>
          </tbody>
        </table>
      </div>

      <div class="reports">
        <h2 class="section-title">Reports</h2>
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
          <span>Generate reports</span>
        </div>

        <div class="form-group">
          <label for="report-type">Report Type</label>
          <select id="report-type" name="report-type">
            <option value="sales">Sales Report</option>
            <option value="ticketType">Tickets by Type</option>
            <option value="userCategory">Tickets by User Category</option>
            <option value="revenue">Revenue Analysis</option>
            <option value="routes">Popular Routes</option>
          </select>
        </div>

        <div class="form-group">
          <label for="date-range">Date Range</label>
          <select id="date-range" name="date-range">
            <option value="today">Today</option>
            <option value="week">This Week</option>
            <option value="month">This Month</option>
            <option value="quarter">This Quarter</option>
            <option value="year">This Year</option>
            <option value="custom">Custom Range</option>
          </select>
        </div>

        <div class="form-group">
          <label for="format">Output Format</label>
          <select id="format" name="format">
            <option value="pdf">PDF</option>
            <option value="excel">Excel</option>
            <option value="csv">CSV</option>
          </select>
        </div>

        <div class="form-actions">
          <button type="button" class="action-btn">Generate Report</button>
        </div>
      </div>
    </div>

    <div>
      <div class="fare-management">
        <h2 class="section-title">Fare Configuration</h2>
        <div style="margin-bottom: 15px;">
          <span>Configure ticket types and fares</span>
        </div>

        <div class="form-group">
          <label for="travel-type">Travel Type</label>
          <select id="travel-type" name="travel-type">
            <option value="city">City Travel</option>
            <option value="intercity">Inter-City Travel</option>
          </select>
        </div>

        <div class="form-group">
          <label for="ticket-type">Ticket Type</label>
          <select id="ticket-type" name="ticket-type">
            <option value="one-trip">One-Trip</option>
            <option value="daily">Daily Pass</option>
            <option value="weekly">Weekly Pass</option>
            <option value="monthly">Monthly Pass</option>
          </select>
        </div>

        <div class="form-group">
          <label for="base-fare">Base Fare ($)</label>
          <input type="number" id="base-fare" name="base-fare" value="45.00" min="0" step="0.01">
        </div>

        <div class="form-group">
          <label>Discount Categories</label>
          <div style="display: flex; align-items: center; margin-bottom: 10px;">
            <label style="width: 100px; margin: 0;">Regular:</label>
            <input type="number" value="0" min="0" max="100" style="width: 70px;"> %
          </div>
          <div style="display: flex; align-items: center; margin-bottom: 10px;">
            <label style="width: 100px; margin: 0;">Student:</label>
            <input type="number" value="20" min="0" max="100" style="width: 70px;"> %
          </div>
          <div style="display: flex; align-items: center; margin-bottom: 10px;">
            <label style="width: 100px; margin: 0;">Senior:</label>
            <input type="number" value="30" min="0" max="100" style="width: 70px;"> %
          </div>
          <div style="display: flex; align-items: center;">
            <label style="width: 100px; margin: 0;">Evening:</label>
            <input type="number" value="15" min="0" max="100" style="width: 70px;"> %
          </div>
        </div>

        <div class="form-actions">
          <button type="button" class="action-btn">Update Fares</button>
        </div>
      </div>

      <div class="fare-management">
        <h2 class="section-title">Quick Actions</h2>

        <div style="display: grid; grid-template-columns: 1fr; gap: 10px;">
          <a href="<%= request.getContextPath() %>/admin/trips/add" class="action-btn" style="text-align: center; text-decoration: none;">Add New Trip</a>
          <a href="<%= request.getContextPath() %>/admin/fares/manage" class="action-btn" style="text-align: center; text-decoration: none;">Manage All Fares</a>
          <a href="<%= request.getContextPath() %>/admin/reports/sales" class="action-btn" style="text-align: center; text-decoration: none;">Sales Report</a>
          <a href="<%= request.getContextPath() %>/admin/users" class="action-btn" style="text-align: center; text-decoration: none;">User Management</a>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>