package com.bus_ticketing_system.controller;

import com.bus_ticketing_system.dao.CityDao;
import com.bus_ticketing_system.dao.TripDao;
import com.bus_ticketing_system.model.Trip;
import com.bus_ticketing_system.model.User;
import com.bus_ticketing_system.strategy.FareCalculationContext;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;


import java.io.IOException;
import java.sql.SQLException;
//
//@WebServlet("/calculate-fare")
//public class CalculateFareServlet extends HttpServlet {
//    private TripDao tripDao = new TripDao();
//    private CityDao cityDao = new CityDao();
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // Fetch cities and forward to JSP
//        try {
//            request.setAttribute("cities", cityDao.getAllCities());
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//        request.getRequestDispatcher("/calculatefare.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        try {
//            int originId = Integer.parseInt(request.getParameter("origin"));
//            int destinationId = Integer.parseInt(request.getParameter("destination"));
//            String ticketType = request.getParameter("ticketType");
//            boolean isEvening = request.getParameter("isEvening") != null;
//
//            Trip trip = tripDao.getTripBetweenCities(originId, destinationId);
//            User user = (User) request.getSession().getAttribute("user");
//
//            FareCalculationContext context = new FareCalculationContext();
//            double finalFare = context.calculateFare(trip, user, ticketType, isEvening);
//
//            JSONObject jsonResponse = new JSONObject();
//            jsonResponse.put("baseFare", trip.getBaseFare());
//            jsonResponse.put("discount", (trip.getBaseFare() - finalFare) / trip.getBaseFare() * 100);
//            jsonResponse.put("finalFare", finalFare);
//
//            response.setContentType("application/json");
//            response.getWriter().write(jsonResponse.toString());
//
//        } catch (Exception e) {
//            JSONObject errorResponse = new JSONObject();
//            errorResponse.put("error", "Error calculating fare: " + e.getMessage());
//            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
//            response.getWriter().write(errorResponse.toString());
//        }
//    }
//}