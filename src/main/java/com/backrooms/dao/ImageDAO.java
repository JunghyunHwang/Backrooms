package com.backrooms.dao;

import com.backrooms.dto.ImageKind;
import com.backrooms.dto.ImageRequestDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ImageDAO {
    @Autowired
    private SqlSessionTemplate template;

    public List<Integer> getImageCount(ImageRequestDTO filter) {
        assert(filter.getKind() != ImageKind.ERROR.getValue());
        assert(filter.getUseList() != null);

        return template.selectList("ImageMapper.getImageCountByList", filter);
    }
}
