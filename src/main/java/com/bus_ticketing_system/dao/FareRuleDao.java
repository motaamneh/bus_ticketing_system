package com.bus_ticketing_system.dao;

import com.bus_ticketing_system.model.FareRule;
import com.bus_ticketing_system.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static java.lang.String.valueOf;

public class FareRuleDao {
    public boolean insertFareRule(FareRule fareRule) {
        String sql = "INSERT INTO fare_rules (ticket_type, travel_type, base_multiplier) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, fareRule.getTicketType());
            stmt.setString(2, fareRule.getTravelType());
            stmt.setBigDecimal(3, BigDecimal.valueOf(fareRule.getBaseMultiplier()));

            return stmt.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            // Log the specific error
            System.err.println("SQL Error: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Vendor Error: " + e.getErrorCode());
        }
        return false;
    }
    public FareRule getFareRuleById(int ruleId) {
        String sql = "SELECT * FROM fare_rules WHERE rule_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, ruleId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractFareRuleFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
    public List<FareRule> getFaresByTravelType(String travelType){
        List<FareRule> fareRules = new ArrayList<>();
        String sql = "SELECT * FROM fare_rules WHERE travel_type = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, travelType);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                fareRules.add(extractFareRuleFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return fareRules;
    }

    public FareRule getFareRule(String ticketType,String travelType) {
        String sql = "SELECT * FROM fare_rules WHERE ticket_type = ? AND travel_type = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, ticketType);
            stmt.setString(2, travelType);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractFareRuleFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<FareRule> getAllFareRules() {
        List<FareRule> fareRules = new ArrayList<>();
        String sql = "SELECT * FROM fare_rules";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                fareRules.add(extractFareRuleFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return fareRules;
    }

    public boolean updateBaseMultiplier(String ticketType, String travelType, double baseMultiplier) {
        String sql = "UPDATE fare_rules SET base_multiplier = ? WHERE ticket_type = ? AND travel_type = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDouble(1, baseMultiplier);
            stmt.setString(2, ticketType);
            stmt.setString(3, travelType);

            return stmt.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private FareRule extractFareRuleFromResultSet(ResultSet rs) throws SQLException {
        FareRule fareRule = new FareRule();
        fareRule.setRuleId(rs.getInt("rule_id"));
        fareRule.setTicketType(rs.getString("ticket_type"));
        fareRule.setTravelType(rs.getString("travel_type"));
        fareRule.setBaseMultiplier(rs.getDouble("base_multiplier"));
        fareRule.setLastUpdated(rs.getTimestamp("last_updated"));
        return fareRule;
    }
}
