package com.backrooms.dto;

import java.util.List;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class EventDTO {

  private int eventNum;
  private int memberNum;
  private String memberName;
  private String eventDate;
  private String eventTitle;
  private String eventText;
  private int eventState;
  private List<ImageFileNamesDTO> imageFileNamesList;
}
