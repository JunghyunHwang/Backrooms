package com.backrooms.dto;

import lombok.Data;

@Data
public class MyReservationDTO {
    private int reservationNum;
    private int roomNum;
    private String roomName;
    private String checkIn;
    private String checkOut;
    private int reservationBreakfast;
    private int reservationState;
    // getter/setter
}