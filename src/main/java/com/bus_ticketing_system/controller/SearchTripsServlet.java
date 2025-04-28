package com.bus_ticketing_system.controller;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;



import com.bus_ticketing_system.dao.TripDao;
import com.bus_ticketing_system.model.Trip;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/search-trips")
public class SearchTripsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TripDao tripDao = new TripDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the search trips page for initial load
        request.getRequestDispatcher("/searchtrips.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/userlogin.jsp");
            return;
        }

        try {
            // Get form parameters
            int originCityId = Integer.parseInt(request.getParameter("originCity"));
            int destinationCityId = Integer.parseInt(request.getParameter("destinationCity"));
            String travelDateStr = request.getParameter("travelDate");
            String travelType = request.getParameter("travelType");

            // Convert string date to SQL Date
            Date travelDate = Date.valueOf(travelDateStr);

            // Search for trips using TripDao
            List<Trip> searchResults = tripDao.searchTrips(originCityId, destinationCityId, travelDate, travelType);

            // Store search results in request attribute
            request.setAttribute("searchResults", searchResults);

            // Forward back to the search page with results
            request.getRequestDispatcher("/searchtrips.jsp").forward(request, response);

        } catch (SQLException e) {
            // Handle database errors
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            // Handle input format errors
            request.setAttribute("errorMessage", "Invalid input format: " + e.getMessage());
            request.getRequestDispatcher("/searchtrips.jsp").forward(request, response);
        }
    }
}
