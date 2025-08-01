package com.backrooms.controller;

import java.io.IOException;
import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.backrooms.dto.MemberDTO;
import com.backrooms.service.MemberService;
import com.util.Utility;


import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MemberController {
	private final MemberService service;
	@GetMapping("/SignIn")
	public String signInGet()
	{
		return "signIn";
	}
	@PostMapping(value= "/SignIn" )
	public String signInPost(String memberId, String passwd, HttpSession session)
	{
		var pw = Utility.encrypt(passwd);
		var dto = service.signIn(memberId, pw);
		if(dto==null)
		{
			return "redirect:SignIn";			
		}
		
		session.setAttribute("member", dto);
		return "redirect:/";
	}
	
	@GetMapping("/SignUp")
	public String signUpGet()
	{
		return "signUp";
	}
	@PostMapping("/SignUp")
	public String signUpPost(@ModelAttribute MemberDTO dto)
	{
		var passwd = dto.getPasswd();
		dto.setPasswd(Utility.encrypt(passwd));
		
		service.signUp(dto);
		return "redirect:SignIn";
	}
	
	@GetMapping("/FindAccount")
	public String findAccountGet()
	{
		return "findAccount";
	}
	@PostMapping("/FindAccount")
	public @ResponseBody String findAccountPost (
			@RequestParam HashMap<String, String> map) throws IOException
	{
		
		var data = service.findAccount(map);
		
		if(data==null)
		{
			var e = new IOException();
			throw e;
		}
		//ajax 처리.
		return data;
	}
	@PostMapping("/UpdatePasswd")
	public String updatePasswdPost(
			String memberId,
			String passwd)
	{
		HashMap<String, String> map = new HashMap<>();
		map.put("passwd", Utility.encrypt(passwd));
		map.put("memberId", memberId);
		
		service.updatePw(map);

		return "childWindow/successToFind";
	}
	@PostMapping("/ModifyProfile")
	public String modifyProfilePost(
			@RequestParam HashMap<String, String> map,
			HttpSession session)
	{
		var member = (MemberDTO)session.getAttribute("member");
		var memberId = member.getMemberId();
	    
	    map.put("memberId", memberId);
	    service.modifyProfile(map);
	    System.out.println(member.getPasswd());
	    member = service.signIn(memberId, member.getPasswd());
	    System.out.println(member.getPasswd());
	    
	    
	    session.setAttribute("member", member);
	    
		return "redirect:MyPage";
	}
	@GetMapping("/SignOut")
	public String signOutGet(HttpSession session)
	{
		session.invalidate();
		return "redirect:/";
	}
	@GetMapping("/FindId")
	public String findIdGet(HttpSession session)
	{
		session.invalidate();
		return "childWindow/findId";
	}
	@GetMapping("/ErrorToFind")
	public String errorToFindGet(HttpSession session)
	{
		session.invalidate();
		return "childWindow/errorToFind";
	}
	@GetMapping("/FindPw")
	public String FindPwGet(HttpSession session)
	{
		session.invalidate();
		return "childWindow/findPw";
	}
}
