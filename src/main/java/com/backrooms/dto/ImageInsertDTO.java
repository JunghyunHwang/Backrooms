package com.backrooms.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.apache.ibatis.type.Alias;

/**
 * 매퍼로 전달할때에만 사용하는 DTO입니다.
 * 실수로 세터로 다른 값으로 변경하는 실수를 방지하고자 세터를 사용하지 않습니다
 * (매퍼에서 쿼리 결과를 반환해주는 rsultType은 ImageDTO입니다)
 * 생성자는 ImageInsertDTO(imageKind, imageUse, imageUploadFileName, imageStoreFileName) 순입니다
 */
@Getter
@AllArgsConstructor
@Alias("ImageInsertDTO")
public class ImageInsertDTO {

  private int imageKind;
  private int imageUse;
  private String imageUploadFileName;
  private String imageStoreFileName;
}
