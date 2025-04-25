package com.backrooms.dao;

import com.backrooms.dto.QnaDTO;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@RequiredArgsConstructor
@Repository
public class QnaDAO {

  private final SqlSessionTemplate template;

  public int insert(QnaDTO dto) {
    int check = template.insert("QnaMapper.insert", dto);

    return check;
  }

  public QnaDTO selectOne(int postNum) {
    return template.selectOne("QnaMapper.detail", postNum);
  }

  public int totalCount() {
    return template.selectOne("QnaMapper.totalCount");
  }

  public int totalPendingCount() {
    return template.selectOne("QnaMapper.totalPendingCount");
  }

  public int totalCompletionCount() {
    return template.selectOne("QnaMapper.totalCompletionCount");
  }

  public List<QnaDTO> selectList(int offset, int perPage) {
    List<QnaDTO> qnaList = template.selectList("QnaMapper.list", null, new RowBounds(offset, perPage));
    return qnaList;
  }

  public List<QnaDTO> selectPendingList(int offset, int perPage) {
    List<QnaDTO> qnaList = template.selectList(
      "QnaMapper.selectPendingList",
      null,
      new RowBounds(offset, perPage)
    );
    return qnaList;
  }

  public List<QnaDTO> selectCompletionList(int offset, int perPage) {
    List<QnaDTO> qnaList = template.selectList(
      "QnaMapper.selectCompletion",
      null,
      new RowBounds(offset, perPage)
    );
    return qnaList;
  }

  public List<QnaDTO> selectMyList(int offset, int perPage, int memberNum) {
    List<QnaDTO> qnaList = template.selectList("QnaMapper.Mylist", memberNum, new RowBounds(offset, perPage));
    return qnaList;
  }

  public int update(QnaDTO dto) {
    return template.update("QnaMapper.update", dto);
  }

  public int delete(List<Integer> idsToDelete) {
    return template.update("QnaMapper.delete", idsToDelete);
  }
}
