package com.bus_ticketing_system.dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.bus_ticketing_system.model.City;
import com.bus_ticketing_system.model.Trip;
import com.bus_ticketing_system.util.DBConnection;

import static java.lang.String.valueOf;


public class TripDao {
    private CityDao cityDao= new CityDao();


    public Trip getTripById(int tripId) {
        String sql = "SELECT * FROM trips WHERE trip_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, tripId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractTripFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Trip> getAllTrips() {
        List<Trip> trips = new ArrayList<>();
        String sql = "SELECT * FROM trips";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                trips.add(extractTripFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return trips;
    }

    public List<Trip> searchTrips(int originCityId, int destinationCityId, String travelType, Date travelDate) {
        List<Trip> trips = new ArrayList<>();
        String sql = "SELECT * FROM trips WHERE origin_city_id = ? AND destination_city_id = ? " +
                "AND travel_type = ? AND DATE(departure_time) = ? AND active = TRUE AND available_seats > 0";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, originCityId);
            stmt.setInt(2, destinationCityId);
            stmt.setString(3, travelType.toString());
            stmt.setDate(4, travelDate);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                trips.add(extractTripFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return trips;
    }

    public boolean insertTrip(Trip trip) {
        String sql = "INSERT INTO trips (origin_city_id, destination_city_id, departure_time, arrival_time, " +
                "travel_type, total_seats, available_seats, base_fare, active) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, trip.getOriginCityId());
            stmt.setInt(2, trip.getDestinationCityId());
            stmt.setTimestamp(3, trip.getDepartureTime());
            stmt.setTimestamp(4, trip.getArrivalTime());
            stmt.setString(5, trip.getTravelType());
            stmt.setInt(6, trip.getTotalSeats());
            stmt.setInt(7, trip.getAvailableSeats());
            stmt.setDouble(8, trip.getBaseFare());
            stmt.setBoolean(9, trip.isActive());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 1) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    trip.setTripId(generatedKeys.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateTrip(Trip trip) {
        String sql = "UPDATE trips SET origin_city_id = ?, destination_city_id = ?, departure_time = ?, " +
                "arrival_time = ?, travel_type = ?, total_seats = ?, available_seats = ?, " +
                "base_fare = ?, active = ? WHERE trip_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, trip.getOriginCity().getCityId());
            stmt.setInt(2, trip.getDestinationCity().getCityId());
            stmt.setTimestamp(3, trip.getDepartureTime());
            stmt.setTimestamp(4, trip.getArrivalTime());
            stmt.setString(5, trip.getTravelType().toString());
            stmt.setInt(6, trip.getTotalSeats());
            stmt.setInt(7, trip.getAvailableSeats());
            stmt.setDouble(8, trip.getBaseFare());
            stmt.setBoolean(9, trip.isActive());
            stmt.setInt(10, trip.getTripId());

            return stmt.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean decrementAvailableSeats(int tripId) {
        String sql = "UPDATE trips SET available_seats = available_seats - 1 " +
                "WHERE trip_id = ? AND available_seats > 0";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, tripId);
            return stmt.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public synchronized boolean bookSeat(int tripId) {
        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement updateStmt = null;
        ResultSet rs = null;
        boolean success = false;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Check if seats are available
            String checkSql = "SELECT available_seats FROM trips WHERE trip_id = ? FOR UPDATE";
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, tripId);
            rs = checkStmt.executeQuery();

            if (rs.next() && rs.getInt("available_seats") > 0) {
                // Update available seats
                String updateSql = "UPDATE trips SET available_seats = available_seats - 1 WHERE trip_id = ?";
                updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setInt(1, tripId);
                updateStmt.executeUpdate();

                conn.commit();
                success = true;
            } else {
                conn.rollback();
            }
        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (checkStmt != null) checkStmt.close();
                if (updateStmt != null) updateStmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return success;
    }

    public boolean deleteTrip(int tripId) {
        String sql = "DELETE FROM trips WHERE trip_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, tripId);
            return stmt.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Trip> filterTrips(Integer originCityId, Integer destinationCityId, String travelType) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT * FROM trips WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (originCityId != null) {
            sql.append(" AND origin_city_id = ?");
            params.add(originCityId);
        }
        if (destinationCityId != null) {
            sql.append(" AND destination_city_id = ?");
            params.add(destinationCityId);
        }
        if (travelType != null && !travelType.isEmpty()) {
            sql.append(" AND travel_type = ?");
            params.add(travelType);
        }
        sql.append(" ORDER BY departure_time");

        List<Trip> trips = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Trip trip = extractTripFromResultSet(rs);
                    City originCity = cityDao.getCityById(trip.getOriginCityId());
                    City destinationCity = cityDao.getCityById(trip.getDestinationCityId());
                    trip.setOriginCity(originCity);
                    trip.setDestinationCity(destinationCity);
                    trips.add(trip);
                }
            }
        }
        return trips;
    }

    public List<Trip> searchTrips(int originCityId, int destinationCityId,
                                  Date travelDate, String travelType)throws SQLException{
        String sql = "SELECT * FROM trips WHERE origin_city_id = ? AND destination_city_id = ? " +
                "AND travel_type = ? AND DATE(departure_time) = ? AND available_seats > 0 " +
                "ORDER BY departure_time";

        List<Trip> trips = new ArrayList<>();
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, originCityId);
            stmt.setInt(2, destinationCityId);
            stmt.setString(3, travelType);
            stmt.setDate(4, travelDate);

            try(ResultSet rs = stmt.executeQuery()) {
                while(rs.next()){
                    Trip trip = extractTripFromResultSet(rs);
                    City originCity = cityDao.getCityById(trip.getOriginCityId());
                    City destinationCity = cityDao.getCityById((trip.getDestinationCityId()));
                    trip.setOriginCity(originCity);
                    trip.setDestinationCity(destinationCity);
                    trips.add(trip);

                }
            }

        }
        return trips;

    }

    private Trip extractTripFromResultSet(ResultSet rs) throws SQLException {
        Trip trip = new Trip();
        trip.setTripId(rs.getInt("trip_id"));

        // Get origin and destination cities
        City originCity = cityDao.getCityById(rs.getInt("origin_city_id"));
        City destinationCity = cityDao.getCityById(rs.getInt("destination_city_id"));

        trip.setOriginCity(originCity);
        trip.setDestinationCity(destinationCity);
        trip.setDepartureTime(rs.getTimestamp("departure_time"));
        trip.setArrivalTime(rs.getTimestamp("arrival_time"));
        trip.setTravelType(valueOf(rs.getString("travel_type")));
        trip.setTotalSeats(rs.getInt("total_seats"));
        trip.setAvailableSeats(rs.getInt("available_seats"));
        trip.setBaseFare(rs.getDouble("base_fare"));
        trip.setActive(rs.getBoolean("active"));

        return trip;
    }





}
