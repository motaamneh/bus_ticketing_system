package com.bus_ticketing_system.controller;

import jakarta.servlet.RequestDispatcher;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.bus_ticketing_system.dao.UserDao;
import com.bus_ticketing_system.model.User;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet(name = "register",value = "/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDao userDao = new UserDao();

    /**
     * Default constructor.
     */
    public RegisterServlet() {
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        response.getWriter().append("Served at: ").append(request.getContextPath());
        RequestDispatcher dispatcher = request.getRequestDispatcher("/userregister.jsp");
        dispatcher.forward(request, response);


    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String category = request.getParameter("category");

        User user = new User();
        user.setFirst_name(first_name);
        user.setLast_name(last_name);
        user.setUsername(username);
        user.setPassword(password);
        user.setRole(role);
        user.setCategory(category);


        try {
            int result = userDao.registerUser(user);
            if (result > 0) {
                request.setAttribute("success", true);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/userregister.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/register?error=registration_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register?error=database_error");
        }

    }

}

