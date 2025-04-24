package com.bus_ticketing_system.dao;
import com.bus_ticketing_system.model.City;
import com.bus_ticketing_system.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class CityDao {

    public int createCity(City city) throws SQLException {
        String sql = "INSERT INTO cities (city_name, country) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, city.getCityName());
            stmt.setString(2, city.getCountry());
            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating city failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    city.setCityId(generatedKeys.getInt(1));
                    return city.getCityId();
                } else {
                    throw new SQLException("Creating city failed, no ID obtained.");
                }
            }
        }

    }
    public City getCityById(int cityId) throws SQLException {
        String sql = "SELECT * FROM cities WHERE city_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, cityId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCity(rs);
                }
            }
        }

        return null;
    }
    public List<City> getAllCities() throws SQLException {
        String sql = "SELECT * FROM cities ORDER BY country, city_name";
        List<City> cities = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                cities.add(mapResultSetToCity(rs));
            }
        }

        return cities;
    }

    public List<City> searchCities(String searchTerm) throws SQLException {
        String sql = "SELECT * FROM cities WHERE city_name LIKE ? OR country LIKE ? ORDER BY country, city_name";
        List<City> cities = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String term = "%" + searchTerm + "%";
            stmt.setString(1, term);
            stmt.setString(2, term);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    cities.add(mapResultSetToCity(rs));
                }
            }
        }

        return cities;
    }


    public boolean updateCity(City city) throws SQLException {
        String sql = "UPDATE cities SET city_name = ?, country = ? WHERE city_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, city.getCityName());
            stmt.setString(2, city.getCountry());
            stmt.setInt(3, city.getCityId());

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    // Delete city
    public boolean deleteCity(int cityId) throws SQLException {
        String sql = "DELETE FROM cities WHERE city_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, cityId);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }



    private City mapResultSetToCity(ResultSet rs) throws SQLException {
        City city = new City();
        city.setCityId(rs.getInt("city_id"));
        city.setCityName(rs.getString("city_name"));
        city.setCountry(rs.getString("country"));
        return city;
    }

}
