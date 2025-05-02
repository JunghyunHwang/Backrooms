package com.backrooms.dao;

import com.backrooms.dto.EventDTO;
import java.util.List;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EventDAO {

  @Autowired
  SqlSessionTemplate template;

  public int totalCount() {
    return template.selectOne("EventMapper.totalCount");
  }

  public List<EventDTO> selectList(int offset, int perPage) {
    List<EventDTO> eventList = template.selectList("EventMapper.list", null, new RowBounds(offset, perPage));
    return eventList;
  }

  public List<EventDTO> selectTopList(int offset, int perPage) {
    List<EventDTO> eventList = template.selectList(
      "EventMapper.Toplist",
      null,
      new RowBounds(offset, perPage)
    );
    return eventList;
  }

  public EventDTO selectone(int eventNum) {
    return template.selectOne("EventMapper.detail", eventNum);
  }

  public int totalTopCount() {
    return template.selectOne("EventMapper.totalTopCount");
  }

  public int insert(EventDTO dto) {
    int result = template.insert("EventMapper.insert", dto);
    return result;
  }

  public int update(EventDTO dto) {
    return template.update("EventMapper.update", dto);
  }

  public int delete(List<Integer> idsToDelete) {
    return template.update("EventMapper.delete", idsToDelete);
  }

  public int selectLatestEventNum() {
    return template.selectOne("EventMapper.SelectLatestEventNum");
  }
}
