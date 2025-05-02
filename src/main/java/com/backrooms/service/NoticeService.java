package com.backrooms.service;

import com.backrooms.dao.NoticeDAO;
import com.backrooms.dto.ImageFileNamesDTO;
import com.backrooms.dto.ImageKind;
import com.backrooms.dto.NoticeDTO;
import com.backrooms.dto.NoticePageDTO;
import com.backrooms.dto.PostCreateRequestDTO;
import com.backrooms.dto.PostUpdateRequestDTO;
import com.backrooms.exception.FileStorageException;
import com.backrooms.exception.PostCreationException;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Slf4j
public class NoticeService {

  private final NoticeDAO dao;
  private final ImageService imageService;

  @Transactional
  public void createNoticeAndStoreImages(PostCreateRequestDTO newPostDTO, int memberNum) {
    int insertResult = 0;
    try {
      insertResult = createNotice(newPostDTO, memberNum);
    } catch (Exception e) {
      throw new PostCreationException(
        "\"게시글 등록에 실패했습니다. 다시 시도해주세요: " + e.getMessage(),
        e
      );
    }

    if (insertResult != 1) {
      throw new PostCreationException("\"게시글 등록에 실패했습니다. 다시 시도해주세요.");
    }

    int latestNoticeNum = getLatestNoticeNum();
    try {
      imageService.storeFiles(newPostDTO.getFiles(), ImageKind.fromInt(3), latestNoticeNum);
    } catch (Exception e) {
      throw new FileStorageException("파일을 저장하는 과정에서 에러가 발생했습니다: " + e.getMessage(), e);
    }
  }

  public int getLatestNoticeNum() {
    return dao.selectLatestNoticeNum();
  }

  public NoticePageDTO getNoticePagination(int curPage, String filter) {
    NoticePageDTO noticePageDTO = new NoticePageDTO();
    List<NoticeDTO> noticeList = null;
    int totalCount = 0;
    int perPage = noticePageDTO.getPerPage();
    int offset = (curPage - 1) * perPage;

    switch (filter) {
      case "all": {
        noticeList = dao.selectList(offset, perPage);
        totalCount = dao.totalCount();
        break;
      }
      case "top": {
        noticeList = dao.selectTopList(offset, perPage);
        totalCount = dao.totalTopCount();
        break;
      }
      default:
        throw new IllegalArgumentException(
          filter + "는 관리자-공지사항 게시판에서 지원되지 않는 필터 형식입니다."
        );
    }

    noticePageDTO.setCurPage(curPage);
    noticePageDTO.setNoticeList(noticeList);
    noticePageDTO.setTotalCount(totalCount);

    return noticePageDTO;
  }

  public NoticeDTO getNoticeDetail(int noticeNum) {
    NoticeDTO noticeDetail = dao.selectOne(noticeNum);
    List<ImageFileNamesDTO> imageFileNamesList = imageService.getUploadAndStoreFileNames(
      noticeNum,
      ImageKind.fromInt(3)
    );
    noticeDetail.setImageFileNamesList(imageFileNamesList);
    log.warn("imageFileNamesList: {}", imageFileNamesList);
    return noticeDetail;
  }

  public int insert(NoticeDTO dto) {
    return dao.insert(dto);
  }

  public int createNotice(PostCreateRequestDTO newPostDTO, int memberNum) {
    NoticeDTO newNotice = new NoticeDTO();
    newNotice.setMemberNum(memberNum);
    newNotice.setNoticeState(newPostDTO.getPostState());
    newNotice.setNoticeTitle(newPostDTO.getPostTitle());
    newNotice.setNoticeText(newPostDTO.getPostText());
    return dao.insert(newNotice);
  }

  public int updateNotice(PostUpdateRequestDTO updatePostDTO) {
    NoticeDTO updatedNotice = new NoticeDTO();
    updatedNotice.setNoticeNum(updatePostDTO.getPostNum());
    updatedNotice.setNoticeTitle(updatePostDTO.getTitle());
    updatedNotice.setNoticeText(updatePostDTO.getText());
    return dao.update(updatedNotice);
  }

  @Transactional
  public int deleteNotices(List<Integer> idsToDelete) {
    return dao.delete(idsToDelete);
  }
}
