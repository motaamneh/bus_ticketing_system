package com.bus_ticketing_system.config;

import jakarta.servlet.ServletContext;

import java.util.HashMap;
import java.util.Map;

public class FareConfig {
    private static FareConfig instance;
    Map<String , Double> fareMultipliers;
    Map<String , Double> discountPercentages;
    private long lastUpdated;
    private static final long UPDATE_INTERVAL = 3600000;

    private FareConfig() {
        fareMultipliers = new HashMap<String , Double>();
        discountPercentages = new HashMap<String , Double>();
        refreshRules();

    }

    public static synchronized FareConfig getInstance() {
        if(instance == null) {
            instance = new FareConfig();
        }
        return instance;
    }

    public void initialize(ServletContext servletContext) {
        String studentDiscountStr = servletContext.getInitParameter("student.discount");
        String seniorDiscountStr = servletContext.getInitParameter("senior.discount");
        String eventDiscountStr = servletContext.getInitParameter("event.discount");

        if(studentDiscountStr != null){
            discountPercentages.put(studentDiscountStr, Double.parseDouble(studentDiscountStr));
        }
        if(seniorDiscountStr != null){
            discountPercentages.put(seniorDiscountStr, Double.parseDouble(seniorDiscountStr));
        }
        if(eventDiscountStr != null){
            discountPercentages.put(eventDiscountStr, Double.parseDouble(eventDiscountStr));
        }


    }





    public synchronized void refreshRules() {

    }



}
