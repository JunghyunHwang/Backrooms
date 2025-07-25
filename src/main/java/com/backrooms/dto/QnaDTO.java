package com.backrooms.dto;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class QnaDTO {

  int qnaNum;
  String memberName;
  int memberNum;
  String qnaDate;
  String qnaTitle;
  String qnaText;
  int qnaState;
  String qnaReply;
  private String imageFileName;
}
