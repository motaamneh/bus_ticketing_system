package com.bus_ticketing_system.model;

import java.sql.Timestamp;

public class DiscountRule {
    private int discountId;
    private String category;
    private double discountPercentage;
    private Timestamp lastUpdated;

    public DiscountRule() {
    }

    public DiscountRule(int discountId, String category, double discountPercentage, Timestamp lastUpdated) {
        this.discountId = discountId;
        this.category = category;
        this.discountPercentage = discountPercentage;
        this.lastUpdated = lastUpdated;
    }



    public int getDiscountId() {
        return discountId;
    }

    public void setDiscountId(int discountId) {
        this.discountId = discountId;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getDiscountPercentage() {
        return discountPercentage;
    }

    public void setDiscountPercentage(double discountPercentage) {
        this.discountPercentage = discountPercentage;
    }

    public Timestamp getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Timestamp lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    @Override
    public String toString() {
        return "DiscountRule{" +
                "discountId=" + discountId +
                ", category='" + category + '\'' +
                ", discountPercentage=" + discountPercentage +
                ", lastUpdated=" + lastUpdated +
                '}';
    }


}
