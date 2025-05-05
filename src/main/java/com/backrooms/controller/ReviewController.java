package com.backrooms.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.backrooms.dto.ReviewDTO;
import com.backrooms.service.ReviewService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReviewController {
	@Autowired
	ReviewService service;
	
	@Autowired
	private WebApplicationContext context;

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
	public ModelAndView WriteReveiw( @RequestParam String uploaderName
			, @RequestParam MultipartFile uploaderFile, Model model,ReviewDTO dto, HttpSession session, HttpServletResponse response) throws IOException {

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
		//MultipartFile.getContentType() : MultipartFile 객체에 저장된 전달파일의 형태(MimeType)를 반환하는 메소드
		System.out.println("파일 형태(MimeType) = "+uploaderFile.getContentType());
		//MultipartFile.getBytes() : MultipartFile 객체에 저장된 전달파일의 내용을 byte 배열로 반환하는 메소드
		System.out.println("파일 크기(Byte) = "+uploaderFile.getBytes().length);

		//WebApplicationContext.getServletContext() : WebApplicationContext 객체(스프링 컨테이너)를
		//사용해 ServletContext 객체를 반환하는 메소드
		String uploadDirectory=context.getServletContext().getRealPath("/WEB-INF/views/img");
		System.out.println("uploadDirectory = "+uploadDirectory);

		//MultipartFile.getOriginalFilename() : MultipartFile 객체에 저장된 전달파일의 이름을 반환하는 메소드 - 원본 파일명
		//UUID.randomUUID() : 36Byte 크기의 식별자가 저장된 UUID 객체를 생성하여 반환하는 정적메소드
		//UUID.toString() : UUID 객체에 저장된 36Byte 크기의 식별자를 문자열로 반환하는 메소드
		String uploadFilename=UUID.randomUUID().toString()+"_"+uploaderFile.getOriginalFilename(); 

		//MultipartFile.transferTo(File file) : MultipartFile 객체에 저장된 전달파일의 내용을  
		//File 객체에 저장된 파일에 저장되도록 업로드 처리하는 메소드

		File file=new File(uploadDirectory, uploadFilename);
		uploaderFile.transferTo(file);
		System.out.println(uploadFilename);
		mav.addObject("uploaderName", uploaderName);
		mav.addObject("uploadFilename", uploadFilename);
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
