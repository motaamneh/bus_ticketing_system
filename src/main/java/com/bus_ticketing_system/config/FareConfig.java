package com.bus_ticketing_system.config;

import com.bus_ticketing_system.dao.DiscountRuleDao;
import com.bus_ticketing_system.dao.FareRuleDao;
import com.bus_ticketing_system.model.DiscountRule;
import com.bus_ticketing_system.model.FareRule;
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
            discountPercentages.put("STUDENT", Double.parseDouble(studentDiscountStr));
        }
        if(seniorDiscountStr != null){
            discountPercentages.put("SENIOR", Double.parseDouble(seniorDiscountStr));
        }
        if(eventDiscountStr != null){
            discountPercentages.put("EVENING", Double.parseDouble(eventDiscountStr));
        }


    }

    public synchronized void refreshRules() {


        FareRuleDao fareRuleDao = new FareRuleDao();
        DiscountRuleDao discountRuleDao = new DiscountRuleDao();


         //Refresh fare multipliers
        for (FareRule rule : fareRuleDao.getAllFareRules()) {
            String key = rule.getTicketType() + "_" + rule.getTravelType();
            fareMultipliers.put(key, rule.getBaseMultiplier());
        }

         //Refresh discount percentages
        for (DiscountRule rule : discountRuleDao.getAllDiscountRules()) {
            discountPercentages.put(rule.getCategory().toString(), rule.getDiscountPercentage());
        }

        lastUpdated = System.currentTimeMillis();
    }

    public double getFareMultiplier(String ticketType, String travelType) {
        checkRefresh();
        String key = ticketType + "_" + travelType;
        Double multiplier = fareMultipliers.get(key);
        return multiplier != null ? multiplier : 1.0; // Default to 1.0 if not found
    }

    public double getDiscountPercentage(String category) {
        checkRefresh();
        Double percentage = discountPercentages.get(category);
        return percentage != null ? percentage : 0.0; // Default to 0.0 if not found
    }

    private void checkRefresh() {
        if (System.currentTimeMillis() - lastUpdated > UPDATE_INTERVAL) {
            refreshRules();
        }
    }



}
