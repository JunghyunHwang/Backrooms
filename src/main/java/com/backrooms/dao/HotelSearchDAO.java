package com.backrooms.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.backrooms.dto.SeachResultDTO;
import com.backrooms.dto.SearchCheckDTO;

@Repository
public class HotelSearchDAO {
	@Autowired
	private SqlSessionTemplate session;

	public List<SeachResultDTO> getAvailableRooms(SearchCheckDTO map) {
		return session.selectList("HotelSearchMapper.selectAvailableRooms", map);
	}
}
