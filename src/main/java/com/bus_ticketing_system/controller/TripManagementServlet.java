package com.bus_ticketing_system.controller;

import com.bus_ticketing_system.dao.CityDao;
import com.bus_ticketing_system.dao.TripDao;
import com.bus_ticketing_system.model.Trip;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/trips")
public class TripManagementServlet extends HttpServlet {
    private TripDao tripDao = new TripDao();
    private CityDao cityDao = new CityDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get filter parameters
            String originParam = request.getParameter("origin");
            String destParam = request.getParameter("destination");
            String typeParam = request.getParameter("type");

            Integer originCityId = null;
            Integer destinationCityId = null;
            String travelType = null;

            if (originParam != null && !originParam.isEmpty()) {
                originCityId = Integer.parseInt(originParam);
            }
            if (destParam != null && !destParam.isEmpty()) {
                destinationCityId = Integer.parseInt(destParam);
            }
            if (typeParam != null && !typeParam.isEmpty()) {
                travelType = typeParam;
            }

            List<Trip> trips;
            if (originCityId != null || destinationCityId != null || travelType != null) {
                trips = tripDao.filterTrips(originCityId, destinationCityId, travelType);
            } else {
                trips = tripDao.getAllTrips();
            }

            request.setAttribute("trips", trips);
            request.setAttribute("cities", cityDao.getAllCities());
            request.getRequestDispatcher("/tripmanagment.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }

    }
}