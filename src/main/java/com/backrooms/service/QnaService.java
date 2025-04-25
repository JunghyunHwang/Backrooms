package com.backrooms.service;

import com.backrooms.dao.QnaDAO;
import com.backrooms.dto.MemberDTO;
import com.backrooms.dto.QnaDTO;
import com.backrooms.dto.QnaPageDTO;
import com.backrooms.dto.QnaUpdateRequestDTO;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class QnaService {

  private final QnaDAO dao;

  @Transactional
  public int qnaAdd(QnaDTO dto, MemberDTO member) {
    // TODO Auto-generated method stub
    String memberName = member.getMemberName();
    //String memberName = "홍길동";
    int memberNum = member.getMemberNum();
    //int memberNum = 1;
    dto.setMemberName(memberName);
    dto.setMemberNum(memberNum);

    int check = dao.insert(dto);
    return check;
  }

  public QnaPageDTO getQnaPagination(int curPage, String filter) {
    QnaPageDTO qnaPageDTO = new QnaPageDTO();
    List<QnaDTO> qnaList = null;
    int totalCount = 0;
    int perPage = qnaPageDTO.getPerPage();
    int offset = (curPage - 1) * perPage;

    switch (filter) {
      case "all": {
        qnaList = dao.selectList(offset, perPage);
        totalCount = dao.totalCount();
        break;
      }
      case "pending": {
        qnaList = dao.selectPendingList(offset, perPage);
        totalCount = dao.totalPendingCount();
        break;
      }
      case "completion": {
        qnaList = dao.selectCompletionList(offset, perPage);
        totalCount = dao.totalCompletionCount();
        break;
      }
      default:
        throw new IllegalArgumentException(
          filter + "는 관리자-공지사항 게시판에서 지원되지 않는 필터 형식입니다."
        );
    }

    qnaPageDTO.setCurPage(curPage);
    qnaPageDTO.setQnaList(qnaList);
    qnaPageDTO.setTotalCount(totalCount);

    return qnaPageDTO;
  }

  public QnaDTO getQnaDetail(int postNum) {
    return dao.selectOne(postNum);
  }

  public QnaPageDTO getMyQna(int curPage, MemberDTO member) {
    // TODO Auto-generated method stub
    int memberNum = member.getMemberNum();
    //int memberNum = 1;
    QnaPageDTO qnaPageDTO = new QnaPageDTO();
    List<QnaDTO> qnaList = null;
    int perPage = qnaPageDTO.getPerPage();
    int offset = (curPage - 1) * perPage;

    qnaList = dao.selectMyList(offset, perPage, memberNum);
    int totalCount = dao.totalCount();

    qnaPageDTO.setCurPage(curPage);
    qnaPageDTO.setQnaList(qnaList);
    qnaPageDTO.setTotalCount(totalCount);

    return qnaPageDTO;
  }

  public int updatQna(QnaUpdateRequestDTO updatePostDTO) {
    QnaDTO updatedQna = new QnaDTO();
    updatedQna.setQnaNum(updatePostDTO.getPostNum());
    updatedQna.setQnaReply(updatePostDTO.getQnaReplay());
    return dao.update(updatedQna);
  }

  public int deleteQnas(List<Integer> idsToDelete) {
    return dao.delete(idsToDelete);
  }
}
