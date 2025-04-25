package com.backrooms.controller.consoleBoard;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/console/board")
public class ConsoleBoardController {

  @GetMapping
  public String consoleUI() {
    return "console";
  }
}
