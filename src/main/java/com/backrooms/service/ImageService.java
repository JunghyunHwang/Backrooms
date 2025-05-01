package com.backrooms.service;

import com.backrooms.dao.ImageDAO;
import com.backrooms.dto.ImageFileNamesDTO;
import com.backrooms.dto.ImageFileQueryDTO;
import com.backrooms.dto.ImageInsertDTO;
import com.backrooms.dto.ImageKind;
import com.backrooms.exception.FileStorageException;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@RequiredArgsConstructor
@Service
@Slf4j
public class ImageService {

  public static final String HOTEL_ROOMS = "hotel-rooms";
  public static final String BOARD = "board";
  public static final String REVIEW = "review";
  private final ImageDAO dao;

  /**
   * * application.properties에 아래값 꼭 추가 해주세요
   * * file.dir = 절대경로(로컬에 이 프로젝트가 있는 폴더내에 src/main/resources/static/assets/img/ 까지 적어주세요
   * 예시: file.dir=/Users/jinbaek/Desktop/team-project/backrooms-boot/Backrooms/src/main/resources/static/assets/img/
   * 운영체제와 로컬 환경에따라 앞에 경로 부분(Backrooms 전까지)은 달라집니다. 뒤에 이 부분 /Backrooms/src/main/resources/static/assets/img/ 까지는 맞춰주세요
   */

  //application-properties에서 설정한 file.dir=경로 에서 file.dir값에 해당되는 경로를 읽어옵니다
  @Value("${file.dir}")
  private String fileDir;

  public String createStoreFileName(int imageUse, ImageKind kind) {
    return dao.getStoreFileName(new ImageFileQueryDTO(imageUse, kind.getValue()));
  }

  public String getUploadName(String storeFileName) {
    return dao.getUploadFileName(storeFileName);
  }

  public List<ImageFileNamesDTO> getImageFileNames(int imageUse, ImageKind kind) {
    return dao.getUploadAndStoreFileNames(new ImageFileQueryDTO(imageUse, kind.getValue()));
  }

  // 초기 이미지 테이블 설계시에는 이미지만 넣는 용도로 설계했으나 이미지뿐 아니라 다른 파일 정보도 저장할수있게 사용하게 됐습니다(board에서 여러종류의 파일을 업로드/다운로드 지원합니다)
  public void storeFiles(List<MultipartFile> files, ImageKind kind, int imageUse) throws Exception {
    files.forEach(file -> {
      if (file == null || file.isEmpty() || file.getOriginalFilename() == null) {
        return;
      }

      String uploadFileName = file.getOriginalFilename();
      String storeFileName = createStoreFileName(uploadFileName);
      //파일 정보를 디비(이미지 테이블)에 저장
      int insertResult = dao.insertFile(
        new ImageInsertDTO(kind.getValue(), imageUse, uploadFileName, storeFileName)
      );
      if (insertResult != 1) {
        throw new FileStorageException("파일을 이미지 테이블에 저장하는 도중에 에러가 발생했습니다");
      }
      //실제 파일을 로컬에 저장
      saveFileToDisk(file, kind, storeFileName);
    });
  }

  public void saveFileToDisk(MultipartFile file, ImageKind kind, String storeFileName) {
    if (file == null || file.isEmpty() || storeFileName.isEmpty()) {
      return;
    }

    try {
      file.transferTo(new File(getFullPathByImageKind(kind, storeFileName)));
    } catch (IOException e) {
      throw new FileStorageException(
        "파일을 로컬 저장소에 저장하는 과정에서 에러가 발생했습니다: " + e.getMessage(),
        e
      );
    }
  }

  /**
   *
   * 아래 메소드는
   * /assets/img/hotel-rooms
   * /assets/img/review
   * /assets/img/board
   * 와 같이 imageKind에 따라 저장되는 폴더를 나눠주는 메소드입니다
   */
  private String getFullPathByImageKind(ImageKind kind, String storeFileName) {
    String categoryPath = ""; //
    switch (kind) {
      case ROOM:
        categoryPath = HOTEL_ROOMS;
        break;
      case REVIEW:
        categoryPath = REVIEW;
        break;
      case NOTICE:
        categoryPath = BOARD;
        break;
      case EVENT:
        categoryPath = BOARD;
        break;
      case QNA:
        categoryPath = BOARD;
        break;
      default:
        throw new IllegalStateException(kind + " 는 지원하지 않는 이미지 종류입니다: ");
    }

    return fileDir + categoryPath + "/" + storeFileName;
  }

  public String getFullPathByCategory(String category, String storeFileName) {
    switch (category) {
      case HOTEL_ROOMS:
        break;
      case BOARD:
        break;
      case REVIEW:
      default:
        throw new IllegalStateException(category + " 는 지원하지 않는 이미지 카테고리입니다: ");
    }
    return fileDir + category + "/" + storeFileName;
  }

  private static String createStoreFileName(String originalFilename) {
    int lastDot = originalFilename.lastIndexOf(".");
    String ext = originalFilename.substring(lastDot + 1);
    return UUID.randomUUID().toString() + "." + ext;
  }
}
