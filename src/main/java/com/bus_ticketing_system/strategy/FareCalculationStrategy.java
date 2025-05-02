package com.bus_ticketing_system.strategy;

import com.bus_ticketing_system.model.Ticket;
import com.bus_ticketing_system.model.Trip;
import com.bus_ticketing_system.model.User;

public interface FareCalculationStrategy {
    double calculateFare(Trip trip, User user, String ticketType, boolean isEveningTime);
}
