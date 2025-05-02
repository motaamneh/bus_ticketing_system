package com.bus_ticketing_system.strategy;

import com.bus_ticketing_system.config.FareConfig;
import com.bus_ticketing_system.model.Trip;
import com.bus_ticketing_system.model.User;

public class RegularFareStrategy implements FareCalculationStrategy{
    @Override
    public double calculateFare(Trip trip, User user, String ticketType, boolean isEveningTime) {
        FareConfig fareConfig = FareConfig.getInstance();
        double baseFare = trip.getBaseFare();
        double multiplier = fareConfig.getFareMultiplier(ticketType, trip.getTravelType());

        double calculatedFare = baseFare * multiplier;
        double totalDiscountPercentage = 0.0;
        if ("STUDENT".equalsIgnoreCase(user.getCategory())) {
            totalDiscountPercentage += fareConfig.getDiscountPercentage("STUDENT");
        } else if ("SENIOR".equalsIgnoreCase(user.getCategory())) {
            totalDiscountPercentage += fareConfig.getDiscountPercentage("SENIOR");
        }

        if (isEveningTime && "ONE_TRIP".equalsIgnoreCase(ticketType)) {
            totalDiscountPercentage += fareConfig.getDiscountPercentage("EVENING");
        }

        // Cap total discount at 50%
        totalDiscountPercentage = Math.min(totalDiscountPercentage, 50.0);

        // Apply discount
        double discountAmount = (calculatedFare * totalDiscountPercentage) / 100.0;
        double finalFare = calculatedFare - discountAmount;

        // Round to 2 decimal places
        return Math.round(finalFare * 100.0) / 100.0;



    }
}
