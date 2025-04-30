package com.bus_ticketing_system.config;

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
        

    }



}
