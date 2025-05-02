package com.bus_ticketing_system.strategy;

import com.bus_ticketing_system.model.Trip;
import com.bus_ticketing_system.model.User;

public class FareCalculationContext {
    private FareCalculationStrategy strategy;

    public FareCalculationContext() {
        this.strategy = new RegularFareStrategy(); // Default strategy
    }

    public void setStrategy(FareCalculationStrategy strategy) {
        this.strategy = strategy;
    }

    public double calculateFare(Trip trip, User user, String ticketType, boolean isEveningTime) {
        return strategy.calculateFare(trip, user, ticketType, isEveningTime);
    }
}
