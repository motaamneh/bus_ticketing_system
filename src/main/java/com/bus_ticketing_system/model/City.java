package com.bus_ticketing_system.model;

public class City {
    private int cityId;
    private String cityName;
    private String country;

    public City() {
    }

    public City(String cityName, String country) {
        this.cityName = cityName;
        this.country = country;
    }

    public int getCityId() {
        return cityId;
    }

    public void setCityId(int cityId) {
        this.cityId = cityId;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
}
