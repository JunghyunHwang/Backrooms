package com.backrooms.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.backrooms.dto.ReviewDTO;

@Repository
public class ReviewDAOImpl implements ReviewDAO{
	
	public int reviewAdd(SqlSessionTemplate template, ReviewDTO dto) {
		int n = template.insert("ReviewMapper.reviewAdd", dto);
		return n;
	}
	public List<ReviewDTO> reviewSelect(SqlSessionTemplate template, int memberNum) {
		List<ReviewDTO> list = template.selectList("ReviewMapper.reviewSelect", memberNum);
		return list;
	}
	public List<ReviewDTO> reviewSelectRoom(SqlSessionTemplate template, List<Integer> roomNums) {
		List<ReviewDTO> list = template.selectList("ReviewMapper.reviewSelectRoom", roomNums);
		return list;
	}
	public int reviewDelete(SqlSessionTemplate template, String reviewNum) {
		int n = template.update("ReviewMapper.reviewDelete", reviewNum);
		return n;
	}
	public int getHotelNumByRoomNum(SqlSessionTemplate template, int roomNum) {
	    return template.selectOne("ReviewMapper.getHotelNumByRoomNum", roomNum);
	}
}
