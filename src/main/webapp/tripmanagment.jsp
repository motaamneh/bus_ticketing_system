
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.bus_ticketing_system.model.Trip" %>
<%@ page import="com.bus_ticketing_system.model.City" %>
<%@ page import="com.bus_ticketing_system.dao.TripDao" %>
<%@ page import="com.bus_ticketing_system.dao.CityDao" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trip Management - Bus Ticketing System</title>
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

        .action-btn {
            background-color: #0056b3;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .action-btn:hover {
            background-color: #003d7a;
        }

        .action-btn.delete {
            background-color: #dc3545;
        }

        .action-btn.delete:hover {
            background-color: #bd2130;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
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

        .data-table tbody tr:last-child td {
            border-bottom: none;
        }

        .table-actions {
            display: flex;
            gap: 8px;
        }

        .filter-container {
            display: flex;
            gap: 15px;
            background-color: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .filter-field {
            flex: 1;
        }

        .filter-field label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        .filter-field select, .filter-field input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .filter-actions {
            display: flex;
            align-items: flex-end;
            gap: 10px;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 20px;
            border-radius: 8px;
            width: 60%;
            max-width: 600px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 20px;
            color: #0056b3;
            font-weight: bold;
        }

        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .pagination {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            gap: 10px;
        }

        .pagination-btn {
            padding: 5px 10px;
            border: 1px solid #ddd;
            background-color: white;
            cursor: pointer;
            border-radius: 3px;
        }

        .pagination-btn.active {
            background-color: #0056b3;
            color: white;
            border-color: #0056b3;
        }

        .status-available {
            color: #28a745;
            font-weight: bold;
        }

        .status-limited {
            color: #fd7e14;
            font-weight: bold;
        }

        .status-full {
            color: #dc3545;
            font-weight: bold;
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

    // Initialize DAOs
    TripDao tripDAO = new TripDao();
    CityDao cityDAO = new CityDao();

    // Get all trips
    List<Trip> trips = tripDAO.getAllTrips();

    // For formatting dates
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy | hh:mm a");

    // Get all cities for add/edit form
    List<City> cities = cityDAO.getAllCities();
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
        <li><a href="<%= request.getContextPath() %>/admindashboard.jsp">Dashboard</a></li>
        <li><a href="<%= request.getContextPath() %>/admin/trips" class="active">Trip Management</a></li>
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
            <h1>Trip Management</h1>
        </div>

        <div class="admin-user-info">
            <span>Admin: <%= session.getAttribute("username") %></span>
            <form action="<%= request.getContextPath() %>/logout" method="post">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
    </div>

    <!-- Filter Section -->
    <div class="filter-container">
        <div class="filter-field">
            <label for="filter-origin">Origin City</label>
            <select id="filter-origin">
                <option value="">All Origins</option>
                <% for (City city : cities) { %>
                <option value="<%= city.getCityId() %>"><%= city.getCityName() %></option>
                <% } %>
            </select>
        </div>
        <div class="filter-field">
            <label for="filter-destination">Destination City</label>
            <select id="filter-destination">
                <option value="">All Destinations</option>
                <% for (City city : cities) { %>
                <option value="<%= city.getCityId() %>"><%= city.getCityName() %></option>
                <% } %>
            </select>
        </div>
        <div class="filter-field">
            <label for="filter-travel-type">Travel Type</label>
            <select id="filter-travel-type">
                <option value="">All Types</option>
                <option value="CITY">City</option>
                <option value="INTERCITY">Inter-City</option>
            </select>
        </div>
        <div class="filter-actions">
            <button class="action-btn" onclick="filterTrips()">Filter</button>
            <button class="action-btn" onclick="resetFilters()">Reset</button>
            <button class="action-btn" onclick="openAddModal()">Add New Trip</button>
        </div>
    </div>

    <!-- Trip Table -->
    <table class="data-table">
        <thead>
        <tr>
            <th>Trip ID</th>
            <th>Route</th>
            <th>Travel Type</th>
            <th>Departure</th>
            <th>Arrival</th>
            <th>Seats</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for (Trip trip : trips) { %>
        <tr>
            <td><%= trip.getTripId() %></td>
            <td><%= trip.getOriginCity().getCityName() %> to <%= trip.getDestinationCity().getCityName() %></td>
            <td><%= trip.getTravelType() %></td>
            <td><%= dateFormat.format(trip.getDepartureTime()) %></td>
            <td><%= dateFormat.format(trip.getArrivalTime()) %></td>
            <td><%= trip.getAvailableSeats() %>/<%= trip.getTotalSeats() %></td>
            <td>
                <%
                    double seatRatio = (double) trip.getAvailableSeats() / trip.getTotalSeats();
                    if (seatRatio > 0.5) {
                %>
                <span class="status-available">Available</span>
                <% } else if (seatRatio > 0) { %>
                <span class="status-limited">Limited</span>
                <% } else { %>
                <span class="status-full">Full</span>
                <% } %>
            </td>
            <td class="table-actions">
                <button class="action-btn" onclick="openEditModal(<%= trip.getTripId() %>)">Edit</button>
                <button class="action-btn delete" onclick="confirmDelete(<%= trip.getTripId() %>)">Delete</button>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <!-- Pagination -->
    <div class="pagination">
        <button class="pagination-btn">Previous</button>
        <button class="pagination-btn active">1</button>
        <button class="pagination-btn">2</button>
        <button class="pagination-btn">3</button>
        <button class="pagination-btn">Next</button>
    </div>

    <!-- Add Trip Modal -->
    <div id="addTripModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Add New Trip</h2>
                <span class="close" onclick="closeAddModal()">&times;</span>
            </div>
            <form action="<%= request.getContextPath() %>/admin/trips/add" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label for="originCity">Origin City</label>
                        <select id="originCity" name="originCityId" required>
                            <option value="">Select Origin City</option>
                            <% for (City city : cities) { %>
                            <option value="<%= city.getCityId() %>"><%= city.getCityName() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="destinationCity">Destination City</label>
                        <select id="destinationCity" name="destinationCityId" required>
                            <option value="">Select Destination City</option>
                            <% for (City city : cities) { %>
                            <option value="<%= city.getCityId() %>"><%= city.getCityName() %></option>
                            <% } %>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="departureTime">Departure Time</label>
                        <input type="datetime-local" id="departureTime" name="departureTime" required>
                    </div>
                    <div class="form-group">
                        <label for="arrivalTime">Arrival Time</label>
                        <input type="datetime-local" id="arrivalTime" name="arrivalTime" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="travelType">Travel Type</label>
                        <select id="travelType" name="travelType" required>
                            <option value="">Select Travel Type</option>
                            <option value="CITY">City</option>
                            <option value="INTERCITY">Inter-City</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="totalSeats">Total Seats</label>
                        <input type="number" id="totalSeats" name="totalSeats" min="1" value="40" required>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="button" class="action-btn" style="background-color: #6c757d;" onclick="closeAddModal()">Cancel</button>
                    <button type="submit" class="action-btn">Save Trip</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Edit Trip Modal -->
    <div id="editTripModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Edit Trip</h2>
                <span class="close" onclick="closeEditModal()">&times;</span>
            </div>
            <form action="<%= request.getContextPath() %>/admin/trips/update" method="post">
                <input type="hidden" id="editTripId" name="tripId">
                <div class="form-row">
                    <div class="form-group">
                        <label for="editOriginCity">Origin City</label>
                        <select id="editOriginCity" name="originCityId" required>
                            <% for (City city : cities) { %>
                            <option value="<%= city.getCityId() %>"><%= city.getCityName() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editDestinationCity">Destination City</label>
                        <select id="editDestinationCity" name="destinationCityId" required>
                            <% for (City city : cities) { %>
                            <option value="<%= city.getCityId() %>"><%= city.getCityName() %></option>
                            <% } %>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="editDepartureTime">Departure Time</label>
                        <input type="datetime-local" id="editDepartureTime" name="departureTime" required>
                    </div>
                    <div class="form-group">
                        <label for="editArrivalTime">Arrival Time</label>
                        <input type="datetime-local" id="editArrivalTime" name="arrivalTime" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="editTravelType">Travel Type</label>
                        <select id="editTravelType" name="travelType" required>
                            <option value="CITY">City</option>
                            <option value="INTERCITY">Inter-City</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editTotalSeats">Total Seats</label>
                        <input type="number" id="editTotalSeats" name="totalSeats" min="1" required>
                    </div>
                    <div class="form-group">
                        <label for="editAvailableSeats">Available Seats</label>
                        <input type="number" id="editAvailableSeats" name="availableSeats" min="0" required>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="button" class="action-btn" style="background-color: #6c757d;" onclick="closeEditModal()">Cancel</button>
                    <button type="submit" class="action-btn">Update Trip</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content" style="max-width: 400px;">
            <div class="modal-header">
                <h2 class="modal-title">Confirm Delete</h2>
                <span class="close" onclick="closeDeleteModal()">&times;</span>
            </div>
            <p style="margin-bottom: 20px;">Are you sure you want to delete this trip? This action cannot be undone.</p>
            <form action="<%= request.getContextPath() %>/admin/trips/delete" method="post">
                <input type="hidden" id="deleteTripId" name="tripId">
                <div class="form-actions">
                    <button type="button" class="action-btn" style="background-color: #6c757d;" onclick="closeDeleteModal()">Cancel</button>
                    <button type="submit" class="action-btn delete">Delete</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Modal functions
        function openAddModal() {
            document.getElementById('addTripModal').style.display = 'block';
        }

        function closeAddModal() {
            document.getElementById('addTripModal').style.display = 'none';
        }

        function openEditModal(tripId) {
            // In a real application, you would fetch trip data by ID from server
            // For demonstration, we'll just show the modal
            document.getElementById('editTripId').value = tripId;
            document.getElementById('editTripModal').style.display = 'block';

            // Here you would populate the form with trip data
            // This is where you'd make an AJAX call to get trip details
        }

        function closeEditModal() {
            document.getElementById('editTripModal').style.display = 'none';
        }

        function confirmDelete(tripId) {
            document.getElementById('deleteTripId').value = tripId;
            document.getElementById('deleteModal').style.display = 'block';
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }

        // Filter functions
        function filterTrips() {
            // In a real application, this would submit the filter form or use AJAX
            // For demonstration, we'll just show an alert
            alert('Filtering functionality would be implemented with backend processing');
        }

        function resetFilters() {
            document.getElementById('filter-origin').value = '';
            document.getElementById('filter-destination').value = '';
            document.getElementById('filter-travel-type').value = '';
        }

        // Close modals when clicking outside
        window.onclick = function(event) {
            if (event.target.className === 'modal') {
                event.target.style.display = 'none';
            }
        }
    </script>
</div>
</body>
</html>