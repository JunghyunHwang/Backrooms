package com.backrooms.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Alias("HotelDetailRequestDTO")
@Data
public class HotelDetailRequestDTO {
    private int hotelNum;
    private int guestCount;
    private String checkIn;
    private String checkOut;
}
