package com.backrooms.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Alias("MailDTO")
@Data
@NoArgsConstructor// 기본생성자
@AllArgsConstructor// 매개변수 있는 생성자
public class MailDTO {

    private String name; // 예약자 이메일
    private String Email; // 예약자 이메일
    private String CheckIn; // 예약 날짜
    private String CheckOut; 
    private String hotelName; 
    private String hoteladdress;
    private String roomName;
    

}
