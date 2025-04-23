package com.backrooms.dto;

import java.util.Arrays;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Alias("SearchArrDTO")
@Data
@NoArgsConstructor// 기본생성자
@AllArgsConstructor// 매개변수 있는 생성자
public class SearchArrDTO {
	
	String name;
	String price;
	int hotelNum;
	int grade;
	double rating;
	
}
