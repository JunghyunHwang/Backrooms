package com.backrooms.dao;

import com.backrooms.dto.NoticeDTO;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class NoticeDAO {

  private final SqlSessionTemplate template;

  public int totalCount() {
    return template.selectOne("NoticeMapper.totalCount");
  }

  public int totalTopCount() {
    return template.selectOne("NoticeMapper.totalTopCount");
  }

  public List<NoticeDTO> selectList(int offset, int perPage) {
    List<NoticeDTO> noticeList = template.selectList(
      "NoticeMapper.list",
      null,
      new RowBounds(offset, perPage)
    );
    return noticeList;
  }

  public int selectLatestNoticeNum() {
    return template.selectOne("NoticeMapper.latestNoticeNum");
  }

  public NoticeDTO selectOne(int noticeNum) {
    NoticeDTO notice = template.selectOne("NoticeMapper.detail", noticeNum);
    return notice;
  }

  public int insert(NoticeDTO dto) {
    int result = template.insert("NoticeMapper.insert", dto);
    return result;
  }

  public int update(NoticeDTO dto) {
    return template.update("NoticeMapper.update", dto);
  }

  public List<NoticeDTO> selectTopList(int offset, int perPage) {
    List<NoticeDTO> noticeList = template.selectList(
      "NoticeMapper.Toplist",
      null,
      new RowBounds(offset, perPage)
    );

    return noticeList;
  }

  public int delete(List<Integer> idsToDelete) {
    return template.update("NoticeMapper.delete", idsToDelete);
  }
}
