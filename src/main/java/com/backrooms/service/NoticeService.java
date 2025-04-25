package com.backrooms.service;

import com.backrooms.dao.NoticeDAO;
import com.backrooms.dto.NoticeDTO;
import com.backrooms.dto.NoticePageDTO;
import com.backrooms.dto.PostCreateRequestDTO;
import com.backrooms.dto.PostUpdateRequestDTO;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class NoticeService {

  private final NoticeDAO dao;

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
    return dao.selectOne(noticeNum);
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
