package com.backrooms.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Alias("HotelRoomDTO")
@Data
public class HotelRoomDTO {
    private int hotelNum;
    private String hotelName;
    private String hotelAddress;
    private double hotelRating;
    private int hotelGrade;
    private String latitude;
    private String longitude;
    private int breakfastPrice;
    private int hotelImageCount;

    private int roomNum;
    private int roomPrice;
    private String formattedPrice;
    private String roomName;
    private int capacity;
    private String roomInfo;
    private int roomImageCount;
}
