<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calculate Fare - Bus Ticketing System</title>
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
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .page-title {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .page-title h1 {
            color: #0056b3;
            margin-bottom: 15px;
        }

        .form-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
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
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        .form-control:focus {
            border-color: #0056b3;
            outline: none;
        }

        .btn-primary {
            background-color: #ff6b00;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .btn-primary:hover {
            background-color: #e05d00;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .result-container {
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-top: 30px;
        }

        .result-title {
            color: #0056b3;
            margin-bottom: 15px;
            font-size: 20px;
        }

        .result-item {
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .result-item:last-child {
            border-bottom: none;
        }

        .result-label {
            font-weight: bold;
            margin-right: 10px;
            color: #555;
        }

        .result-value {
            color: #333;
        }

        .fare-amount {
            font-size: 24px;
            color: #ff6b00;
            font-weight: bold;
        }

        .alert {
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
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
    // Check if user is logged in
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
    <div class="page-title">
        <h1>Calculate Fare</h1>
        <p>Estimate the ticket price before making a purchase. Input your travel details below to calculate the fare.</p>
    </div>

    <div class="form-container">
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                    ${errorMessage}
            </div>
        </c:if>

        <form action="<%= request.getContextPath() %>/passenger/calculate-fare" method="post">
            <div class="form-group">
                <label for="tripId">Select Trip</label>
                <select id="tripId" name="tripId" class="form-control" required>
                    <option value="">-- Select a Trip --</option>
                    <c:forEach var="trip" items="${availableTrips}">
                        <option value="${trip.tripId}" <c:if test="${trip.tripId == param.tripId}">selected</c:if>>
                                ${trip.source} to ${trip.destination} - ${trip.departureTime} - Base Fare: $${trip.baseFare}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="ticketType">Ticket Type</label>
                <select id="ticketType" name="ticketType" class="form-control" required>
                    <option value="">-- Select Ticket Type --</option>
                    <option value="ONE_TRIP" <c:if test="${param.ticketType == 'ONE_TRIP'}">selected</c:if>>One Trip</option>
                    <option value="ROUND_TRIP" <c:if test="${param.ticketType == 'ROUND_TRIP'}">selected</c:if>>Round Trip</option>
                    <option value="MULTI_TRIP" <c:if test="${param.ticketType == 'MULTI_TRIP'}">selected</c:if>>Multi Trip</option>
                </select>
            </div>

            <div class="form-group">
                <label for="timeOfDay">Time of Day</label>
                <select id="timeOfDay" name="timeOfDay" class="form-control" required>
                    <option value="">-- Select Time of Day --</option>
                    <option value="morning" <c:if test="${param.timeOfDay == 'morning'}">selected</c:if>>Morning (6 AM - 12 PM)</option>
                    <option value="afternoon" <c:if test="${param.timeOfDay == 'afternoon'}">selected</c:if>>Afternoon (12 PM - 5 PM)</option>
                    <option value="evening" <c:if test="${param.timeOfDay == 'evening'}">selected</c:if>>Evening (5 PM - 10 PM)</option>
                    <option value="night" <c:if test="${param.timeOfDay == 'night'}">selected</c:if>>Night (10 PM - 6 AM)</option>
                </select>
            </div>

            <div class="form-group">
                <button type="submit" class="btn-primary">Calculate Fare</button>
                <a href="<%= request.getContextPath() %>/passengerdashboard.jsp" class="btn-secondary">Back to Dashboard</a>
            </div>
        </form>

        <c:if test="${not empty calculatedFare}">
            <div class="result-container">
                <h3 class="result-title">Fare Calculation Results</h3>

                <div class="result-item">
                    <span class="result-label">Trip:</span>
                    <span class="result-value">${trip.source} to ${trip.destination}</span>
                </div>

                <div class="result-item">
                    <span class="result-label">Travel Type:</span>
                    <span class="result-value">${trip.travelType}</span>
                </div>

                <div class="result-item">
                    <span class="result-label">Departure Time:</span>
                    <span class="result-value">${trip.departureTime}</span>
                </div>

                <div class="result-item">
                    <span class="result-label">Ticket Type:</span>
                    <span class="result-value">
                        <c:choose>
                            <c:when test="${ticketType == 'ONE_TRIP'}">One Trip</c:when>
                            <c:when test="${ticketType == 'ROUND_TRIP'}">Round Trip</c:when>
                            <c:when test="${ticketType == 'MULTI_TRIP'}">Multi Trip</c:when>
                            <c:otherwise>${ticketType}</c:otherwise>
                        </c:choose>
                    </span>
                </div>

                <div class="result-item">
                    <span class="result-label">Time of Day:</span>
                    <span class="result-value">
                        <c:choose>
                            <c:when test="${timeOfDay == 'morning'}">Morning (6 AM - 12 PM)</c:when>
                            <c:when test="${timeOfDay == 'afternoon'}">Afternoon (12 PM - 5 PM)</c:when>
                            <c:when test="${timeOfDay == 'evening'}">Evening (5 PM - 10 PM)</c:when>
                            <c:when test="${timeOfDay == 'night'}">Night (10 PM - 6 AM)</c:when>
                            <c:otherwise>${timeOfDay}</c:otherwise>
                        </c:choose>
                    </span>
                </div>

                <div class="result-item">
                    <span class="result-label">User Category:</span>
                    <span class="result-value">${user.category}</span>
                </div>

                <div class="result-item">
                    <span class="result-label">Base Fare:</span>
                    <span class="result-value">$${trip.baseFare}</span>
                </div>

                <div class="result-item">
                    <span class="result-label">Total Fare:</span>
                    <span class="result-value fare-amount">$<fmt:formatNumber value="${calculatedFare}" pattern="#,##0.00"/></span>
                </div>

                <p style="margin-top: 20px; color: #555; font-style: italic;">
                    * Discounts may apply based on your user category and time of travel.
                </p>

                <div style="margin-top: 20px;">
                    <a href="<%= request.getContextPath() %>/passenger/buy-tickets?tripId=${trip.tripId}&ticketType=${ticketType}" class="btn-primary">Proceed to Purchase</a>
                </div>
            </div>
        </c:if>
    </div>
</div>

<!-- Footer -->
<footer>
    <p>&copy; 2025 BusTickets. All rights reserved.</p>
</footer>
</body>
</html>