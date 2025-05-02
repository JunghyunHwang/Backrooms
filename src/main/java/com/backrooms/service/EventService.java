package com.backrooms.service;

import com.backrooms.dao.EventDAO;
import com.backrooms.dto.EventDTO;
import com.backrooms.dto.EventPageDTO;
import com.backrooms.dto.ImageFileNamesDTO;
import com.backrooms.dto.ImageKind;
import com.backrooms.dto.PostCreateRequestDTO;
import com.backrooms.dto.PostUpdateRequestDTO;
import com.backrooms.exception.FileStorageException;
import com.backrooms.exception.PostCreationException;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

@RequiredArgsConstructor
@Service
@Slf4j
public class EventService {

  private final EventDAO dao;
  private final ImageService imageService;

  @Transactional
  public void createEventAndStoreImages(PostCreateRequestDTO newPostDTO, int memberNum) {
    int insertResult = 0;
    try {
      insertResult = createEvent(newPostDTO, memberNum);
    } catch (Exception e) {
      throw new PostCreationException(
        "\"게시글 등록에 실패했습니다. 다시 시도해주세요: " + e.getMessage(),
        e
      );
    }

    if (insertResult != 1) {
      throw new PostCreationException("\"게시글 등록에 실패했습니다. 다시 시도해주세요.");
    }

    int latestEventNum = getLatestEventNum();
    try {
      imageService.storeFiles(newPostDTO.getFiles(), ImageKind.fromInt(4), latestEventNum);
    } catch (Exception e) {
      throw new FileStorageException("파일을 저장하는 과정에서 에러가 발생했습니다: " + e.getMessage(), e);
    }
  }

  private int getLatestEventNum() {
    return dao.selectLatestEventNum();
  }

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
      default: {
        throw new IllegalArgumentException(
          filter + "는 관리자-이벤트 게시판에서 지원되지 않는 필터 형식입니다."
        );
      }
    }
    eventPageDTO.setCurPage(curPage);
    eventPageDTO.setEventList(eventList);
    eventPageDTO.setTotalCount(totalCount);

    return eventPageDTO;
  }

  public EventDTO getEventDetail(int eventNum) {
    EventDTO eventDetail = dao.selectone(eventNum);
    List<ImageFileNamesDTO> imageFileNamesList = imageService.getUploadAndStoreFileNames(
      eventNum,
      ImageKind.fromInt(4)
    );
    eventDetail.setImageFileNamesList(imageFileNamesList);
    log.warn("imageFileNamesList: {}", imageFileNamesList);
    return eventDetail;
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
