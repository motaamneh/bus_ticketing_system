package com.bus_ticketing_system.controller;

import com.bus_ticketing_system.dao.DiscountRuleDao;
import com.bus_ticketing_system.dao.FareRuleDao;
import com.bus_ticketing_system.model.DiscountRule;
import com.bus_ticketing_system.model.FareRule;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/fares")
public class FareConfigServlet extends HttpServlet {
    private FareRuleDao fareRuleDao = new FareRuleDao();
    private DiscountRuleDao discountRuleDao = new DiscountRuleDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get all fare rules grouped by travel type
            List<FareRule> cityFares = fareRuleDao.getFaresByTravelType("CITY");
            List<FareRule> intercityFares = fareRuleDao.getFaresByTravelType("INTER_CITY");

            // Get all discount rules
            Map<String, Double> discounts = new HashMap<>();
            List<DiscountRule> discountRules = discountRuleDao.getAllDiscountRules();


            // Convert list to map
            for (DiscountRule rule : discountRules) {
                discounts.put(rule.getCategory().toLowerCase(), rule.getDiscountPercentage());
            }

//            discounts.put("regular", discountRuleDao.getDiscountRuleByCategory("regular").getDiscountPercentage());
//            discounts.put("student", discountRuleDao.getDiscountRuleByCategory("student").getDiscountPercentage());

            // Set default discounts if empty
            if (discounts.isEmpty()) {
                discounts.put("regular", 0.0);
                discounts.put("student", 20.0);
                discounts.put("senior", 30.0);
                discounts.put("evening", 15.0);
            }

            // Set attributes for JSP
            request.setAttribute("cityFares", cityFares);
            request.setAttribute("intercityFares", intercityFares);
            request.setAttribute("discounts", discounts);

            // Forward to JSP
            request.getRequestDispatcher("/fareconfiguration.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error loading fare configuration", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("updateFare".equals(action)) {
                updateFareRule(request);
                request.getSession().setAttribute("successMessage", "Fare rule updated successfully");
            } else if ("updateDiscounts".equals(action)) {
                updateDiscountRules(request);
                request.getSession().setAttribute("successMessage", "Discount rules updated successfully");
            }

            response.sendRedirect(request.getContextPath() + "/admin/fares");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/fares");
        }
    }

    private void updateFareRule(HttpServletRequest request) throws Exception {
        int ruleId = Integer.parseInt(request.getParameter("fareId"));
        String ticketType = request.getParameter("ticketType");
        String travelType = request.getParameter("travelType");
        double baseMultiplier = Double.parseDouble(request.getParameter("baseMultiplier"));

        FareRule fareRule = new FareRule();
        fareRule.setRuleId(ruleId);
        fareRule.setTicketType(ticketType);
        fareRule.setTravelType(travelType);
        fareRule.setBaseMultiplier(baseMultiplier);

        if (!fareRuleDao.updateBaseMultiplier(ticketType, travelType, baseMultiplier)) {
            throw new Exception("Failed to update fare rule");
        }
    }

    private void updateDiscountRules(HttpServletRequest request) throws Exception {
        double regular = Double.parseDouble(request.getParameter("regular"));
        double student = Double.parseDouble(request.getParameter("student"));
        double senior = Double.parseDouble(request.getParameter("senior"));
        double evening = Double.parseDouble(request.getParameter("evening"));

        if (!discountRuleDao.updateDiscountPercentage("regular", regular) ||
                !discountRuleDao.updateDiscountPercentage("student", student) ||
                !discountRuleDao.updateDiscountPercentage("senior", senior) ||
                !discountRuleDao.updateDiscountPercentage("evening", evening)) {
            throw new Exception("Failed to update one or more discount rules");
        }
    }
}
