package com.backrooms.controller;




import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.backrooms.dto.MemberDTO;
import com.backrooms.dto.QnaDTO;
import com.backrooms.dto.QnaPageDTO;
import com.backrooms.service.QnaService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/qna")
public class QnaController {

	
	private final QnaService service;
	
	@GetMapping()
	public String qnaUI() {
		return "qna";
	}
	
	
	@PostMapping()
	public String qnaAdd(HttpSession session, @ModelAttribute QnaDTO dto, Model model) {
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		int check = service.qnaAdd(dto,member);
		System.out.println(check);
		String page = "main";
		if (check != 1) {
			model.addAttribute("errorMessage", "등록에 실패했습니다. 다시 시도해주세요.");
	        page = "qna";
	    }
		return page;
	    }
	
	
	  @GetMapping("my/{curPage}")
	  @ResponseBody
	  public QnaPageDTO myQna(@PathVariable int curPage, HttpSession session) {
		  MemberDTO member = (MemberDTO) session.getAttribute("member");
		  //MemberDTO member = new MemberDTO();
		  QnaPageDTO qnaPaination = service.getMyQna(curPage, member);
	  
		  System.out.println(qnaPaination);
	  return qnaPaination;
	  } 
	  
	  @GetMapping("/myDetail/{postNum}")
		@ResponseBody
		public QnaDTO qnaDetail(@PathVariable int postNum) {
		  System.out.println("detail");
			QnaDTO qnaDTO = service.getQnaDetail(postNum);
			return qnaDTO;
		}
	 
}
