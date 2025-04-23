package com.backrooms.service;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.backrooms.dao.ReviewDAO;
import com.backrooms.dto.HotelRoomDTO;
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
	
	public List<ReviewDTO> reviewSelectRoom(List<HotelRoomDTO> availableRooms) {
		List<Integer> roomNums= new ArrayList<Integer>(availableRooms.size());
		for (HotelRoomDTO r : availableRooms) {
			roomNums.add(r.getRoomNum());
		}
		
		List<ReviewDTO> list = dao.reviewSelectRoom(session,roomNums);
		return list;
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
