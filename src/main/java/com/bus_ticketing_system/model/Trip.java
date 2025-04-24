package com.bus_ticketing_system.model;
import java.sql.Timestamp;
public class Trip {
    private int tripId;
    private int originCityId;
    private int destinationCityId;
    private Timestamp departureTime;
    private Timestamp arrivalTime;
    private String travelType;
    private int totalSeats;
    private int availableSeats;

    private City originCity;
    private City destinationCity;

    public Trip(int originCityId, int destinationCityId, Timestamp departureTime, Timestamp arrivalTime, String travelType, int totalSeats, int availableSeats) {
        this.originCityId = originCityId;
        this.destinationCityId = destinationCityId;
        this.departureTime = departureTime;
        this.arrivalTime = arrivalTime;
        this.travelType = travelType;
        this.totalSeats = totalSeats;
        this.availableSeats = availableSeats;
    }

    public int getTripId() {
        return tripId;
    }

    public void setTripId(int tripId) {
        this.tripId = tripId;
    }

    public int getOriginCityId() {
        return originCityId;
    }

    public void setOriginCityId(int originCityId) {
        this.originCityId = originCityId;
    }

    public int getDestinationCityId() {
        return destinationCityId;
    }

    public void setDestinationCityId(int destinationCityId) {
        this.destinationCityId = destinationCityId;
    }

    public Timestamp getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(Timestamp departureTime) {
        this.departureTime = departureTime;
    }

    public Timestamp getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(Timestamp arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public String getTravelType() {
        return travelType;
    }

    public void setTravelType(String travelType) {
        this.travelType = travelType;
    }

    public int getTotalSeats() {
        return totalSeats;
    }

    public void setTotalSeats(int totalSeats) {
        this.totalSeats = totalSeats;
    }

    public int getAvailableSeats() {
        return availableSeats;
    }

    public void setAvailableSeats(int availableSeats) {
        this.availableSeats = availableSeats;
    }

    public City getOriginCity() {
        return originCity;
    }

    public void setOriginCity(City originCity) {
        this.originCity = originCity;
    }

    public City getDestinationCity() {
        return destinationCity;
    }

    public void setDestinationCity(City destinationCity) {
        this.destinationCity = destinationCity;
    }

    @Override
    public String toString() {
        return "Trip{" +
                "tripId=" + tripId +
                ", originCityId=" + originCityId +
                ", destinationCityId=" + destinationCityId +
                ", departureTime=" + departureTime +
                ", arrivalTime=" + arrivalTime +
                ", travelType='" + travelType + '\'' +
                ", totalSeats=" + totalSeats +
                ", availableSeats=" + availableSeats +
                ", originCity=" + originCity +
                ", destinationCity=" + destinationCity +
                '}';
    }
}
