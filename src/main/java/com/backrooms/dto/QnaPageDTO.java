package com.backrooms.dto;

import java.util.List;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class QnaPageDTO {

  private List<QnaDTO> qnaList;
  private int curPage;
  private int perPage = 4;
  private int totalCount;
}
