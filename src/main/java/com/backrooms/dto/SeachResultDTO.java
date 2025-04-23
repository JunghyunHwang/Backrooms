package com.backrooms.dto;

import org.apache.ibatis.type.Alias;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Alias("SeachResultDTO")
@Data
@NoArgsConstructor// 기본생성자
@AllArgsConstructor// 매개변수 있는 생성자
public class SeachResultDTO {

    private String hotelName;
    private int hotelNum;
    private Double hotelRating;
    private int HotelGrade;
    private int roomNum;
    private int roomPrice;
    private int availableRooms;

}
