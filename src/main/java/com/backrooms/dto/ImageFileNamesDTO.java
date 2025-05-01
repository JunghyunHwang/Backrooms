package com.backrooms.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@NoArgsConstructor
@Alias("ImageFileNamesDTO")
@ToString
/**
 * image 테이블에서 imageUploadFileName, imageStoreFileName를 결과로 받아올때 매퍼에서 returnType에 쓰이는 DTO입니다
 * 매퍼에서 기본 생성자랑 세터를 사용하기 때문에 세터를 추가했습니다
 */
public class ImageFileNamesDTO {

  private String imageUploadFileName;
  private String imageStoreFileName;
}
