package com.backrooms.dto;

import java.util.List;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class NoticeDTO {

  private int noticeNum;
  private int noticeState;
  private int memberNum;
  private String memberName;
  private String noticeDate;
  private String noticeTitle;
  private String noticeText;
  private List<ImageFileNamesDTO> imageFileNamesList;
}
