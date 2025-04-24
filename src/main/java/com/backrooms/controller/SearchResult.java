package com.backrooms.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.backrooms.dto.SeachResultDTO;
import com.backrooms.dto.SearchArrDTO;
import com.backrooms.dto.SearchCheckDTO;
import com.backrooms.service.HotelSearchService;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class SearchResult {
	@Autowired
	private HotelSearchService service;
	
	@RequestMapping("/")
	public String main() {
		System.out.println("들어옴 =============================");
		return "main";
	}
	
	@RequestMapping("/SearchResult")
	public ModelAndView search(@ModelAttribute SearchCheckDTO chDTO,ModelAndView mav) {
		chDTO.setCheckIn(service.replace_date(chDTO.getCheckIn().split("/")));
		chDTO.setCheckOut(service.replace_date(chDTO.getCheckOut().split("/")));
		List<SeachResultDTO> list = service.getAvailableRooms(chDTO);
		mav = service.send(mav, list, chDTO);
		mav.setViewName("searchResult");
		return mav;
	}
	@RequestMapping("/Condition")
	public ModelAndView grade(@ModelAttribute SearchCheckDTO chDTO, @RequestParam("StarNum") String num,ModelAndView mav) {
		List<SeachResultDTO> list = service.getAvailableRooms(chDTO);
		Map<String,String> type = new HashMap<String,String>();
		type.put("grade",num);
		List<SeachResultDTO> Relist = service.conditionValue(list,type);
		mav = service.send(mav, Relist, chDTO);
		mav.setViewName("searchResult");
		return mav;
	}
	@RequestMapping("/Rating")
	public ModelAndView star(ModelAndView mav,@ModelAttribute SearchCheckDTO chDTO,@RequestParam("RatingNum") String num) {
		List<SeachResultDTO> list = service.getAvailableRooms(chDTO);
		Map<String,String> type = new HashMap<String,String>();
		type.put("star",num);
		List<SeachResultDTO> Relist = service.conditionValue(list,type);
		mav = service.send(mav, Relist, chDTO);
		mav.setViewName("searchResult");
		return mav;
	}
}
