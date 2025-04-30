package com.backrooms.controller;

import java.util.Map;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.backrooms.dto.HotelDTO;
import com.backrooms.dto.HotelRoomDTO;
import com.backrooms.dto.MemberDTO;
import com.backrooms.dto.PayDTO;
import com.backrooms.dto.ReservationDTO;
import com.backrooms.service.HotelRoomService;
import com.backrooms.service.HotelService;
import com.backrooms.service.PayService;
import com.backrooms.service.ReservationService;

import jakarta.servlet.http.HttpSession;

@Controller
public class Reservation {

    @Autowired
    HotelService hservice;

    @Autowired
    HotelRoomService hrservice;

    @Autowired
    ReservationService rservice;

    @Autowired
    PayService pservice;

    @PostMapping("/Reservation")
    public ModelAndView reservation(@RequestParam Map<String, String> params, HttpSession session) {
        int hotelNum = Integer.parseInt(params.get("hotelNum"));
        int roomNum = Integer.parseInt(params.get("roomNum"));
        String checkIn = params.get("checkIn");
        String checkOut = params.get("checkOut");

        long nights = hservice.calculateStayDays(checkIn, checkOut);
        String checkInDisp = hservice.toKorDate(checkIn);
        String checkOutDisp = hservice.toKorDate(checkOut);

        Map<String, Object> parameterMap = hservice.createParameterMap(hotelNum, roomNum, checkIn, checkOut, nights, checkInDisp, checkOutDisp);
        HotelDTO hdto = hservice.selectHotel(hotelNum);
        HotelRoomDTO hrdto = hrservice.selectRoom(roomNum);
        MemberDTO mdto = (MemberDTO) session.getAttribute("member");
        String totalPrice = hservice.formatTotalPrice(hrdto.getRoomPrice(), nights);

        ModelAndView mav = new ModelAndView();
        mav.addObject("hdto", hdto);
        mav.addObject("hrdto", hrdto);
        mav.addObject("parameterMap", parameterMap);
        mav.addObject("mdto", mdto);
        mav.addObject("totalPrice", totalPrice);
        mav.setViewName("reservation");

        return mav;
    }


    @PostMapping("/goToPayment")
    public ModelAndView goToPayment(@RequestParam Map<String, String> params, HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("member");

        int hotelNum = Integer.parseInt(params.get("hotelNum"));
        int roomNum = Integer.parseInt(params.get("roomNum"));
        String checkIn = params.get("checkIn");
        String checkOut = params.get("checkOut");
        long nights = Long.parseLong(params.get("nights"));
        int roomPrice = Integer.parseInt(params.get("roomPrice"));
        int breakfast = params.containsKey("reservationbreakfast") ? 1 : 0;
        int payment = roomPrice * (int)nights;
        // 예약 정보 DB insert
        ReservationDTO rdto = new ReservationDTO();
        rdto.setMemberNum(member.getMemberNum());
        rdto.setRoomNum(roomNum);
        rdto.setCheckIn(checkIn);
        rdto.setCheckOut(checkOut);
        rdto.setReservationBreakfast(breakfast);
        rdto.setReservationState(0); // 결제 전
        
        
        
        int reservationNum = rservice.insertReservationAndGetId(rdto);

        // 결제 페이지에 넘길 정보 세팅
        HotelDTO hdto = hservice.selectHotel(hotelNum);
        HotelRoomDTO hrdto = hrservice.selectRoom(roomNum);
        String totalPrice = hservice.formatTotalPrice(roomPrice, nights);
        
        
        ModelAndView mav = new ModelAndView("payment");
        mav.addObject("reservationNum", reservationNum);
        mav.addObject("member", member);
        mav.addObject("hdto", hdto);
        mav.addObject("hrdto", hrdto);
        mav.addObject("nights", nights);
        mav.addObject("roomPrice", roomPrice);
        mav.addObject("totalPrice", totalPrice);
        mav.addObject("reservationBreakfast", breakfast);
        mav.addObject("payment", payment);
        return mav;
    }
    
   
}
