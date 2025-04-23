package com.backrooms.dto;

import lombok.Getter;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@Getter
public class Room {
    private final int roomNum;
    private final String roomName;
    private final int roomPrice;
    private final String formattedPrice;
    private final int capacity;
    private final String[] roomAmenity;
    private final int roomImageCount;

    public Room(int roomNum, String roomName, int roomPrice, int capacity, String[] roomAmenity, int roomImageCount) {
        this.roomNum = roomNum;
        this.roomName = roomName;
        this.roomPrice = roomPrice;
        this.capacity = capacity;
        this.roomAmenity = roomAmenity;
        this.roomImageCount = roomImageCount;

        this.formattedPrice = NumberFormat.getNumberInstance(Locale.US).format(this.roomPrice);
    }
}
