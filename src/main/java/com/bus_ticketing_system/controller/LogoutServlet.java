package com.bus_ticketing_system.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "logout", value = "/logout")
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public LogoutServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Invalidate the session if one exists
        HttpSession session = request.getSession(false); // false = don’t create if it doesn't exist
        if (session != null) {
            session.invalidate();
        }

        // Redirect to login page after logout
        response.sendRedirect(request.getContextPath() + "/userlogin.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // support both GET and POST logout
    }


}
