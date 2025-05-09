package com.bus_ticketing_system.controller;
import com.bus_ticketing_system.dao.DiscountRuleDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/fares/discounts/update")
public class DiscountServlet extends HttpServlet {
    private DiscountRuleDao discountRuleDao = new DiscountRuleDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get parameters
            double student = Double.parseDouble(request.getParameter("student"));
            double senior = Double.parseDouble(request.getParameter("senior"));
            double evening = Double.parseDouble(request.getParameter("evening"));

            // Validate
            if (student < 0 || student > 100 ||
                    senior < 0 || senior > 100 ||
                    evening < 0 || evening > 100) {
                throw new IllegalArgumentException("Discount values must be between 0-100");
            }

            // Update discounts
            boolean allSuccess = true;
            allSuccess &= discountRuleDao.updateDiscount("STUDENT", student);
            allSuccess &= discountRuleDao.updateDiscount("SENIOR", senior);
            allSuccess &= discountRuleDao.updateDiscount("EVENING", evening);

            if (allSuccess) {
                request.getSession().setAttribute("successMessage", "Discounts updated successfully");
            } else {
                request.getSession().setAttribute("errorMessage", "Some discounts failed to update");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/fares");
    }
}