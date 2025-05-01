package com.backrooms.dao;

import com.backrooms.dto.ImageDTO;
import com.backrooms.dto.ImageFileNamesDTO;
import com.backrooms.dto.ImageFileQueryDTO;
import com.backrooms.dto.ImageInsertDTO;
import com.backrooms.dto.ImageKind;
import com.backrooms.dto.ImageRequestDTO;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ImageDAO {

  @Autowired
  private SqlSessionTemplate template;

  public List<Integer> getImageCount(ImageRequestDTO filter) {
    assert (filter.getKind() != ImageKind.ERROR.getValue());
    assert (filter.getUseList() != null);

    return template.selectList("ImageMapper.getImageCountByList", filter);
  }

  public int insertFile(ImageInsertDTO image) {
    return template.insert("ImageMapper.insertImage", image);
  }

  public String selectStoreFileName(ImageFileQueryDTO imageFileQueryDTO) {
    return template.selectOne("ImageMapper.selectStoreFileName", imageFileQueryDTO);
  }

  public List<ImageFileNamesDTO> selectImageFileNames(ImageFileQueryDTO imageFileQueryDTO) {
    return template.selectList("ImageMapper.selectImageFileNames", imageFileQueryDTO);
  }
}
