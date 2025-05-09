package com.bus_ticketing_system.dao;

import com.bus_ticketing_system.model.DiscountRule;
import com.bus_ticketing_system.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DiscountRuleDao {
    public DiscountRule getDiscountRuleById(int discountId) {
        String sql = "SELECT * FROM discount_rules WHERE discount_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, discountId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractDiscountRuleFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public DiscountRule getDiscountRuleByCategory(String category) {
        String sql = "SELECT * FROM discount_rules WHERE category = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractDiscountRuleFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<DiscountRule> getAllDiscountRules() {
        List<DiscountRule> discountRules = new ArrayList<>();
        String sql = "SELECT * FROM discount_rules";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                discountRules.add(extractDiscountRuleFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return discountRules;
    }
    public boolean updateDiscount(String category, double percentage) {
        String sql = "UPDATE discount_rules SET discount_percentage = ? WHERE category = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDouble(1, percentage);
            stmt.setString(2, category);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating discount for " + category);
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateDiscountPercentage(String category, double percentage) {
        String sql = "UPDATE discount_rules SET discount_percentage = ?, last_updated = CURRENT_TIMESTAMP WHERE category = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDouble(1, percentage);
            stmt.setString(2, category.toUpperCase());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                // No rows updated - category might not exist
                System.err.println("No rows updated for category: " + category);
                return false;
            }
            return true;
        } catch (SQLException e) {
            System.err.println("SQL Error updating discount for " + category);
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Message: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public double getDiscountPercentage(String category) {
        String sql = "SELECT discount_percentage FROM discount_rules WHERE category = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category.toUpperCase());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble("discount_percentage");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0; // Default if not found
    }

    private DiscountRule extractDiscountRuleFromResultSet(ResultSet rs) throws SQLException {
        DiscountRule discountRule = new DiscountRule();
        discountRule.setDiscountId(rs.getInt("discount_id"));
        discountRule.setCategory(rs.getString("category"));
        discountRule.setDiscountPercentage(rs.getDouble("discount_percentage"));
        discountRule.setLastUpdated(rs.getTimestamp("last_updated"));
        return discountRule;
    }
}
