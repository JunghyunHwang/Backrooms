package com.backrooms.dto;

import java.util.List;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class NoticePageDTO {

  private List<NoticeDTO> noticeList;
  private int curPage;
  private int perPage = 4;
  private int totalCount;
}
