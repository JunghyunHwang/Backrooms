package com.backrooms.dto;

import lombok.Getter;
import org.eclipse.jdt.internal.compiler.batch.Main;

import java.util.ArrayList;
import java.util.List;

@Getter
public class Hotel {
    private static final int MAIN_IMAGES_COUNT = 6;
    private static final int HOTEL_IMAGE_COUNT_IN_MAIN_IMAGES = 3;
    private static final int ROOM_IMAGE_COUNT_IN_MAIN_IMAGES = 2;

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

    private boolean isSetMainImage;

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

        this.isSetMainImage = false;
        addHotelImageInMainImages();
    }

    private void addHotelImageInMainImages() {
        assert(mainImageNames.isEmpty()) : "This method should be called only in the constructor.";
        final int HOTEL_IMG_COUNT = Math.min(hotelImageCount, HOTEL_IMAGE_COUNT_IN_MAIN_IMAGES);

        for (int i = 1; i < HOTEL_IMG_COUNT; ++i) {
            mainImageNames.add(String.format("%s_외관%d.jpg", hotelName, i + 1));
        }
    }

    private void addRoomImageInMainImages(Room room) {
        assert(MAIN_IMAGES_COUNT - mainImageNames.size() > 0) : "isSetMainImage has wrong value";
        final int ROOM_IMG_COUNT = Math.min(room.getRoomImageCount(), ROOM_IMAGE_COUNT_IN_MAIN_IMAGES);
        final int LOOP_COUNT = Math.min(ROOM_IMG_COUNT, MAIN_IMAGES_COUNT - mainImageNames.size());

        for (int i = 0; i < LOOP_COUNT; ++i) {
            mainImageNames.add(String.format("%s_%s%d.jpg", hotelName, room.getRoomName(), i + 1));
        }

        assert(mainImageNames.size() <= MAIN_IMAGES_COUNT);

        if (mainImageNames.size() == MAIN_IMAGES_COUNT) {
            isSetMainImage = true;
        }
    }

    public void addRoom(Room room) {
        rooms.add(room);

        if (!isSetMainImage) {
            addRoomImageInMainImages(room);
        }
    }

    public List<String> getHotelDetailsMainImages() {
        return mainImageNames;
    }
}
