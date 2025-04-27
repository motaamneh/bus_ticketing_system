package com.bus_ticketing_system.controller;
import com.bus_ticketing_system.dao.TripDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet("/admin/trips/delete")
public class DeleteTripServlet extends HttpServlet {
    private TripDao tripDao = new TripDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int tripId = Integer.parseInt(request.getParameter("tripId"));
            tripDao.deleteTrip(tripId);
            response.sendRedirect(request.getContextPath() + "/admin/trips");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
