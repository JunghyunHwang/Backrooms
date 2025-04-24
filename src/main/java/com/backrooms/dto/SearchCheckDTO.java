package com.backrooms.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Alias("SearchCheckDTO")
@Data
@NoArgsConstructor// 기본생성자
@AllArgsConstructor// 매개변수 있는 생성자
public class SearchCheckDTO {
	private String hotelCity;
	private String checkIn;
	private String checkOut;
	private int guestCount;
	
}
