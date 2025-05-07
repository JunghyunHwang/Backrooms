package com.backrooms.controller.consoleBoard;

import com.backrooms.dto.MemberDTO;
import com.backrooms.dto.PostDeleteRequestDTO;
import com.backrooms.dto.QnaDTO;
import com.backrooms.dto.QnaPageDTO;
import com.backrooms.dto.QnaUpdateRequestDTO;
import com.backrooms.service.QnaService;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequiredArgsConstructor
@RequestMapping("/console/board/qna")
public class QnaConsoleController {

  /**
   * TODO:
   *  - 오류 메세지 errors/messages.properties에서 code별로 관리하기
   *  - 스프링 시큐리티 필터체인에서 로그인 체크, 권한체크 로직 추가되면 member 체크관련 로직 지우기
   *  - -requestDTO 파라미터에서 바인딩하는 과정에서 발생하는 에러 관련 처리하기
   *  - validation 어노테이션 dto마다 추가하고 messages.properties에서 에러메시지 지정해놓기
   */
  private final QnaService qnaService;

  @GetMapping("/list/{curPage}")
  @ResponseBody
  public QnaPageDTO qnaList(
    @PathVariable int curPage,
    @RequestParam String filter,
    @RequestParam String qnaCategory
  ) {
    QnaPageDTO qnaPaination = qnaService.getQnaPagination(curPage, filter, qnaCategory);
    return qnaPaination;
  }

  @GetMapping("/detail/{postNum}")
  @ResponseBody
  public QnaDTO qnaDetail(@PathVariable int postNum) {
    QnaDTO qnaDTO = qnaService.getQnaDetail(postNum);
    return qnaDTO;
  }

  @PutMapping
  public String qnaUpdate(@RequestBody QnaUpdateRequestDTO updatePostDTO, HttpSession session) {
    System.out.println("/notice put requested with dto: " + updatePostDTO);

    MemberDTO member = (MemberDTO) session.getAttribute("member");

    if (member == null) {
      throw new ResponseStatusException(HttpStatus.FORBIDDEN, "접근 권한이 없습니다");
    }

    int updateResult = qnaService.updatQna(updatePostDTO);

    if (updateResult != 1) {
      throw new ResponseStatusException(
        HttpStatus.INTERNAL_SERVER_ERROR,
        "문의글 수정에 실패했습니다. 다시 시도해주세요."
      );
    }

    return "ok";
  }

  @DeleteMapping
  public String qnaDeletion(@RequestBody PostDeleteRequestDTO deletePostDTO, HttpSession session) {
    MemberDTO member = (MemberDTO) session.getAttribute("member");

    if (member == null) {
      throw new ResponseStatusException(HttpStatus.FORBIDDEN, "접근 권한이 없습니다");
    }

    List<Integer> idsToDelete = deletePostDTO.getList();
    if (idsToDelete == null || idsToDelete.isEmpty()) {
      throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "삭제할 항목이 없습니다.");
    }

    int deletedCount = qnaService.deleteQnas(idsToDelete);
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
