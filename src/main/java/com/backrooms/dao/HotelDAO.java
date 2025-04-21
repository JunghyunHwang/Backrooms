package com.backrooms.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.backrooms.dto.HotelDTO;

@Repository
public class HotelDAO {
	@Autowired
	private SqlSessionTemplate template;

	public HotelDTO selectHotel(int hotelNum) {
		HotelDTO dto = template.selectOne("HotelMapper.selectHotel", hotelNum);
		return dto;
	}
	
}
