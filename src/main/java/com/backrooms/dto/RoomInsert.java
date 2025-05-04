package com.backrooms.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
public class RoomInsert {
    @Setter
    private int roomNum;
    @Setter
    private int hotelNum;
    private final String name;
    private final int price;
    private final int capacity;
    private final String amenities;
    private final int availableRooms;
    private final List<String> roomImageUrls;

    public RoomInsert(String name, int price, int capacity, String amenities, int availableRooms) {
        this.name = name;
        this.price = price;
        this.capacity = capacity;
        this.amenities = amenities;
        this.availableRooms = availableRooms;
        this.roomImageUrls = new ArrayList<>();
    }

    public void addImageUrl(String imageUrl) {
        roomImageUrls.add(imageUrl);
    }
}
