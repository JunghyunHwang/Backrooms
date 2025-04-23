package com.backrooms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.backrooms.dao.EventDAO;
import com.backrooms.dto.EventDTO;
import com.backrooms.dto.EventPageDTO;
import com.backrooms.dto.PostCreateRequestDTO;
import com.backrooms.dto.PostUpdateRequestDTO;



@Service
public class EventService {

	@Autowired
	EventDAO dao;

	public EventPageDTO getEventPagination(int curPage, String filter) {
		EventPageDTO eventPageDTO = new EventPageDTO();
		List<EventDTO> eventList = null;
		int totalCount = 0;
		int perPage = eventPageDTO.getPerPage();
		int offset = (curPage - 1) * perPage;
		switch (filter) {
		case "all": {
			eventList = dao.selectList(offset, perPage);
			totalCount = dao.totalCount();
			break;
		}
		//상단이 아직 1개라서 top로 했는데 상단글 종류가 2개이상이 생기면 종류에 맞춰서 구체적인 이름으로 나눌 예정입니다.
		case "top": {
			eventList = dao.selectTopList(offset, perPage);
			totalCount = dao.totalTopCount();
			break;
		}
		default:{
			throw new IllegalArgumentException(filter + "는 관리자-이벤트 게시판에서 지원되지 않는 필터 형식입니다.");
		}
		}
		eventPageDTO.setCurPage(curPage);
		eventPageDTO.setEventList(eventList);
		eventPageDTO.setTotalCount(totalCount);

		return eventPageDTO;
	}

	public EventDTO getEventDetail(int eventNum) {
		return dao.selectone(eventNum);
	}
	
	
	public int createEvent(PostCreateRequestDTO newPostDTO, int memberNum) {
		EventDTO newEvent = new EventDTO();
		newEvent.setMemberNum(memberNum);
		newEvent.setEventState(newPostDTO.getPostState());
        newEvent.setEventTitle(newPostDTO.getPostTitle());
        newEvent.setEventText(newPostDTO.getPostText());
		return dao.insert(newEvent);
	}

	public int updateEvent(PostUpdateRequestDTO updatePostDTO) {
		EventDTO updatedEvent = new EventDTO();
		updatedEvent.setEventNum(updatePostDTO.getPostNum());
		updatedEvent.setEventTitle(updatePostDTO.getTitle());
		updatedEvent.setEventText(updatePostDTO.getText());
		return dao.update(updatedEvent);
	}

	public int deleteEvents(List<Integer> idsToDelete) {
		return dao.delete(idsToDelete);
	}


}