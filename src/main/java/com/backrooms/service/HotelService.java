package com.backrooms.service;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.backrooms.dao.HotelDAO;
import com.backrooms.dto.HotelDTO;

@Service
public class HotelService {
	@Autowired 
	HotelDAO dao;

	public HotelDTO selectHotel(int hotelNum) {
		HotelDTO dto = dao.selectHotel(hotelNum);
		return dto;
	}
	
	public long calculateStayDays(String checkIn, String checkOut) {
		//체크아웃 - 체크인 = ~박 계산하는 거 만들기
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		// 문자열을 LocalDate로 변환
		LocalDate checkInDate = LocalDate.parse(checkIn.trim(), formatter);
		LocalDate checkOutDate = LocalDate.parse(checkOut.trim(), formatter);
		// 두 날짜 사이의 일수 계산
		long nights = ChronoUnit.DAYS.between(checkInDate, checkOutDate);		
		
		return nights;
	}
	
	public Map<String, Object> createParameterMap(int hotelNum, int roomNum, String checkIn, String checkOut, long nights, String checkInDisp, String checkOutDisp) {
	    Map<String, Object> parameterMap = new HashMap<>();
	    parameterMap.put("hotelNum", hotelNum);
	    parameterMap.put("roomNum", roomNum);
	    parameterMap.put("checkIn", checkIn);
	    parameterMap.put("checkOut", checkOut);
	    parameterMap.put("nights", nights);
	    parameterMap.put("checkInDisp", checkInDisp);
	    parameterMap.put("checkOutDisp", checkOutDisp);
	    return parameterMap;
	}

	public String formatTotalPrice(int RoomPrice, long nights) {
		int roomPriceValue = RoomPrice;
		long totalPrice = roomPriceValue * nights;
		
		DecimalFormat df = new DecimalFormat("#,###");
	    String formattedTotalPrice = df.format(totalPrice);
		
	    return formattedTotalPrice;
	}
	
	public String toKorDate(String yyyymmdd) {
        if (yyyymmdd == null || yyyymmdd.isBlank()) return "";

        // 로컬 변수로 포맷터 생성
        DateTimeFormatter inFmt  = DateTimeFormatter.BASIC_ISO_DATE;          // yyyyMMdd
        DateTimeFormatter outFmt = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");

        return LocalDate
                .parse(yyyymmdd.trim(), inFmt)
                .format(outFmt);
    }
	
	
}
