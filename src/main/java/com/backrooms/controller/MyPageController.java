package com.backrooms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MyPageController {

	
	 @GetMapping("/MyPage")
	  public String myPageUI(@RequestParam(value = "myPage", required = false) String myPage) {
	      System.out.println("myPageUI: " + myPage);
	    
	      return "myPage";
	  }
}
