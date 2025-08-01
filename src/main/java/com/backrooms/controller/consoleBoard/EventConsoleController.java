package com.backrooms.controller.consoleBoard;

import com.backrooms.dto.EventDTO;
import com.backrooms.dto.EventPageDTO;
import com.backrooms.dto.MemberDTO;
import com.backrooms.dto.PostCreateRequestDTO;
import com.backrooms.dto.PostDeleteRequestDTO;
import com.backrooms.dto.PostUpdateRequestDTO;
import com.backrooms.exception.FileStorageException;
import com.backrooms.exception.PostCreationException;
import com.backrooms.service.EventService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@Controller
@RequiredArgsConstructor
@RequestMapping("/console/board/event")
@Slf4j
public class EventConsoleController {

  /**
   * TODO:
   *  - 오류 메세지 errors/messages.properties에서 code별로 관리하기
   *  - 스프링 시큐리티 필터체인에서 로그인 체크, 권한체크 로직 추가되면 member 체크관련 로직 지우기
   *  - -requestDTO 파라미터에서 바인딩하는 과정에서 발생하는 에러 관련 처리하기
   *  - validation 어노테이션 dto마다 추가하고 messages.properties에서 에러메시지 지정해놓기
   */
  private final EventService service;

  @ResponseBody
  @GetMapping("/list/{curPage}")
  public EventPageDTO eventList(@RequestParam String filter, @PathVariable int curPage) {
    EventPageDTO eventPaination = service.getEventPagination(curPage, filter);
    return eventPaination;
  }

  @ResponseBody
  @RequestMapping("/detail/{postNum}")
  public EventDTO eventDetail(@PathVariable int postNum) {
    EventDTO eventDetail = service.getEventDetail(postNum);
    return eventDetail;
  }

  @PostMapping
  public String newEvent(
    @ModelAttribute PostCreateRequestDTO newPostDTO,
    HttpSession session,
    HttpServletRequest request
  ) {
    MemberDTO member = (MemberDTO) session.getAttribute("member");

    if (member == null) {
      throw new ResponseStatusException(HttpStatus.FORBIDDEN, "접근 권한이 없습니다");
    }

    try {
      service.createEventAndStoreImages(newPostDTO, member.getMemberNum());
    } catch (FileStorageException | PostCreationException e) {
      throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage());
    }

    String currentCategoryFirstPageUrl = getCurrentCategoryFirstPageUrl(request);

    return "redirect:/" + currentCategoryFirstPageUrl;
  }

  private static String getCurrentCategoryFirstPageUrl(HttpServletRequest request) {
    String referrer = request.getHeader("referer");

    if (referrer == null) {
      return "";
    }
    String basePath = referrer.split(request.getContextPath() + "/")[1];
    String pathWithoutPage = basePath.split("&curPage")[0];
    return pathWithoutPage + "&curPage=1&filter=all";
  }

  @ResponseBody
  @PutMapping
  public String eventUpdate(@RequestBody PostUpdateRequestDTO updatePostDTO, HttpSession session) {
    MemberDTO member = (MemberDTO) session.getAttribute("member");

    if (member == null) {
      throw new ResponseStatusException(HttpStatus.FORBIDDEN, "접근 권한이 없습니다");
    }

    int updateResult = service.updateEvent(updatePostDTO);
    if (updateResult != 1) {
      throw new ResponseStatusException(
        HttpStatus.INTERNAL_SERVER_ERROR,
        "이벤트 게시글 등록에 실패했습니다. 다시 시도해주세요."
      );
    }
    //      throw new ResponseStatusException(HttpStatus.CREATED, "이벤트 게시글 등록이 완료되었습니다");
    return "ok";
  }

  @ResponseBody
  @DeleteMapping
  public String eventDeletion(@RequestBody PostDeleteRequestDTO deletePostDTO, HttpSession session) {
    MemberDTO member = (MemberDTO) session.getAttribute("member");
    if (member == null) {
      throw new ResponseStatusException(HttpStatus.FORBIDDEN, "접근 권한이 없습니다");
    }

    List<Integer> idsToDelete = deletePostDTO.getList();
    if (idsToDelete == null || idsToDelete.isEmpty()) {
      throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "삭제할 항목이 없습니다.");
    }

    int deletedCount = service.deleteEvents(idsToDelete);
    if (deletedCount == idsToDelete.size()) {
      return "ok";
    } else {
      throw new ResponseStatusException(
        HttpStatus.INTERNAL_SERVER_ERROR,
        "일부 항목 삭제에 실패했습니다. 다음에 다시 시도 해주세요"
      );
    }
  }
}
