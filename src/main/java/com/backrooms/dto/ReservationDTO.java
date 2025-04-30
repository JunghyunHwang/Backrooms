package com.backrooms.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Alias("ReservationDTO")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReservationDTO {
    private int reservationNum;     // 예약 번호 (시퀀스용)
    private int roomNum;
    private int memberNum;
    private String checkIn;
    private String checkOut;
    private int reservationBreakfast;
    private int reservationState;   // 0: 결제 전, 1: 결제 완료
    private String totalPrice;
	

}
