package com.bus_ticketing_system.dao;

import com.bus_ticketing_system.model.Ticket;
import com.bus_ticketing_system.model.Trip;
import com.bus_ticketing_system.model.User;
import com.bus_ticketing_system.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static java.lang.String.valueOf;


public class TicketDao {
    private UserDao userDao = new UserDao();
    private TripDao tripDao = new TripDao();

    public Ticket getTicketById(int id) {
        String sql = "SELECT * FROM tickets WHERE ticket_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                extractTicketFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Ticket> getTicketsByUserId(int userId) throws SQLException {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT * FROM tickets WHERE user_id = ? ORDER BY purchase_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                tickets.add(extractTicketFromResultSet(rs));
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;


    }
    public List<Ticket> getAllTickets() {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT * FROM tickets ORDER BY purchase_date DESC";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                tickets.add(extractTicketFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tickets;
    }
    public boolean insertTicket(Ticket ticket) {
        String sql = "INSERT INTO tickets (user_id, trip_id, ticket_type, travel_type, purchase_date, " +
                "valid_from, valid_until, base_fare, discount_applied, final_fare, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, ticket.getUser().getId());

            if (ticket.getTrip() != null) {
                stmt.setInt(2, ticket.getTrip().getTripId());
            } else {
                stmt.setNull(2, Types.INTEGER);
            }

            stmt.setString(3, ticket.getTicketType());
            stmt.setString(4, ticket.getTravelType());
            stmt.setTimestamp(5, ticket.getPurchaseDate());
            stmt.setTimestamp(6, ticket.getValidFrom());
            stmt.setTimestamp(7, ticket.getValidUntil());
            stmt.setDouble(8, ticket.getBaseFare());
            stmt.setDouble(9, ticket.getDiscountApplied());
            stmt.setDouble(10, ticket.getFinalFare());
            stmt.setString(11, ticket.getStatus());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 1) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    ticket.setTicketId(generatedKeys.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateTicketStatus(int ticketId, String status) {
        String sql = "UPDATE tickets SET status = ? WHERE ticket_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, ticketId);

            return stmt.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
    public List<Ticket> getTicketsByDateRange(Timestamp startDate, Timestamp endDate) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT * FROM tickets WHERE purchase_date BETWEEN ? AND ? ORDER BY purchase_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setTimestamp(1, startDate);
            stmt.setTimestamp(2, endDate);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                tickets.add(extractTicketFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tickets;
    }


    private Ticket extractTicketFromResultSet(ResultSet rs) throws SQLException {
        Ticket ticket = new Ticket();

        ticket.setTicketId(rs.getInt("ticket_id"));


        int userId = rs.getInt("user_id");
        User user = userDao.getUserById(userId);
        ticket.setUser(user);

        int tripId = rs.getInt("trip_id");
        if (!rs.wasNull()) {
            Trip trip = tripDao.getTripById(tripId);
            ticket.setTrip(trip);
        }

        ticket.setTicketType(valueOf(rs.getString("ticket_type")));
        ticket.setTravelType(valueOf(rs.getString("travel_type")));
        ticket.setPurchaseDate(rs.getTimestamp("purchase_date"));
        ticket.setValidFrom(rs.getTimestamp("valid_from"));
        ticket.setValidUntil(rs.getTimestamp("valid_until"));
        ticket.setBaseFare(rs.getDouble("base_fare"));
        ticket.setDiscountApplied(rs.getDouble("discount_applied"));
        ticket.setFinalFare(rs.getDouble("final_fare"));
        ticket.setStatus(valueOf(rs.getString("status")));


        return ticket;


    }


}
