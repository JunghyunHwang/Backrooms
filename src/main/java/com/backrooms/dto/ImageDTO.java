package com.backrooms.dto;

import java.time.LocalDateTime;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

/**
 * ImageMapper에서 insert에대한 결과를 반환받을 DTO입니다. resultType=ImageDTO로 사용되며
 * 매퍼가 sql결과를 자바 객체로 만들때 기본 생성자와 세터를 사용하므로 기본 생성자와 세터를 포함시켰습니다
 */
@Getter
@Setter
@NoArgsConstructor
@Alias("ImageDTO")
public class ImageDTO {

  private int imageNum;
  private int imageKind;
  private int imageUse;
  private String imageUploadFileName;
  private String imageStoreFileName;
  private LocalDateTime createdAt;
}
