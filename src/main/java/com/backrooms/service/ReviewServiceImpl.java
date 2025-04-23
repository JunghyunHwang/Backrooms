package com.backrooms.service;
import java.util.ArrayList;
import java.util.List;

import com.backrooms.dto.Hotel;
import com.backrooms.dto.Room;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.backrooms.dao.ReviewDAO;
import com.backrooms.dto.ReviewDTO;


@Service
public class ReviewServiceImpl implements ReviewService{
	@Autowired
	ReviewDAO dao;
	@Autowired
	SqlSessionTemplate session;
	
	
	@Transactional
	public int reviewAdd(ReviewDTO dto) {
		int n = dao.reviewAdd(session, dto);
		return n;
	}
	
	public List<ReviewDTO> reviewSelect(int memberNum) {
		List<ReviewDTO> list = dao.reviewSelect(session,memberNum);
		return list;
	}
	
	public List<ReviewDTO> reviewSelectRoom(Hotel hotel) {
		List<Integer> roomNums= new ArrayList<>();
		for (Room r : hotel.getRooms()) {
			roomNums.add(r.getRoomNum());
		}

		return dao.reviewSelectRoom(session, roomNums);
	}
	@Transactional
	public int DelReview(String reviewNum) {
		int n = dao.reviewDelete(session, reviewNum);
		return n;
	}
	
	public int getHotelNumByRoomNum(int roomNum) {
		int hotelNum = dao.getHotelNumByRoomNum(session,roomNum);
		return hotelNum;
	}
}
