package com.backrooms.service;

import java.util.List;

import com.example.dto.HotelRoomDTO;
import com.example.dto.ReviewDTO;


public interface ReviewService {
	public abstract int reviewAdd(ReviewDTO dto);
	public abstract List<ReviewDTO> reviewSelect(int memberNum);
	public abstract List<ReviewDTO> reviewSelectRoom(List<HotelRoomDTO> availableRooms);
	public abstract int DelReview(String reviewNum);
	public abstract int getHotelNumByRoomNum(int roomNum);
}
