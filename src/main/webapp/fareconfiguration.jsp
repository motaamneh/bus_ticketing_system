

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.bus_ticketing_system.model.FareRule" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Fare Configuration - Bus Ticketing System</title>
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

    .fare-config-container {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 20px;
    }

    .fare-card {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      padding: 20px;
      margin-bottom: 20px;
    }

    .fare-card-header {
      color: #0056b3;
      font-size: 18px;
      font-weight: bold;
      padding-bottom: 15px;
      border-bottom: 1px solid #eee;
      margin-bottom: 15px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .fare-card-badge {
      font-size: 12px;
      padding: 5px 10px;
      border-radius: 50px;
      background-color: #e9f2ff;
      color: #0056b3;
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

    .discount-group {
      background-color: #f9f9f9;
      padding: 15px;
      border-radius: 5px;
      margin-bottom: 15px;
    }

    .discount-title {
      font-weight: bold;
      color: #333;
      margin-bottom: 10px;
    }

    .discount-item {
      display: flex;
      align-items: center;
      margin-bottom: 10px;
    }

    .discount-item label {
      width: 100px;
      margin: 0;
      font-weight: normal;
    }

    .discount-item input {
      width: 70px;
      padding: 5px;
      border: 1px solid #ddd;
      border-radius: 5px;
    }

    .action-btn {
      background-color: #0056b3;
      color: white;
      border: none;
      padding: 10px 15px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 14px;
      transition: background-color 0.3s;
      width: 100%;
    }

    .action-btn:hover {
      background-color: #003d7a;
    }

    .delete-btn {
      background-color: #dc3545;
      color: white;
      border: none;
      padding: 10px 15px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 14px;
      transition: background-color 0.3s;
      width: 100%;
      margin-top: 10px;
    }

    .delete-btn:hover {
      background-color: #bd2130;
    }

    .add-new-btn {
      background-color: #28a745;
      color: white;
      border: none;
      padding: 12px 20px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 16px;
      transition: background-color 0.3s;
      text-align: center;
      margin-bottom: 20px;
      display: block;
      width: fit-content;
    }

    .add-new-btn:hover {
      background-color: #218838;
    }

    .tab-container {
      margin-bottom: 20px;
    }

    .tab-buttons {
      display: flex;
      border-bottom: 1px solid #ddd;
      margin-bottom: 20px;
    }

    .tab-btn {
      padding: 10px 20px;
      background: none;
      border: none;
      cursor: pointer;
      font-size: 16px;
      font-weight: normal;
      color: #666;
      border-bottom: 3px solid transparent;
      transition: all 0.3s;
    }

    .tab-btn.active {
      border-bottom: 3px solid #0056b3;
      font-weight: bold;
      color: #0056b3;
    }

    .tab-content {
      display: none;
    }

    .tab-content.active {
      display: block;
    }

    .alert {
      padding: 15px;
      margin-bottom: 20px;
      border-radius: 5px;
    }

    .alert-success {
      background-color: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
    }

    .alert-danger {
      background-color: #f8d7da;
      color: #721c24;
      border: 1px solid #f5c6cb;
    }
    /* Modal Styles */
    .modal {
      display: none;
      position: fixed;
      z-index: 1000;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0,0,0,0.4);
    }

    .modal-content {
      background-color: #fefefe;
      margin: 10% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 40%;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .close-modal {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
      cursor: pointer;
    }

    .close-modal:hover {
      color: black;
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

  // Check for success message
  String successMessage = (String) session.getAttribute("successMessage");
  String errorMessage = (String) session.getAttribute("errorMessage");

  if (successMessage != null) {
    session.removeAttribute("successMessage");
  }

  if (errorMessage != null) {
    session.removeAttribute("errorMessage");
  }

  // Get fare configurations from request
// Get fare configurations and discounts from request
    List<FareRule> cityFares = (List<FareRule>) request.getAttribute("cityFares");
    List<FareRule> intercityFares = (List<FareRule>) request.getAttribute("intercityFares");
    Map<String, Double> discounts = (Map<String, Double>) request.getAttribute("discounts");

    // Provide default discounts if null
    if (discounts == null) {
        discounts = new HashMap<>();
        discounts.put("regular", 0.0);
        discounts.put("student", 20.0);
        discounts.put("senior", 30.0);
        discounts.put("evening", 15.0);
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
    <li><a href="<%= request.getContextPath() %>/admin/dashboard">Dashboard</a></li>
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
      <h1>Fare Configuration</h1>
    </div>

    <div class="admin-user-info">
      <span>Admin: <%= session.getAttribute("username") %></span>
      <form action="<%= request.getContextPath() %>/logout" method="post">
        <button type="submit" class="logout-btn">Logout</button>
      </form>
    </div>
  </div>

  <!-- Alert Messages -->
  <% if (successMessage != null && !successMessage.isEmpty()) { %>
  <div class="alert alert-success">
    <%= successMessage %>
  </div>
  <% } %>

  <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
  <div class="alert alert-danger">
    <%= errorMessage %>
  </div>
  <% } %>

  <!-- Tab Navigation -->
  <div class="tab-container">
    <div class="tab-buttons">
      <button class="tab-btn active" onclick="openTab(event, 'fareConfig')">Ticket Fare Configuration</button>
      <button class="tab-btn" onclick="openTab(event, 'discountConfig')">Discount Configuration</button>
    </div>

    <!-- Fare Configuration Tab -->
    <div id="fareConfig" class="tab-content active">
      <button onclick="openAddFareModal()" class="add-new-btn">Add New Fare Configuration</button>

      <div class="tab-buttons">
        <button class="tab-btn active" onclick="openSubTab(event, 'cityFares')">City Travel</button>
        <button class="tab-btn" onclick="openSubTab(event, 'intercityFares')">Inter-City Travel</button>
      </div>
      <!-- Add Fare Modal Dialog -->
      <div id="addFareModal" class="modal" style="display:none;">
        <div class="modal-content">
          <span class="close-modal" onclick="closeAddFareModal()">&times;</span>
          <h2>Add New Fare Configuration</h2>
          <form id="addFareForm" action="<%= request.getContextPath() %>/admin/fares/add" method="post">
            <div class="form-group">
              <label for="modalTravelType">Travel Type:</label>
              <select id="modalTravelType" name="travelType" required>
                <option value="CITY">City</option>
                <option value="INTER_CITY">Inter-City</option>
              </select>
            </div>

            <div class="form-group">
              <label for="modalTicketType">Ticket Type:</label>
              <select id="modalTicketType" name="ticketType" required>
                <option value="One-Trip">One-Trip</option>
                <option value="Daily Pass">Daily Pass</option>
                <option value="Weekly Pass">Weekly Pass</option>
                <option value="Monthly Pass">Monthly Pass</option>
              </select>
            </div>

            <div class="form-group">
              <label for="modalBaseMultiplier">Base Multiplier:</label>
              <input type="number" id="modalBaseMultiplier" name="baseMultiplier" step="0.01" min="0" required>
            </div>

            <button type="submit" class="action-btn">Add Configuration</button>
          </form>
        </div>
      </div>

      <!-- City Fares -->
      <div id="cityFares" class="tab-content active">
        <div class="fare-config-container">
          <% if (cityFares != null && !cityFares.isEmpty()) { %>
          <% for (FareRule fare : cityFares) { %>
          <div class="fare-card">
            <div class="fare-card-header">
              <%= fare.getTicketType() %> <span class="fare-card-badge">City</span>
            </div>
            <form action="<%= request.getContextPath() %>/admin/fares/update" method="post">
              <input type="hidden" name="fareId" value="<%= fare.getRuleId() %>">
              <input type="hidden" name="travelType" value="city">

              <div class="form-group">
                <label for="ticketType<%= fare.getRuleId() %>">Ticket Type</label>
                <select id="ticketType<%= fare.getTicketType() %>" name="ticketType">
                  <option value="One-Trip" <%= "One-Trip".equals(fare.getTicketType()) ? "selected" : "" %>>One-Trip</option>
                  <option value="Daily Pass" <%= "Daily Pass".equals(fare.getTicketType()) ? "selected" : "" %>>Daily Pass</option>
                  <option value="Weekly Pass" <%= "Weekly Pass".equals(fare.getTicketType()) ? "selected" : "" %>>Weekly Pass</option>
                  <option value="Monthly Pass" <%= "Monthly Pass".equals(fare.getTicketType()) ? "selected" : "" %>>Monthly Pass</option>
                </select>
              </div>

              <div class="form-group">
                <label for="baseFare<%= fare.getRuleId() %>">Base Fare ($)</label>
                <input type="number" id="baseFare<%= fare.getRuleId() %>" name="baseMultiplier"
                       value="<%= fare.getBaseMultiplier() %>" min="0" step="0.01">

              </div>



              <button type="submit" class="action-btn">Update Fare</button>
            </form>
            <form action="<%= request.getContextPath() %>/admin/fares/delete" method="post" onsubmit="return confirm('Are you sure you want to delete this fare configuration?');">
              <input type="hidden" name="fareId" value="<%= fare.getRuleId() %>">
              <button type="submit" class="delete-btn">Delete</button>
            </form>
          </div>
          <% } %>
          <% } else { %>
          <div class="fare-card">
            <div class="fare-card-header">
              No City Fares Configured
            </div>
            <p style="text-align: center; margin: 20px 0;">
              No fare configurations found for city travel. Please add new configurations.
            </p>
          </div>
          <% } %>
        </div>
      </div>

      <!-- Inter-City Fares -->
      <div id="intercityFares" class="tab-content">
        <div class="fare-config-container">
          <% if (intercityFares != null && !intercityFares.isEmpty()) { %>
          <% for (FareRule fare : intercityFares) { %>
          <div class="fare-card">
            <div class="fare-card-header">
              <%= fare.getTicketType() %> <span class="fare-card-badge">Inter-City</span>
            </div>
            <form action="<%= request.getContextPath() %>/admin/fares/update" method="post">
              <input type="hidden" name="fareId" value="<%= fare.getRuleId() %>">
              <input type="hidden" name="travelType" value="intercity">

              <div class="form-group">
                <label for="ticketType<%= fare.getRuleId() %>">Ticket Type</label>
                <select id="ticketType<%= fare.getTicketType() %>" name="ticketType">
                  <option value="One-Trip" <%= "One-Trip".equals(fare.getTicketType()) ? "selected" : "" %>>One-Trip</option>
                  <option value="Daily Pass" <%= "Daily Pass".equals(fare.getTicketType()) ? "selected" : "" %>>Daily Pass</option>
                  <option value="Weekly Pass" <%= "Weekly Pass".equals(fare.getTicketType()) ? "selected" : "" %>>Weekly Pass</option>
                  <option value="Monthly Pass" <%= "Monthly Pass".equals(fare.getTicketType()) ? "selected" : "" %>>Monthly Pass</option>
                </select>
              </div>

              <div class="form-group">
                <label for="baseFare<%= fare.getRuleId() %>">Base Fare ($)</label>
                <input type="number" id="baseFare<%= fare.getRuleId() %>" name="baseMultiplier"
                       value="<%= fare.getBaseMultiplier() %>" min="0" step="0.01">
              </div>



              <button type="submit" class="action-btn">Update Fare</button>
            </form>
            <form action="<%= request.getContextPath() %>/admin/fares/delete" method="post" onsubmit="return confirm('Are you sure you want to delete this fare configuration?');">
              <input type="hidden" name="fareId" value="<%= fare.getRuleId() %>">
              <button type="submit" class="delete-btn">Delete</button>
            </form>
          </div>
          <% } %>
          <% } else { %>
          <div class="fare-card">
            <div class="fare-card-header">
              No Inter-City Fares Configured
            </div>
            <p style="text-align: center; margin: 20px 0;">
              No fare configurations found for inter-city travel. Please add new configurations.
            </p>
          </div>
          <% } %>
        </div>
      </div>
    </div>

    <!-- Discount Configuration Tab -->
    <div id="discountConfig" class="tab-content">
      <div class="fare-card">
        <div class="fare-card-header">
          User Category Discounts
        </div>
        <form action="<%= request.getContextPath() %>/admin/discounts/update" method="post">
          <div class="discount-group">
            <div class="discount-title">Discount Percentages</div>

            <div class="discount-item">
              <label for="regular">Regular:</label>
              <input type="number" id="regular" name="regular" value="<%= discounts.get("regular") %>" min="0" max="100"> %
            </div>

            <div class="discount-item">
              <label for="student">Student:</label>
              <input type="number" id="student" name="student" value="<%= discounts.get("student") %>" min="0" max="100"> %
            </div>

            <div class="discount-item">
              <label for="senior">Senior:</label>
              <input type="number" id="senior" name="senior" value="<%= discounts.get("senior") %>" min="0" max="100"> %
            </div>

            <div class="discount-item">
              <label for="evening">Evening:</label>
              <input type="number" id="evening" name="evening" value="<%= discounts.get("evening") %>" min="0" max="100"> %
              <span style="margin-left: 10px; font-size: 12px; color: #666;">(applies to One-Trip tickets after 7 PM)</span>
            </div>
          </div>

          <div class="form-group">
            <label for="maxDiscount">Maximum Combined Discount (%)</label>
            <input type="number" id="maxDiscount" name="maxDiscount" value="50" min="0" max="100">
            <small style="display: block; margin-top: 5px; color: #666;">Note: Total combined discount will not exceed this value</small>
          </div>

          <button type="submit" class="action-btn">Update Discount Rules</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
  function openTab(evt, tabName) {
    var i, tabcontent, tablinks;

    // Hide all tab content
    tabcontent = document.getElementsByClassName("tab-content");
    for (i = 0; i < tabcontent.length; i++) {
      tabcontent[i].style.display = "none";
    }

    // Remove active class from all tab buttons
    tablinks = document.getElementsByClassName("tab-btn");
    for (i = 0; i < tablinks.length; i++) {
      tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the current tab and add active class to the button
    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";

    // If switching to fare config tab, ensure city fares are shown by default
    if (tabName === "fareConfig") {
      document.getElementById("cityFares").style.display = "block";
      document.getElementById("intercityFares").style.display = "none";

      // Update the active state of the subtabs
      var subtablinks = document.querySelectorAll("#fareConfig .tab-btn");
      subtablinks[0].classList.add("active");
      subtablinks[1].classList.remove("active");
    }
  }

  function openSubTab(evt, tabName) {
    var i, tabcontent, tablinks;

    // Hide all tab content within the fare config
    tabcontent = document.querySelectorAll("#fareConfig .tab-content");
    for (i = 0; i < tabcontent.length; i++) {
      tabcontent[i].style.display = "none";
    }

    // Remove active class from all sub tab buttons
    tablinks = document.querySelectorAll("#fareConfig .tab-btn");
    for (i = 0; i < tablinks.length; i++) {
      tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the current tab and add active class to the button
    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";
  }

  // Auto-hide alerts after 5 seconds
  window.onload = function() {
    setTimeout(function() {
      var alerts = document.getElementsByClassName('alert');
      for (var i = 0; i < alerts.length; i++) {
        alerts[i].style.display = 'none';
      }
    }, 5000);
  };
  function openAddFareModal() {
    document.getElementById('addFareModal').style.display = 'block';
  }

  function closeAddFareModal() {
    document.getElementById('addFareModal').style.display = 'none';
  }

  // Close modal when clicking outside of it
  window.onclick = function(event) {
    var modal = document.getElementById('addFareModal');
    if (event.target == modal) {
      closeAddFareModal();
    }
  }
</script>
</body>
</html>