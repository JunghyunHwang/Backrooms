package com.backrooms.controller;

import com.backrooms.dto.*;
import com.backrooms.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

@Controller
public class ReservationController {

    @Autowired
    private ReservationServiceImpl reservationService;
    @Autowired
    private HotelRoomService hotelRoomService;
    @Autowired
    private HotelQueryService hotelQService;

    @PostMapping("/Reservation")
    public ModelAndView handleReservation(@RequestParam Map<String, String> params, HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("member");

        int roomNum = Integer.parseInt(params.get("roomNum"));
        String checkIn = params.get("checkIn");
        String checkOut = params.get("checkOut");
        int breakfast = params.containsKey("reservationbreakfast") ? 1 : 0;

        ReservationDTO dto = new ReservationDTO();
        dto.setMemberNum(member.getMemberNum());
        dto.setRoomNum(roomNum);
        dto.setCheckIn(checkIn);
        dto.setCheckOut(checkOut);
        dto.setReservationBreakfast(breakfast);
        dto.setReservationState(0); // 미결제 상태

        int reservationNum = reservationService.insertReservationAndGetId(dto);

        // 결제 페이지 이동용 정보
        HotelRoomDTO hrdto = hotelRoomService.selectRoom(roomNum);
        HotelDTO hdto = hotelQService.selectHotelByRoomNum(roomNum);

        ModelAndView mav = new ModelAndView("redirect:/payment?reservationNum=" + reservationNum);
        session.setAttribute("payment_hotel", hdto);
        session.setAttribute("payment_room", hrdto);
        return mav;
    }
}
