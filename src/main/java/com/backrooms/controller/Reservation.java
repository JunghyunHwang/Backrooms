package com.backrooms.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.backrooms.dto.HotelDTO;
import com.backrooms.dto.HotelRoomDTO;
import com.backrooms.dto.MemberDTO;
import com.backrooms.service.HotelRoomService;
import com.backrooms.service.HotelService;

import jakarta.servlet.http.HttpSession;

@Controller
public class Reservation {
	
	@Autowired
	HotelService hservice;
	@Autowired
	HotelRoomService hrservice;

	
	 
	@PostMapping("/Reservation")
	public ModelAndView reservation(@RequestParam Map<String, String> params,HttpSession session) {
		int hotelNum = Integer.parseInt(params.get("hotelNum"));
	    int roomNum = Integer.parseInt(params.get("roomNum"));
	    String checkIn = params.get("checkIn");
	    String checkOut = params.get("checkOut");
		//숙박계산
	    long nights = hservice.calculateStayDays(checkIn, checkOut);
	    //체크인, 체크아웃 년월일 나오게
	    String checkInDisp  = hservice.toKorDate(checkIn);
	    String checkOutDisp = hservice.toKorDate(checkOut);
	    
		Map<String, Object> parameterMap = hservice.createParameterMap(hotelNum, roomNum, checkIn, 
				checkOut, nights, checkInDisp, checkOutDisp);
		//DTO 담기
		HotelDTO hdto = hservice.selectHotel(hotelNum);
		HotelRoomDTO hrdto = hrservice.selectRoom(roomNum);
		MemberDTO mdto = (MemberDTO) session.getAttribute("member");
		//액수에 (,) 넣기
		String totalPrice = hservice.formatTotalPrice(hrdto.getRoomPrice(), nights);
	    
		ModelAndView mav= new ModelAndView();
		mav.addObject("hdto", hdto);
		mav.addObject("hrdto", hrdto);
		mav.addObject("parameterMap", parameterMap);
		mav.addObject("mdto", mdto);
	    mav.addObject("totalPrice", totalPrice);
		mav.setViewName("reservation");
		
		return mav;
	}
	
}
