<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bus_ticketing_system.model.City" %>
<%@ page import="com.bus_ticketing_system.model.Trip" %>
<%@ page import="com.bus_ticketing_system.dao.CityDao" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Search Trips - Bus Ticketing System</title>
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

    .page-title {
      color: #0056b3;
      margin-bottom: 20px;
    }

    .search-box {
      background-color: white;
      padding: 25px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      margin-bottom: 30px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      font-weight: bold;
      color: #333;
    }

    .form-control {
      width: 100%;
      padding: 12px;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 16px;
    }

    .form-row {
      display: flex;
      gap: 20px;
    }

    .form-col {
      flex: 1;
    }

    .search-btn {
      background-color: #ff6b00;
      color: white;
      border: none;
      padding: 12px 24px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 16px;
      font-weight: bold;
      transition: background-color 0.3s;
    }

    .search-btn:hover {
      background-color: #e05d00;
    }

    .results-section {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      padding: 25px;
      margin-top: 30px;
    }

    .results-title {
      color: #0056b3;
      margin-bottom: 20px;
    }

    .trips-table {
      width: 100%;
      border-collapse: collapse;
    }

    .trips-table th {
      text-align: left;
      padding: 12px 15px;
      background-color: #f2f7ff;
      border-bottom: 2px solid #ddd;
      color: #0056b3;
    }

    .trips-table td {
      padding: 12px 15px;
      border-bottom: 1px solid #eee;
    }

    .trips-table tr:hover {
      background-color: #f9f9f9;
    }

    .book-btn {
      background-color: #0056b3;
      color: white;
      border: none;
      padding: 8px 12px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 14px;
      transition: background-color 0.3s;
    }

    .book-btn:hover {
      background-color: #003d7a;
    }

    .no-trips {
      text-align: center;
      padding: 30px;
      color: #666;
    }

    footer {
      background-color: #333;
      color: white;
      text-align: center;
      padding: 20px;
      margin-top: 30px;
    }

    .back-link {
      display: inline-block;
      margin-bottom: 20px;
      color: #0056b3;
      text-decoration: none;
    }

    .back-link:hover {
      text-decoration: underline;
    }

    /* For date input styling across browsers */
    input[type="date"] {
      appearance: none;
      -webkit-appearance: none;
      padding: 12px;
      border: 1px solid #ddd;
      border-radius: 5px;
      width: 100%;
      font-size: 16px;
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

  // Get cities for dropdown lists
  CityDao cityDao = new CityDao();
  List<City> cities = cityDao.getAllCities();
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
  <a href="<%= request.getContextPath() %>/passengerdashboard.jsp" class="back-link">←
    Back to Dashboard</a>

  <h1 class="page-title">Search for Trips</h1>

  <div class="search-box">
    <form action="<%= request.getContextPath() %>/search-trips" method="post">
      <div class="form-row">
        <div class="form-col">
          <div class="form-group">
            <label for="originCity">From:</label>
            <select id="originCity" name="originCity" class="form-control" required>
              <option value="">Select origin city</option>
              <% for(City city : cities) { %>
              <option value="<%= city.getCityId() %>">
                <%= city.getCityName() %>
              </option>
              <% } %>
            </select>
          </div>
        </div>
        <div class="form-col">
          <div class="form-group">
            <label for="destinationCity">To:</label>
            <select id="destinationCity" name="destinationCity" class="form-control" required>
              <option value="">Select destination city</option>
              <% for(City city : cities) { %>
              <option value="<%= city.getCityId() %>">
                <%= city.getCityName() %>
              </option>
              <% } %>
            </select>
          </div>
        </div>
      </div>

      <div class="form-row">
        <div class="form-col">
          <div class="form-group">
            <label for="travelDate">Travel Date:</label>
            <input type="date" id="travelDate" name="travelDate" class="form-control" required>
          </div>
        </div>
        <div class="form-col">
          <div class="form-group">
            <label for="travelType">Travel Type:</label>
            <select id="travelType" name="travelType" class="form-control" required>
              <option value="">Select travel type</option>
              <option value="CITY">City</option>
              <option value="INTER_CITY">Inter-City</option>
            </select>
          </div>
        </div>
      </div>

      <div class="form-group" style="text-align: center; margin-top: 10px;">
        <button type="submit" class="search-btn">Search Trips</button>
      </div>
    </form>
  </div>

  <% List<Trip> searchResults = (List<Trip>) request.getAttribute("searchResults");
    if(searchResults != null) {
  %>
  <div class="results-section">
    <h2 class="results-title">Search Results</h2>

    <% if(searchResults.isEmpty()) { %>
    <div class="no-trips">
      <p>No trips found for your search criteria. Please try different
        options.</p>
    </div>
    <% } else { %>
    <table class="trips-table">
      <thead>
      <tr>
        <th>From</th>
        <th>To</th>
        <th>Departure</th>
        <th>Arrival</th>
        <th>Type</th>
        <th>Available Seats</th>
        <th>Action</th>
      </tr>
      </thead>
      <tbody>
      <% for(Trip trip : searchResults) { %>
      <tr>
        <td>
          <%= trip.getOriginCity().getCityName() %>
        </td>
        <td>
          <%= trip.getDestinationCity().getCityName() %>
        </td>
        <td>
          <%= trip.getDepartureTime() %>
        </td>
        <td>
          <%= trip.getArrivalTime() %>
        </td>
        <td>
          <%= trip.getTravelType() %>
        </td>
        <td>
          <%= trip.getAvailableSeats() %>
        </td>
        <td>
          <form action="<%= request.getContextPath() %>/select-trip"
                method="post">
            <input type="hidden" name="tripId"
                   value="<%= trip.getTripId() %>">
            <button type="submit" class="book-btn">Select</button>
          </form>
        </td>
      </tr>
      <% } %>
      </tbody>
    </table>
    <% } %>
  </div>
  <% } %>
</div>

<!-- Footer -->
<footer>
  <p>&copy; 2025 BusTickets. All rights reserved.</p>
</footer>

<script>
  // Set min date to today
  const today = new Date().toISOString().split('T')[0];
  document.getElementById('travelDate').min = today;
</script>
</body>

</html>