package com.backrooms.controller;

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
//		System.out.println("list"+list);
//		System.out.println("MyReview.java"+list);
		ModelAndView mav = new ModelAndView();
		mav.addObject("myReview",list);
		mav.setViewName("myReview");
		return mav;
	}
	@PostMapping("/WriteReview")
	public ModelAndView WriteReveiw(ReviewDTO dto, @RequestParam String imageUpload, HttpSession session) {
		int list = service.reviewAdd(dto);
		System.out.println("insert: "+list);
		System.out.println(imageUpload);
		ModelAndView mav = new ModelAndView();
		System.out.println(imageUpload);
		mav.addObject("imageUpload",imageUpload);
		mav.setViewName("writeReview");
		return mav;
	}
	@GetMapping("/WriteReview")
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
