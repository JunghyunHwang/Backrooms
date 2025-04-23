package com.backrooms.dto;

import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

@Getter
public class Hotel {
    private final int hotelNum;
    private final String hotelName;
    private final String hotelAddress;
    private final double hotelRating;
    private final int hotelGrade;
    private final String latitude;
    private final String longitude;
    private final int breakfastPrice;
    private final int hotelImageCount;
    private final List<Room> rooms;
    private final List<String> mainImageNames;

    public Hotel(int hotelNum, String hotelName, String hotelAddress, double hotelRating, int hotelGrade, String latitude, String longitude, int hotelImageCount, int breakfastPrice) {
        this.hotelNum = hotelNum;
        this.hotelName = hotelName;
        this.hotelAddress = hotelAddress;
        this.hotelRating = hotelRating;
        this.hotelGrade = hotelGrade;
        this.latitude = latitude;
        this.longitude = longitude;
        this.hotelImageCount = hotelImageCount;
        this.breakfastPrice = breakfastPrice;
        this.rooms = new ArrayList<>();
        this.mainImageNames = new ArrayList<>();
        setHotelDetailsMainImages();
    }

    private void setHotelDetailsMainImages() {
        assert(mainImageNames.isEmpty()) : "This method should be called only in the constructor.";

        for (int i = 1; i < hotelImageCount; ++i) {
            mainImageNames.add(String.format("%s_외관%d.jpg", hotelName, i + 1));
        }

        final int ROOM_COUNT = Math.min(rooms.size(), 2);
        final int IMG_COUNT = 2;

        for (int i = 0; i < ROOM_COUNT; ++i) {
            for (int j = 0; j < IMG_COUNT; ++j) {
                mainImageNames.add(String.format("%s_%s%d.jpg", hotelName, rooms.get(j).getRoomName(), i + 1));
            }
        }
    }

    public void addRoom(Room room) {
        rooms.add(room);
    }

    public List<String> getHotelDetailsMainImages() {
        return mainImageNames;
    }
}
