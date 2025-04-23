package com.backrooms.service;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.ReviewDAO;
import com.example.dto.HotelRoomDTO;
import com.example.dto.ReviewDTO;

@Service
public class ReviewServiceImpl implements ReviewService{
	@Autowired
	ReviewDAO dao;
	
	@Transactional
	public int reviewAdd(ReviewDTO dto) {
		int n = dao.reviewAdd(dto);
		return n;
	}
	
	public List<ReviewDTO> reviewSelect(int memberNum) {
		List<ReviewDTO> list = dao.reviewSelect(memberNum);
		return list;
	}
	
	public List<ReviewDTO> reviewSelectRoom(List<HotelRoomDTO> availableRooms) {
		List<Integer> roomNums= new ArrayList<Integer>(availableRooms.size());
		for (HotelRoomDTO r : availableRooms) {
			roomNums.add(r.getRoomNum());
		}
		
		List<ReviewDTO> list = dao.reviewSelectRoom(roomNums);
		return list;
	}
	@Transactional
	public int DelReview(String reviewNum) {
		int n = dao.reviewDelete(reviewNum);
		return n;
	}
	
	public int getHotelNumByRoomNum(int roomNum) {
		int hotelNum = dao.getHotelNumByRoomNum(roomNum);
		return hotelNum;
	}
}
