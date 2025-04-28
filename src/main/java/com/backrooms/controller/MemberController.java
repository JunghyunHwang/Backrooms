package com.backrooms.controller;

import java.io.IOException;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.backrooms.dto.MemberDTO;
import com.backrooms.service.MemberService;
import com.util.Utility;


import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MemberController {
	@Autowired
	MemberService service;
	@GetMapping("/SignIn")
	public String signInGet()
	{
		return "signIn";
	}
	@PostMapping(value= "/SignIn" )
	public String signInPost(String memberId, String passwd, HttpSession session)
	{
		var dto = service.signIn(memberId, passwd);
		if(dto==null)
		{
			return "redirect:SignIn";			
		}
		
		session.setAttribute("member", dto);
		return "redirect:/";
	}
	
	@RequestMapping(value= "/SignUp" ,method =RequestMethod.GET)
	public String signUpGet()
	{
		return "signUp";
	}
	@RequestMapping(value= "/SignUp" ,method =RequestMethod.POST)
	public String signUpPost(@RequestParam MemberDTO dto)
	{
		service.signUp(dto);
		return "redirect:SignIn";
	}
	
	@RequestMapping(value= "/FindAccount" ,method =RequestMethod.GET)
	public String findAccountGet()
	{
		return "findAccount";
	}
	@RequestMapping(value= "/FindAccount" ,method =RequestMethod.POST)
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
	@RequestMapping(value= "/UpdatePasswd" ,method =RequestMethod.POST)
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
	@RequestMapping(value= "/ModifyProfile" ,method =RequestMethod.POST)
	public String modifyProfilePost(
			HashMap<String, String> map,
			HttpSession session)
	{
		var member = (MemberDTO)session.getAttribute("member");
		var memberId = member.getMemberId();
		
	    map.put("memberId", memberId);
		
	    service.modifyProfile(map);
	    member = service.signIn(memberId, member.getPasswd());
	    session.setAttribute("member", member);
	    
		return "redirect:MyPage";
	}
	@RequestMapping(value= "/SignOut" ,method =RequestMethod.GET)
	public String signOutGet(HttpSession session)
	{
		session.invalidate();
		return "redirect:/";
	}
}
