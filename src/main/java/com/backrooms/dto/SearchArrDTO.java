package com.backrooms.dto;

import java.util.Arrays;

import lombok.Getter;
import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Alias("SearchArrDTO")
@AllArgsConstructor // 매개변수 있는 생성자
@Getter
public class SearchArrDTO {
	private String name;
	private String price;
	private int hotelNum;
	private int grade;
	private double rating;
	private String hotelImageUrl;
}
