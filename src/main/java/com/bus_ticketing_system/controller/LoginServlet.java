package com.bus_ticketing_system.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.bus_ticketing_system.dao.UserDao;
import com.bus_ticketing_system.model.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao = new UserDao();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        RequestDispatcher dispatcher = request.getRequestDispatcher("/userlogin.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            User user = userDao.validateUser(username, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("username", user.getUsername());

                // Normalize role to lowercase for safe comparison
                String role = user.getRole().trim().toLowerCase();
                session.setAttribute("role", role);

                System.out.println("Logged in user: " + user.getUsername() + " | Role: [" + role + "]");


                if ("admin".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else if ("passenger".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/passenger/dashboard");
                } else {
                    System.out.println("Unknown role: " + role);
                    response.sendRedirect(request.getContextPath() + "/userlogin.jsp?error=UnknownRole");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/userlogin.jsp?error=true");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/userlogin.jsp?error=server");
        }
    }

}