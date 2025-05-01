// PayController.java
package com.backrooms.controller;

import java.io.File;
import java.util.Date;
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
import com.backrooms.dto.PayDTO;
import com.backrooms.dto.ReservationDTO;
import com.backrooms.service.HotelQueryService;
import com.backrooms.service.HotelRoomService;
import com.backrooms.service.HotelService;
import com.backrooms.service.PayService;
import com.backrooms.service.ReservationService;
import com.backrooms.service.ReservationServiceImpl;

import jakarta.servlet.http.HttpSession;

@Controller
public class PayController {

    @Autowired
    private ReservationServiceImpl rservice;

    @Autowired
    private HotelRoomService hrservice;

    @Autowired
    private PayService pservice;
    
    @Autowired
    private HotelQueryService hqservice;
    
    @Autowired
    private HotelService hservice;
    
    @GetMapping("/payment")
    public ModelAndView showPaymentPage(@RequestParam("reservationNum") int reservationNum, HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        if (member == null) {
            return new ModelAndView("redirect:/login");
        }

        // 예약 정보 조회
        ReservationDTO rdto = rservice.getReservationById(reservationNum);
        HotelRoomDTO hrdto = hrservice.selectRoom(rdto.getRoomNum());
        HotelDTO hdto = hqservice.selectHotelByRoomNum(rdto.getRoomNum());

        // 숙박일수 및 가격 계산
        long nights = hservice.calculateStayDays(rdto.getCheckIn(), rdto.getCheckOut());
        int roomPrice = hrdto.getRoomPrice();
        int payment = (int)(roomPrice * nights);
        String formattedTotalPrice = hservice.formatTotalPrice(roomPrice, nights);

        ModelAndView mav = new ModelAndView("payment");
        mav.addObject("member", member);
        mav.addObject("reservationNum", reservationNum);
        mav.addObject("hdto", hdto);
        mav.addObject("hrdto", hrdto);
        mav.addObject("nights", nights);
        mav.addObject("roomPrice", roomPrice);
        mav.addObject("payment", payment);
        mav.addObject("totalPrice", formattedTotalPrice);
        return mav;
    }
    
    
    
    
    @PostMapping("/PaymentPage")
    public ModelAndView toPayment(@RequestParam Map<String, String> params, HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("member");

        // ReservationDTO 구성
        ReservationDTO rdto = new ReservationDTO();
        rdto.setMemberNum(member.getMemberNum());
        rdto.setRoomNum(Integer.parseInt(params.get("roomNum")));
        rdto.setCheckIn(params.get("checkIn"));
        rdto.setCheckOut(params.get("checkOut"));
        rdto.setReservationState(0); // 결제 전 상태
        rdto.setReservationBreakfast(params.containsKey("reservationbreakfast") ? 1 : 0);

        // DB에 insert, 예약번호 획득
        rservice.insertReservationAndGetId(rdto);
        int reservationNum = rdto.getReservationNum();

        int roomPrice = Integer.parseInt(params.get("roomPrice"));
        
        String checkInStr = rdto.getCheckIn().replace("-", "");
        String checkOutStr = rdto.getCheckOut().replace("-", "");
       
        long nights = hservice.calculateStayDays(checkInStr, checkOutStr);
        int payment = (int)(roomPrice * nights);

        ModelAndView mav = new ModelAndView("payment");
        mav.addObject("reservationNum", reservationNum);
        mav.addObject("member", member);
        mav.addObject("roomPrice", roomPrice);
        mav.addObject("nights", nights);
        mav.addObject("payment", payment);

        // 호텔, 객실명 등 추가 정보 필요 시 dto 조회
        mav.addObject("hrdto", hrservice.selectRoom(rdto.getRoomNum()));

        return mav;
    }

    @PostMapping("/paymentComplete")
    public ModelAndView completePayment(@RequestParam Map<String, String> params, HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        int reservationNum = Integer.parseInt(params.get("reservationNum"));
        String payMethod = params.get("payMethod");
        int payment = Integer.parseInt(params.get("payment"));

        PayDTO pay = new PayDTO();
        pay.setReservationNum(reservationNum);
        pay.setMemberNum(member.getMemberNum());
        pay.setPayment(String.valueOf(payment));
        pay.setPayMethod(payMethod);
        pay.setPayDate(new Date());
        pay.setPayState(1);

        pservice.insertPay(pay);
        pservice.updateReservationState(reservationNum);
        
        // 예약 완료 메세지 보내기 위해 Service로 필요 데이터 보내는 코드
        // 필요 데이터 PayDTO, 회원 이메일, 예약 날짜, 
        
        pservice.sendSimpleMailMessage(pay);

        // 예약 정보 조회
        ReservationDTO rdto = rservice.getReservationById(reservationNum);
        HotelRoomDTO hrdto = hrservice.selectRoom(rdto.getRoomNum());
        HotelDTO hdto = hqservice.selectHotelByRoomNum(rdto.getRoomNum());
        String checkInStr = rdto.getCheckIn().substring(0, 10).replace("-", "");
        String checkOutStr = rdto.getCheckOut().substring(0, 10).replace("-", "");
        long nights = hservice.calculateStayDays(checkInStr, checkOutStr);
        String totalPrice = hservice.formatTotalPrice(hrdto.getRoomPrice(), nights);

        
        
        
        
        ModelAndView mav = new ModelAndView("reservation_completed");
        mav.addObject("member", member);
        mav.addObject("reservation", rdto);
        mav.addObject("hdto", hdto);
        mav.addObject("hrdto", hrdto);
        mav.addObject("nights", nights);
        mav.addObject("totalPrice", totalPrice);

        return mav;
    }
    
    }
    
   
