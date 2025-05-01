package com.backrooms.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.apache.ibatis.type.Alias;

@Getter
@AllArgsConstructor
@Alias("ImageFileQueryDTO")
/**
 * image테이블 에서 imageUse, imageKind에따라 select할때 사용할 paramType용 DTO입니다
 * 매퍼에 전달하는 용도이기때문에 세터는 실수방지를 위해 포함시키지 않았습니다.
 */
public class ImageFileQueryDTO {

  private int imageUse;
  private int imageKind;
}
