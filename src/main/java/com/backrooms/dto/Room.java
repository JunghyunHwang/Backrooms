package com.backrooms.dto;

import lombok.Getter;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@Getter
public class Room {
    private final int roomNum;
    private final String name;
    private final int price;
    private final String formattedPrice;
    private final int capacity;
    private final String[] amenities;
    private final List<String> imageUrls;

    public Room(int roomNum, String roomName, int roomPrice, int capacity, String[] roomAmenities) {
        this.roomNum = roomNum;
        this.name = roomName;
        this.price = roomPrice;
        this.capacity = capacity;
        this.amenities = roomAmenities;
        this.imageUrls = new ArrayList<>();

        this.formattedPrice = NumberFormat.getNumberInstance(Locale.US).format(this.price);
    }

    public void addImageUrl(String imageUrl) {
        imageUrls.add(imageUrl);
    }
}
