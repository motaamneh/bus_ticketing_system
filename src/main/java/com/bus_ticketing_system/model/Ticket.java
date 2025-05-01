package com.bus_ticketing_system.model;

import java.sql.Timestamp;

public class Ticket {
    private int ticketId;
    private User user;
    private Trip trip;
    private String ticketType; // Changed from FareRule.TicketType to String
    private String travelType; // Changed from Trip.TravelType to String
    private Timestamp purchaseDate;
    private Timestamp validFrom;
    private Timestamp validUntil;
    private double baseFare;
    private double discountApplied;
    private double finalFare;
    private String status; // Changed from inner enum TicketStatus to String

    public Ticket() {
    }


    public Ticket(int ticketId, User user, Trip trip, String ticketType, String travelType, Timestamp purchaseDate, Timestamp validFrom, Timestamp validUntil, double baseFare, double discountApplied, double finalFare, String status) {
        this.ticketId = ticketId;
        this.user = user;
        this.trip = trip;
        this.ticketType = ticketType;
        this.travelType = travelType;
        this.purchaseDate = purchaseDate;
        this.validFrom = validFrom;
        this.validUntil = validUntil;
        this.baseFare = baseFare;
        this.discountApplied = discountApplied;
        this.finalFare = finalFare;
        this.status = status;
    }


    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Trip getTrip() {
        return trip;
    }

    public void setTrip(Trip trip) {
        this.trip = trip;
    }

    public String getTicketType() {
        return ticketType;
    }

    public void setTicketType(String ticketType) {
        this.ticketType = ticketType;
    }

    public String getTravelType() {
        return travelType;
    }

    public void setTravelType(String travelType) {
        this.travelType = travelType;
    }

    public Timestamp getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(Timestamp purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public Timestamp getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(Timestamp validFrom) {
        this.validFrom = validFrom;
    }

    public Timestamp getValidUntil() {
        return validUntil;
    }

    public void setValidUntil(Timestamp validUntil) {
        this.validUntil = validUntil;
    }

    public double getBaseFare() {
        return baseFare;
    }

    public void setBaseFare(double baseFare) {
        this.baseFare = baseFare;
    }

    public double getDiscountApplied() {
        return discountApplied;
    }

    public void setDiscountApplied(double discountApplied) {
        this.discountApplied = discountApplied;
    }

    public double getFinalFare() {
        return finalFare;
    }

    public void setFinalFare(double finalFare) {
        this.finalFare = finalFare;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }



}
