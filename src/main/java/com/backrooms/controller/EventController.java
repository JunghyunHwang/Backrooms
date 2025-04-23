package com.backrooms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.backrooms.dto.EventDTO;
import com.backrooms.dto.EventPageDTO;
import com.backrooms.service.EventService;


@Controller
@RequestMapping("/event")
public class EventController {
	
	 @Autowired
	EventService service;
	
	 @GetMapping("/list")
		public String eventListUI() {
			
			return "eventList";
		}
	 
	@GetMapping("/list/{curPage}")
	@ResponseBody
	public EventPageDTO eventList(@PathVariable int curPage) {
		
		
		EventPageDTO eventPaination = service.getEventPagination(curPage, "all");
		System.out.println(eventPaination);
		return eventPaination;
	}
	
	@GetMapping("/detail/{eventNum}")
	public String eventDetailUI(@PathVariable int eventNum, Model model) {
		EventDTO eventDetail = service.getEventDetail(eventNum);
		model.addAttribute("eventDetail", eventDetail);
		return "eventDetail";
	}
}
