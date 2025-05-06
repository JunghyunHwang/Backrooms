package com.backrooms.dao;

import com.backrooms.dto.*;

import java.util.ArrayList;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ImageDAO {

  @Autowired
  private SqlSessionTemplate template;

  public int insertFile(ImageInsertDTO image) {
    return template.insert("ImageMapper.insertFile", image);
  }

  public String getStoreFileName(ImageFileQueryDTO imageFileQueryDTO) {
    return template.selectOne("ImageMapper.selectStoreFileNameByUseAndKind", imageFileQueryDTO);
  }

  public List<ImageFileNamesDTO> getUploadAndStoreFileNames(ImageFileQueryDTO imageFileQueryDTO) {
    return template.selectList("ImageMapper.selectUploadAndStoreFileNamesByUseAndKind", imageFileQueryDTO);
  }

  public String getUploadFileName(String storeFileName) {
    return template.selectOne("ImageMapper.selectUploadNameByStoreName", storeFileName);
  }
}
