package com.bus_ticketing_system.dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.bus_ticketing_system.model.City;
import com.bus_ticketing_system.model.Trip;
import com.bus_ticketing_system.util.DBConnection;



public class TripDao {
    private CityDao cityDao= new CityDao();

    public int createTrip(Trip trip)throws SQLException{
        String sql = "INSERT INTO trips (origin_city_id, destination_city_id, departure_time, " +
                "arrival_time, travel_type, total_seats, available_seats) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt  = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1,trip.getOriginCityId());
            stmt.setInt(2,trip.getDestinationCityId());
            stmt.setTimestamp(3, trip.getDepartureTime());
            stmt.setTimestamp(4, trip.getArrivalTime());
            stmt.setString(5, trip.getTravelType());
            stmt.setInt(6, trip.getTotalSeats());
            stmt.setInt(7, trip.getAvailableSeats());

            int affectedRows = stmt.executeUpdate();
            if(affectedRows ==0){
                throw new SQLException("Creating trip failed, no rows affected.");

            }
            try (ResultSet generatedKeys  = stmt.getGeneratedKeys()) {

                if(generatedKeys.next()){
                    trip.setTripId(generatedKeys.getInt(1));
                    return trip.getTripId();
                }else {
                    throw new SQLException("Creating trip failed, no ID obtained.");
                }
            }


        }


    }



    public Trip getTripById(int tripId)throws SQLException{
        String sql = "SELECT * FROM trips WHERE trip_id = ?";

        try(Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, tripId);
            try(ResultSet rs = stmt.executeQuery()) {
                if(rs.next()){
                    Trip trip = mapResultSetToTrip(rs);

                    City originCity = cityDao.getCityById(trip.getOriginCityId());
                    City destinationCity = cityDao.getCityById((trip.getDestinationCityId()));

                    trip.setOriginCity(originCity);
                    trip.setDestinationCity(destinationCity);

                    return trip;

                }
            }
        }


        return null;
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
                    Trip trip = mapResultSetToTrip(rs);
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

    public List<Trip> getAllTrips() throws SQLException{
        String sql = "SELECT * FROM trips ORDER BY departure_time";
        List<Trip> trips = new ArrayList<>();
        try(Connection conn = DBConnection.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql)) {
            while(rs.next()){
                Trip trip = mapResultSetToTrip(rs);
                City originCity = cityDao.getCityById(trip.getOriginCityId());
                City destinationCity = cityDao.getCityById((trip.getDestinationCityId()));
                trip.setOriginCity(originCity);
                trip.setDestinationCity(destinationCity);
                trips.add(trip);

            }
        }

        return trips;

    }

    public boolean updateTrip(Trip trip)throws SQLException{
        String sql = "UPDATE trips SET origin_city_id = ?, destination_city_id = ?, " +
                "departure_time = ?, arrival_time = ?, travel_type = ?, " +
                "total_seats = ?, available_seats = ? WHERE trip_id = ?";

        try(Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, trip.getOriginCityId());
            stmt.setInt(2, trip.getDestinationCityId());
            stmt.setTimestamp(3, trip.getDepartureTime());
            stmt.setTimestamp(4, trip.getArrivalTime());
            stmt.setString(5, trip.getTravelType());
            stmt.setInt(6, trip.getTotalSeats());
            stmt.setInt(7, trip.getAvailableSeats());
            stmt.setInt(8, trip.getTripId());
            int affectedRows = stmt.executeUpdate();

            return affectedRows > 0;
        }
    }

    public boolean deleteTrip(int tripId)throws SQLException{
        String sql = "DELETE FROM trips WHERE trip_id = ?";

        try(Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, tripId);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }






    private Trip mapResultSetToTrip(ResultSet rs) throws SQLException {
        Trip trip = new Trip();
        trip.setTripId(rs.getInt("trip_id"));
        trip.setOriginCityId(rs.getInt("origin_city_id"));
        trip.setDestinationCityId(rs.getInt("destination_city_id"));
        trip.setDepartureTime(rs.getTimestamp("departure_time"));
        trip.setArrivalTime(rs.getTimestamp("arrival_time"));
        trip.setTravelType(rs.getString("travel_type"));
        trip.setTotalSeats(rs.getInt("total_seats"));
        trip.setAvailableSeats(rs.getInt("available_seats"));
        return trip;
    }






}
