package com.backrooms.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.backrooms.dto.MemberDTO;
import com.backrooms.dto.MyReservationDTO;
import com.backrooms.service.MyReservationService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MyPageController {

    @Autowired
    private MyReservationService reservationService;

    @GetMapping("/MyPage")
    public String myPageUI(
            @RequestParam(value = "myPage", required = false) String myPage,
            HttpSession session,
            Model model) {
        
        System.out.println("myPageUI: " + myPage);
        model.addAttribute("myPage", myPage);  // 탭 종류 유지

        MemberDTO member = (MemberDTO) session.getAttribute("member");
        if (member == null) {
            return "redirect:/login";
        }

        if ("reservation".equals(myPage)) {
            List<MyReservationDTO> reservationList = reservationService.getReservationsByMemberNum(member.getMemberNum());
            model.addAttribute("reservationList", reservationList);  // JSP에서 사용
        }

        return "myPage";  // 공통 마이페이지 JSP
    }
    
    
    @PostMapping("/CancelReservation")
    @ResponseBody
    public String cancelReservation(@RequestBody Map<String, Integer> body) {
        int reservationNum = body.get("reservationNum");
        System.out.println("요청받은 예약번호: " + reservationNum); // 로그 확인용
        int result = reservationService.cancelReservation(reservationNum);
        System.out.println("업데이트 결과: " + result); // 로그 확인용
        return result > 0 ? "success" : "fail";
    }
    
}
