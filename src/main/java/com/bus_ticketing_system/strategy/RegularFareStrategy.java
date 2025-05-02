package com.bus_ticketing_system.strategy;

import com.bus_ticketing_system.config.FareConfig;
import com.bus_ticketing_system.model.Trip;
import com.bus_ticketing_system.model.User;

public class RegularFareStrategy implements FareCalculationStrategy{
    @Override
    public double calculateFare(Trip trip, User user, String ticketType, boolean isEveningTime) {
        FareConfig fareConfig = FareConfig.getInstance();
        //double baseFare = trip.getBa
        return 0;
    }
}
