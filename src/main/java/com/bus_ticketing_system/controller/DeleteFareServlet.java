package com.bus_ticketing_system.controller;

import com.bus_ticketing_system.dao.FareRuleDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/fares/delete")
public class DeleteFareServlet extends HttpServlet {
    private FareRuleDao fareRuleDao = new FareRuleDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int ruleId = Integer.parseInt(request.getParameter("ruleId"));

            if (fareRuleDao.deleteFareRule(ruleId)) {
                request.getSession().setAttribute("successMessage", "Fare rule deleted successfully");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to delete fare rule");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/fares");
    }
}