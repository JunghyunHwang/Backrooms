package com.backrooms.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.backrooms.dto.ReviewDTO;

public interface ReviewDAO {
	public abstract int reviewAdd(SqlSessionTemplate session, ReviewDTO dto);
	public abstract List<ReviewDTO> reviewSelect(SqlSessionTemplate session, int memberNum);
	public abstract List<ReviewDTO> reviewSelectRoom(SqlSessionTemplate session, List<Integer> roomNums);
	public abstract int reviewDelete(SqlSessionTemplate session, String reviewNum);
	public abstract int getHotelNumByRoomNum(SqlSessionTemplate session, int roomNum);
	
}
