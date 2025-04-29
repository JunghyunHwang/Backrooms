package com.backrooms.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.backrooms.dto.ReviewDTO;
import com.backrooms.service.ReviewService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReviewController {
	@Autowired
	ReviewService service;
	
	@GetMapping("/myReview")
	public ModelAndView MyReview(HttpSession session) {
//		MemberDTO mdto = (MemberDTO) session.getAttribute("member");
//		int memberNum = mdto.getMemberNum();
		List<ReviewDTO> list = service.reviewSelect(1);
		ModelAndView mav = new ModelAndView();
		mav.addObject("myReview",list);
		mav.setViewName("myReviewPage");
		return mav;
	}
	@PostMapping(path = "/UploadReview")
	public ModelAndView WriteReveiw(ReviewDTO dto, HttpSession session, HttpServletResponse response) throws IOException {
		
		System.out.println(dto);
		int list = service.reviewAdd(dto);
		System.out.println("insert: "+list);
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (list > 0) { // 서비스 메서드가 1 이상의 값을 반환했다면 (일반적으로 삽입 성공 시 1 반환)
            System.out.println("리뷰 삽입 성공. 부모 창 새로고침 및 자식 창 닫기 스크립트 응답");
            out.println("<script>");
            out.println("alert('리뷰가 성공적으로 등록되었습니다.');"); // 사용자에게 알림 (선택 사항)
            out.println("if (window.opener) {");
            out.println("  window.opener.location.reload();"); // 부모 창 새로고침
            out.println("}");
            out.println("window.close();"); // 자식 창 닫기
            out.println("</script>");
        } else { // 서비스 메서드가 0 또는 음수를 반환했다면 (삽입 실패)
             System.err.println("리뷰 삽입 실패. 실패 알림 스크립트 응답");
             out.println("<script>");
             out.println("alert('리뷰 등록에 실패했습니다. 다시 시도해주세요.');"); // 실패 알림
             // 실패 시 창을 닫을 수도 있습니다. out.println("window.close();");
             // 또는 에러 페이지로 리다이렉트하거나 다른 처리를 할 수 있습니다.
             out.println("</script>");
        }
        out.flush(); // 응답 버퍼를 비워 클라이언트에게 즉시 전송
		ModelAndView mav = new ModelAndView();
		mav.setViewName("writeReview");
		return mav;
	}
	@GetMapping(path = "/WriteReview")
	public String WriteReveiw(HttpSession session) {
		return "writeReview";
	}
	@RequestMapping("/deleteReview")
	public String deleteReview(@RequestParam String reviewNum) {
//		System.out.println("reviewNum"+reviewNum);
		service.DelReview(reviewNum);
		return "redirect:/myReview";
	}
}
