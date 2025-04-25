package com.backrooms.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

//관리자 게시판에서 qna 수정 요청시 사용하는 dto입니다
@Getter
@Setter
@NoArgsConstructor
public class QnaUpdateRequestDTO {

  private int postNum;
  private String qnaReplay;
}
