package com.backrooms.dto;

import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

@Getter
public class Hotel {
    private final int hotelNum;
    private final String name;
    private final String address;
    private final double rating;
    private final int grade;
    private final String latitude;
    private final String longitude;
    private final int breakfastPrice;
    private final List<Room> rooms;
    private final List<String> hotelImageUrls;

    public Hotel(int hotelNum, String name, String address, double rating, int grade, String latitude, String longitude, int breakfastPrice) {
        this.hotelNum = hotelNum;
        this.name = name;
        this.address = address;
        this.rating = rating;
        this.grade = grade;
        this.latitude = latitude;
        this.longitude = longitude;
        this.breakfastPrice = breakfastPrice;
        this.rooms = new ArrayList<>();
        this.hotelImageUrls = new ArrayList<>();
    }

    public void addRoom(Room room) {
        rooms.add(room);
    }

    public void addImageUrl(String imageUrl) {
        hotelImageUrls.add(imageUrl);
    }
}
