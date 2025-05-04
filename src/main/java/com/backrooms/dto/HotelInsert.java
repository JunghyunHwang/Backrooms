package com.backrooms.dto;

import lombok.Getter;
import java.util.List;

@Getter
public class HotelInsert {
    private final String name;
    private final double rating;
    private final double grade;
    private final String address;
    private final String cityName;
    private final String latitude;
    private final String longitude;
    private final int breakfastPrice;
    private final List<String> exteriorImageUrls;
    private final List<RoomInsert> roomInserts;

    public HotelInsert(String name, double rating, double grade, String address, String cityName, String latitude, String longitude, int breakfastPrice, List<String> exteriorImageUrls, List<RoomInsert> roomInserts) {
        this.name = name;
        this.rating = rating;
        this.grade = grade;
        this.address = address;
        this.cityName = cityName;
        this.latitude = latitude;
        this.longitude = longitude;
        this.breakfastPrice = breakfastPrice;
        this.exteriorImageUrls = exteriorImageUrls;
        this.roomInserts = roomInserts;
    }
}