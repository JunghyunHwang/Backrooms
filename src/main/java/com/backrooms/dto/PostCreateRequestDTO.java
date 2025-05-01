package com.backrooms.dto;

import java.util.List;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

//이벤트, 공지사항 게시글 등록시 사용되는 dto입니다
@Getter
@Setter
@NoArgsConstructor
@ToString
public class PostCreateRequestDTO {

  private String postTitle;
  private String postText;
  //  private boolean isTopChecked;
  private int postState; //9: top, 0: normal
  private List<MultipartFile> files;
}
