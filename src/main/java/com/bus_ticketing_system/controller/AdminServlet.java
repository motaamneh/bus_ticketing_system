package com.bus_ticketing_system.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getRequestURI().substring(request.getContextPath().length());

        if(path.equals("/admin/") || path.equals("/admin/dashboard")) {
            // Verify admin role
            HttpSession session = request.getSession(false);
            if(session != null && "admin".equals(session.getAttribute("role"))) {
                request.getRequestDispatcher("/admindashboard.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
