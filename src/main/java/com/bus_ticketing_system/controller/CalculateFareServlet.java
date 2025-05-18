package com.bus_ticketing_system.controller;

import com.bus_ticketing_system.dao.TripDao;
import com.bus_ticketing_system.model.Trip;
import com.bus_ticketing_system.model.User;
import com.bus_ticketing_system.strategy.FareCalculationContext;

import com.bus_ticketing_system.dao.UserDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/passenger/calculate-fare")
public class CalculateFareServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TripDao tripDao = new TripDao();
        List<Trip> availableTrips = tripDao.getAllTrips();
        request.setAttribute("availableTrips", availableTrips);

        request.getRequestDispatcher("/calculatefare.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String tripIdStr = request.getParameter("tripId");
        String ticketType = request.getParameter("ticketType");
        String timeOfDay = request.getParameter("timeOfDay");

        // Validate input
        if (tripIdStr == null || tripIdStr.isEmpty() || ticketType == null || ticketType.isEmpty() || timeOfDay == null || timeOfDay.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required");
            doGet(request, response);
            return;
        }

        try {
            int tripId = Integer.parseInt(tripIdStr);

            // Get trip details
            TripDao tripDao = new TripDao();
            Trip trip = tripDao.getTripById(tripId);

            if (trip == null) {
                request.setAttribute("errorMessage", "Selected trip not found");
                doGet(request, response);
                return;
            }

            // Get user details from session
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");

            UserDao userDao = new UserDao();
            User user = userDao.getUserByUsername(username);

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/userlogin.jsp");
                return;
            }

            // Determine if it's evening time
            boolean isEveningTime = "evening".equals(timeOfDay);

            // Calculate fare using Strategy Pattern
            FareCalculationContext fareContext = new FareCalculationContext();
            double calculatedFare = fareContext.calculateFare(trip, user, ticketType, isEveningTime);

            // Set attributes for display in JSP
            request.setAttribute("trip", trip);
            request.setAttribute("ticketType", ticketType);
            request.setAttribute("timeOfDay", timeOfDay);
            request.setAttribute("calculatedFare", calculatedFare);
            request.setAttribute("user", user);

            // Get available trips for the form
            List<Trip> availableTrips = tripDao.getAvailableTrips();
            request.setAttribute("availableTrips", availableTrips);

            // Forward back to the form with results
            request.getRequestDispatcher("/calculatefare.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid trip selection");
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error calculating fare: " + e.getMessage());
            doGet(request, response);
        }
    }
}