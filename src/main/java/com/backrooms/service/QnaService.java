package com.backrooms.service;

import com.backrooms.dao.QnaDAO;
import com.backrooms.dto.EventDTO;
import com.backrooms.dto.ImageFileNamesDTO;
import com.backrooms.dto.ImageInsertDTO;
import com.backrooms.dto.ImageKind;
import com.backrooms.dto.MemberDTO;
import com.backrooms.dto.QnaDTO;
import com.backrooms.dto.QnaPageDTO;
import com.backrooms.dto.QnaUpdateRequestDTO;
import java.io.File;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.IOException;
import java.util.Base64;
import java.util.Base64;
import java.util.List;
import java.util.List;
import java.util.UUID;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.Pattern;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@RequiredArgsConstructor
@Service
public class QnaService {

  private static final String QNA_FILTER_All = "all";
  private static final String QNA_FILTER_PENDING = "pending";
  private static final String QNA_FILTER_COMPLETED = "completed";
  public static final String QNA_CATEGORY_ALL = "all";
  private static final String QNA_CATEGORY_RESERVATION = "reservation";
  private static final String QNA_CATEGORY_SERVICE = "service";
  private static final String QNA_CATEGORY_ROOM = "room";
  private static final String QNA_CATEGORY_PAYMENT = "payment";
  private static final String QNA_CATEGORY_REFUND = "refund";
  private static final String QNA_CATEGORY_ETC = "etc";

  private final QnaDAO dao;
  private final ImageService imageService;

  @Value("${file.dir:}")
  private String fileDir;

  @Transactional
  public int qnaAdd(QnaDTO dto, MemberDTO member) {
    // TODO Auto-generated method stub
    String memberName = member.getMemberName();
    //String memberName = "홍길동";
    int memberNum = member.getMemberNum();
    //int memberNum = 1;
    dto.setMemberName(memberName);
    dto.setMemberNum(memberNum);

    String text = dto.getQnaText();

    int imgcount = countImgTags(text);
    String qnaText = "";
    if (imgcount == 1) {
      //이미지 앞뒤 텍스트 추출
      Pattern textPattern = Pattern.compile("<p>(.*?)<img[^>]*>(.*?)<");
      Matcher textMatcher = textPattern.matcher(text);
      String textBefore = "", textAfter = "";
      if (textMatcher.find()) {
        textBefore = textMatcher.group(1).trim();
        textAfter = textMatcher.group(2).trim();
      }
      qnaText = textBefore + " " + textAfter;
    } else {
      qnaText = Jsoup.parse(text).text();
    }
    dto.setQnaText(qnaText);

    int check = dao.insert(dto);
    if (check == 0) {
      return 0;
    }

    return dto.getQnaNum();
  }

  public QnaPageDTO getQnaPagination(int curPage, String filter, String qnaCategory) {
    log.warn("filter ={}, category = {}", filter, qnaCategory);
    QnaPageDTO qnaPageDTO = new QnaPageDTO();
    List<QnaDTO> qnaList = null;
    int totalCount = 0;
    int perPage = qnaPageDTO.getPerPage();
    int offset = (curPage - 1) * perPage;

    if (qnaCategory.equals(QNA_CATEGORY_ALL)) {
      //All
      if (filter.equals(QNA_FILTER_All)) {
        qnaList = dao.getAllQNAs(offset, perPage);
        totalCount = dao.getAllQnAsTotalCount();
      } else if (filter.equals(QNA_FILTER_PENDING)) {
        qnaList = dao.getPendingQNAs(offset, perPage);
        totalCount = dao.getPendingQNAsTotalCount();
      } else if (filter.equals(QNA_FILTER_COMPLETED)) {
        qnaList = dao.getCompletedQNAs(offset, perPage);
        totalCount = dao.getComplectedQNAsTotalCount();
      }
      //Service
    } else if (qnaCategory.equals(QNA_CATEGORY_SERVICE)) {
      if (filter.equals(QNA_FILTER_All)) {
        qnaList = dao.getAllServices(offset, perPage);
        totalCount = dao.getAllServicesTotalCount();
      } else if (filter.equals(QNA_FILTER_PENDING)) {
        qnaList = dao.getPendingServices(offset, perPage);
        totalCount = dao.getPendingServicesTotalCount();
      } else if (filter.equals(QNA_FILTER_COMPLETED)) {
        qnaList = dao.getCompletedServices(offset, perPage);
        totalCount = dao.getCompletedServicesTotalCount();
      }
      //room:
    } else if (qnaCategory.equals(QNA_CATEGORY_ROOM)) {
      if (filter.equals(QNA_FILTER_All)) {
        qnaList = dao.getAllRooms(offset, perPage);
        totalCount = dao.getAllRoomsTotalCount();
      } else if (filter.equals(QNA_FILTER_PENDING)) {
        qnaList = dao.getPendingRooms(offset, perPage);
        totalCount = dao.getPendingRoomsTotalCount();
      } else if (filter.equals(QNA_FILTER_COMPLETED)) {
        qnaList = dao.getCompletedRooms(offset, perPage);
        totalCount = dao.getCompletedRoomsTotalCount();
      }
      //payment
    } else if (qnaCategory.equals(QNA_CATEGORY_PAYMENT)) {
      if (filter.equals(QNA_FILTER_All)) {
        qnaList = dao.getAllPayment(offset, perPage);
        totalCount = dao.getAllPaymentTotalCount();
      } else if (filter.equals(QNA_FILTER_PENDING)) {
        qnaList = dao.getPendingPayment(offset, perPage);
        totalCount = dao.getPendingPaymentTotalCount();
      } else if (filter.equals(QNA_FILTER_COMPLETED)) {
        qnaList = dao.getCompletedPayment(offset, perPage);
        totalCount = dao.getCompletedPaymentTotalCount();
      }
      //refund
    } else if (qnaCategory.equals(QNA_CATEGORY_REFUND)) {
      if (filter.equals(QNA_FILTER_All)) {
        qnaList = dao.getAllRefund(offset, perPage);
        totalCount = dao.getAllRefundTotalCount();
      } else if (filter.equals(QNA_FILTER_PENDING)) {
        qnaList = dao.getPendingRefund(offset, perPage);
        totalCount = dao.getPendingRefundTotalCount();
      } else if (filter.equals(QNA_FILTER_COMPLETED)) {
        qnaList = dao.getCompletedRefund(offset, perPage);
        totalCount = dao.getCompletedRefundTotalCount();
      }
      //reservation
    } else if (qnaCategory.equals(QNA_CATEGORY_RESERVATION)) {
      if (filter.equals(QNA_FILTER_All)) {
        qnaList = dao.getAllReservations(offset, perPage);
        totalCount = dao.getAllReservationsTotalCount();
      } else if (filter.equals(QNA_FILTER_PENDING)) {
        qnaList = dao.getPendingReservations(offset, perPage);
        totalCount = dao.getPendingReservationsTotalCount();
      } else if (filter.equals(QNA_FILTER_COMPLETED)) {
        qnaList = dao.getCompletedReservations(offset, perPage);
        totalCount = dao.getCompletedReservationsTotalCount();
      }
    }
    //etc
    else if (qnaCategory.equals(QNA_CATEGORY_ETC)) {
      if (filter.equals(QNA_FILTER_All)) {
        qnaList = dao.getAllEtc(offset, perPage);
        totalCount = dao.getAllEtcTotalCount();
      } else if (filter.equals(QNA_FILTER_PENDING)) {
        qnaList = dao.getPendingEtc(offset, perPage);
        totalCount = dao.getPendingEtcTotalCount();
      } else if (filter.equals(QNA_FILTER_COMPLETED)) {
        qnaList = dao.getCompletedEtc(offset, perPage);
        totalCount = dao.getCompletedEtcTotalCount();
      }
    }

    qnaPageDTO.setCurPage(curPage);
    qnaPageDTO.setQnaList(qnaList);
    qnaPageDTO.setTotalCount(totalCount);
    return qnaPageDTO;
  }

  public QnaDTO getQnaDetail(int postNum) {
    QnaDTO qnaDetail = dao.selectOne(postNum);

    List<ImageFileNamesDTO> imageFileNamesList = imageService.getUploadAndStoreFileNames(
      postNum,
      ImageKind.fromInt(5) // QnA에 해당하는 ImageKind 값
    );
    if (!imageFileNamesList.isEmpty()) {
      ImageFileNamesDTO imageFileName = imageFileNamesList.get(0);
      qnaDetail.setImageFileName(imageFileName.getImageUploadFileName());
    } else {
      qnaDetail.setImageFileName(null);
    }

    return qnaDetail;
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

  public void saveImage(String text, int qnaNum) throws FileNotFoundException, IOException {
    // Base64 이미지 추출
    Pattern base64Pattern = Pattern.compile("src=\"data:image/\\w+;base64,([^\"]+)\"");
    Matcher base64Matcher = base64Pattern.matcher(text);
    String base64Image = base64Matcher.find() ? base64Matcher.group(1) : "";

    // 파일명 추출
    Pattern filenamePattern = Pattern.compile("data-filename=\"([^\"]+)\"");
    Matcher filenameMatcher = filenamePattern.matcher(text);
    String fileName = filenameMatcher.find() ? filenameMatcher.group(1) : "";

    // 확장자 추출
    String extension = fileName.substring(fileName.lastIndexOf("."));

    String imagePath = fileDir + "qna/";

    if (!base64Image.isEmpty()) {
      // Base64 디코딩
      byte[] decodedBytes = Base64.getDecoder().decode(base64Image);

      // 고유한 파일명 생성
      String imageStoreFileName = UUID.randomUUID().toString() + extension;

      // 디렉토리 없으면 생성
      File dir = new File(imagePath);
      if (!dir.exists()) {
        dir.mkdirs(); // 상위 디렉토리까지 생성
      }

      // 이미지 파일 저장
      try (FileOutputStream fos = new FileOutputStream(imagePath + fileName)) {
        fos.write(decodedBytes);
      }

      // image 테이블에 저장할 데이터 생성
      ImageInsertDTO imageInsertDTO = new ImageInsertDTO(5, qnaNum, fileName, imageStoreFileName);

      dao.saveImage(imageInsertDTO);
    }
  }

  public String getImagesByPostNum(int postNum) {
    return dao.getImagesByPostNum(postNum); // DAO에서 이미지를 가져오는 메소드 호출
  }

  public int countImgTags(String text) {
    // <img> 태그의 개수를 세기 위한 정규 표현식
    String imgTagRegex = "<img[^>]*>";
    Pattern pattern = Pattern.compile(imgTagRegex);
    Matcher matcher = pattern.matcher(text);

    int count = 0;
    while (matcher.find()) {
      count++;
    }
    return count;
  }
}
