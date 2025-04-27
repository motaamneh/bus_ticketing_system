package com.bus_ticketing_system.controller;

import com.bus_ticketing_system.dao.TripDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/trips")
public class TripManagementServlet extends HttpServlet {
    private TripDao tripDao = new TripDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setAttribute("trips", tripDao.getAllTrips());
            request.getRequestDispatcher("/tripmanagment.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}