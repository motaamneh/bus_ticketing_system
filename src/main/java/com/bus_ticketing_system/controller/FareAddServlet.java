package com.bus_ticketing_system.controller;

import com.bus_ticketing_system.dao.FareRuleDao;
import com.bus_ticketing_system.model.FareRule;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/fares/add")
public class FareAddServlet extends HttpServlet {
    private FareRuleDao fareRuleDao = new FareRuleDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String ticketType = request.getParameter("ticketType");
            String travelType = request.getParameter("travelType");
            double baseMultiplier = Double.parseDouble(request.getParameter("baseMultiplier"));

            // Validate the input matches database ENUM values
            if (!isValidTicketType(ticketType) || !isValidTravelType(travelType)) {
                throw new IllegalArgumentException("Invalid ticket type or travel type");
            }

            FareRule fareRule = new FareRule();
            fareRule.setTicketType(ticketType);
            fareRule.setTravelType(travelType);
            fareRule.setBaseMultiplier(baseMultiplier);

            if (fareRuleDao.insertFareRule(fareRule)) {
                request.getSession().setAttribute("successMessage", "Fare configuration added successfully");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to add fare configuration. Please check the values.");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/fares");
    }

    private boolean isValidTicketType(String type) {
        return type != null &&
                (type.equals("ONE_TRIP") ||
                        type.equals("DAILY_PASS") ||
                        type.equals("WEEKLY_PASS") ||
                        type.equals("MONTHLY_PASS"));
    }

    private boolean isValidTravelType(String type) {
        return type != null &&
                (type.equals("CITY") ||
                        type.equals("INTER_CITY"));
    }
}
