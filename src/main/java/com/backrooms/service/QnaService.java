package com.backrooms.service;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.backrooms.dao.QnaDAO;
import com.backrooms.dto.ImageInsertDTO;
import com.backrooms.dto.MemberDTO;
import com.backrooms.dto.QnaDTO;
import com.backrooms.dto.QnaPageDTO;
import com.backrooms.dto.QnaUpdateRequestDTO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class QnaService {

  private final QnaDAO dao;
  
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
    if(imgcount == 1) {
    //이미지 앞뒤 텍스트 추출
    Pattern textPattern = Pattern.compile("<p>(.*?)<img[^>]*>(.*?)<");
    Matcher textMatcher = textPattern.matcher(text);
    String textBefore = "", textAfter = "";
    if (textMatcher.find()) {
        textBefore = textMatcher.group(1).trim();
        textAfter = textMatcher.group(2).trim();
    }
    qnaText = textBefore+" "+textAfter;
   
    }
    else {
    	qnaText = Jsoup.parse(text).text();
    	
    	
    }
    dto.setQnaText(qnaText);
    
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

public void saveImage(String text) throws FileNotFoundException, IOException {
	
	
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
           String imageStoreFileName = UUID.randomUUID().toString()+extension;
           
           
           // 이미지 파일 저장
           try (FileOutputStream fos = new FileOutputStream(imagePath + fileName)) {
               fos.write(decodedBytes);
           }
           
           // image 테이블에 저장할 데이터 생성
           ImageInsertDTO imageInsertDTO = new ImageInsertDTO(5, 1, fileName, imageStoreFileName);
         
           
         
           dao.saveImage(imageInsertDTO);
           
       }
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
