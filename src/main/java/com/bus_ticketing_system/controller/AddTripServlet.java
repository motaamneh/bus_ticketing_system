package com.bus_ticketing_system.controller;

import com.bus_ticketing_system.dao.TripDao;
import com.bus_ticketing_system.model.Trip;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/admin/trips/add")
public class AddTripServlet extends HttpServlet {
    private TripDao tripDao = new TripDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Trip trip = new Trip();
            trip.setOriginCityId(Integer.parseInt(request.getParameter("originCityId")));
            trip.setDestinationCityId(Integer.parseInt(request.getParameter("destinationCityId")));

            // Set other fields
            trip.setDepartureTime(Timestamp.valueOf(request.getParameter("departureTime").replace("T", " ") + ":00"));
            trip.setArrivalTime(Timestamp.valueOf(request.getParameter("arrivalTime").replace("T", " ") + ":00"));
            trip.setTravelType(request.getParameter("travelType").toUpperCase().replace("-", "_"));
            trip.setTotalSeats(Integer.parseInt(request.getParameter("totalSeats")));
            trip.setAvailableSeats(Integer.parseInt(request.getParameter("totalSeats")));
            trip.setBaseFare(Double.parseDouble(request.getParameter("baseFare")));
            trip.setActive(true); // New trips should be active by default

            tripDao.insertTrip(trip);
            response.sendRedirect(request.getContextPath() + "/admin/trips");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}