package com.bus_ticketing_system.factory;

import com.bus_ticketing_system.model.Ticket;
import com.bus_ticketing_system.model.Trip;
import com.bus_ticketing_system.model.User;

import java.sql.Timestamp;
import java.util.Calendar;

public class TicketFactory {
    public static Ticket createTicket(User user, Trip trip, String ticketType, double finalFare, double discountApplied) {
        Ticket ticket = new Ticket();
        ticket.setUser(user);
        ticket.setTrip(trip);
        ticket.setTicketType(ticketType);
        ticket.setTravelType(trip.getTravelType());

        // Set purchase date to current timestamp
        Timestamp now = new Timestamp(System.currentTimeMillis());
        ticket.setPurchaseDate(now);

        // Set validity period based on ticket type
        setValidityPeriod(ticket, ticketType, trip);

        // Set fare details
        ticket.setBaseFare(trip.getBaseFare());
        ticket.setDiscountApplied(discountApplied);
        ticket.setFinalFare(finalFare);

        // Set initial status
        ticket.setStatus("ACTIVE");  // Changed from Ticket.TicketStatus.ACTIVE

        return ticket;
    }

    private static void setValidityPeriod(Ticket ticket, String ticketType, Trip trip) {
        Calendar calendar = Calendar.getInstance();
        Timestamp now = new Timestamp(calendar.getTimeInMillis());

        // For ONE_TRIP tickets, valid for the specific trip time
        if ("ONE_TRIP".equalsIgnoreCase(ticketType)) {
            ticket.setValidFrom(trip.getDepartureTime());

            // Valid until 3 hours after departure (assumed maximum journey time)
            calendar.setTimeInMillis(trip.getDepartureTime().getTime());
            calendar.add(Calendar.HOUR, 3);
            ticket.setValidUntil(new Timestamp(calendar.getTimeInMillis()));
        }
        // For passes, valid from purchase time
        else {
            ticket.setValidFrom(now);

            calendar.setTimeInMillis(now.getTime());

            // Add validity period based on ticket type
            if ("DAILY_PASS".equalsIgnoreCase(ticketType)) {
                calendar.add(Calendar.DAY_OF_MONTH, 1);
            } else if ("WEEKLY_PASS".equalsIgnoreCase(ticketType)) {
                calendar.add(Calendar.DAY_OF_MONTH, 7);
            } else if ("MONTHLY_PASS".equalsIgnoreCase(ticketType)) {
                calendar.add(Calendar.MONTH, 1);
            }

            // Set valid until midnight of the last day
            calendar.set(Calendar.HOUR_OF_DAY, 23);
            calendar.set(Calendar.MINUTE, 59);
            calendar.set(Calendar.SECOND, 59);

            ticket.setValidUntil(new Timestamp(calendar.getTimeInMillis()));
        }
    }
}
