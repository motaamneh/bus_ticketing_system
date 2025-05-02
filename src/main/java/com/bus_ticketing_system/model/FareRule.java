package com.bus_ticketing_system.model;

import java.sql.Timestamp;

public class FareRule {
    private int ruleId;
    private String ticketType;
    private String travelType;
    private double baseMultiplier;
    private Timestamp lastUpdated;

    public FareRule() {
    }

    public FareRule(int ruleId, String ticketType, String travelType, double baseMultiplier, Timestamp lastUpdated) {
        this.ruleId = ruleId;
        this.ticketType = ticketType;
        this.travelType = travelType;
        this.baseMultiplier = baseMultiplier;
        this.lastUpdated = lastUpdated;
    }

    public int getRuleId() {
        return ruleId;
    }

    public void setRuleId(int ruleId) {
        this.ruleId = ruleId;
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

    public double getBaseMultiplier() {
        return baseMultiplier;
    }

    public void setBaseMultiplier(double baseMultiplier) {
        this.baseMultiplier = baseMultiplier;
    }

    public Timestamp getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Timestamp lastUpdated) {
        this.lastUpdated = lastUpdated;
    }


    @Override
    public String toString() {
        return "FareRule{" +
                "ruleId=" + ruleId +
                ", ticketType='" + ticketType + '\'' +
                ", travelType='" + travelType + '\'' +
                ", baseMultiplier=" + baseMultiplier +
                ", lastUpdated=" + lastUpdated +
                '}';
    }
}
