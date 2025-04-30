// PayController.java
package com.backrooms.controller;

import java.io.File;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.backrooms.dto.MemberDTO;
import com.backrooms.dto.PayDTO;
import com.backrooms.dto.ReservationDTO;
import com.backrooms.service.HotelRoomService;
import com.backrooms.service.PayService;
import com.backrooms.service.ReservationService;

import jakarta.servlet.http.HttpSession;

@Controller
public class PayController {

    @Autowired
    private ReservationService rservice;

    @Autowired
    private HotelRoomService hrservice;

    @Autowired
    private PayService pservice;

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
        long nights = Long.parseLong(params.get("nights"));
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

    @PostMapping("/payment/complete")
    public ModelAndView completePayment(@RequestParam Map<String, String> params, HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("member");

        int reservationNum = Integer.parseInt(params.get("reservationNum"));
        String payMethod = params.get("payMethod");
        int payment = Integer.parseInt(params.get("payment"));
        String payment2 = payment+"";
        System.out.println(">>> 결제 요청 정보 <<<");
        System.out.println("회원번호: " + member.getMemberNum());
        System.out.println("예약번호: " + reservationNum);
        System.out.println("결제수단: " + payMethod);
        System.out.println("결제금액: " + payment);

        PayDTO pay = new PayDTO();
        pay.setReservationNum(reservationNum);
        pay.setMemberNum(member.getMemberNum());
        pay.setPayment(payment2);
        pay.setPayMethod(payMethod);
        pay.setPayDate(new Date());
        pay.setPayState(1); // 결제 완료

        pservice.insertPay(pay);
        pservice.updateReservationState(reservationNum);

        System.out.println(">>> 결제 DB 등록 완료 및 예약 상태 변경 완료");

        // 결제 완료 메시지를 포함한 완료 페이지로 이동
        ModelAndView mav = new ModelAndView("reservation_completed");
        mav.addObject("message", "결제가 완료되었습니다.");
        mav.addObject("reservationNum", reservationNum);
        
        
        System.out.println(">>> 예약 완료 페이지로 이동 예정: reservation_completed.jsp");
        File f = new File("src/main/webapp/WEB-INF/views/reservation_completed.jsp");
        System.out.println("JSP 존재 여부: " + f.exists());
        
        return mav;
    }
    
    }
    
   
