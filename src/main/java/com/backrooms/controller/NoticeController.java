package com.backrooms.controller;

import com.backrooms.dto.NoticeDTO;
import com.backrooms.dto.NoticePageDTO;
import com.backrooms.service.NoticeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/notice")
@RequiredArgsConstructor
public class NoticeController {

  private final NoticeService service;

  @GetMapping("/list")
  public String noticeListUI() {
    return "noticeList";
  }

  @GetMapping("/list/{curPage}")
  @ResponseBody
  public NoticePageDTO noticeListUI(@PathVariable int curPage) {
    NoticePageDTO noticePagination = service.getNoticePagination(curPage, "all");
    return noticePagination;
  }

  @GetMapping("/detail/{noticeNum}")
  public String noticeDetailUI(@PathVariable int noticeNum, Model model) {
    NoticeDTO noticeDetail = service.getNoticeDetail(noticeNum);
    model.addAttribute("noticeDetail", noticeDetail);
    return "noticeDetail";
  }
}
