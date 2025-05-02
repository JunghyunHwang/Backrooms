package com.backrooms.controller;

import com.backrooms.service.ImageService;
import java.net.MalformedURLException;
import java.nio.charset.StandardCharsets;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.UriUtils;

@Slf4j
@RequiredArgsConstructor
@Controller
public class ImageController {

  private final ImageService imageService;

  /**
   * 컨트롤러를 만든 이유: 정적인 자원들은 빌드시 포함되고 이후에 변경이 잘 되지 않아서 빌드시 계속 남아있습니다.
   * 그래서 단순히 해당 경로로 요청을 해서 가져올수있는데요 이미지 업로드같이 빌드된 이후에 동적으로 추가될수 있는 리소스들은 다시 빌드 전까진 톰캣에 전달이
   * 되지 않아서 가져올수 없기때문에 우선 컨트롤러에서 로컬 경로에 있는 파일을 읽어서 응답해주도록 했습니다
   *
   * jsp에서 Img 태그의 src에 아래처럼 경로 넣어서 사용해주세요.
   * review는 아래 경로로 사용해주세요
   * '${pageContext.request.contextPath}' + '/images/review/' + storeFileName;
   * notice, event, qna는 아래 경로로 사용해주세요
   * '${pageContext.request.contextPath}' + '/images/board/' + storeFileName;
   */
  @ResponseBody
  @GetMapping("/images/{category}/{storeFieName}")
  public UrlResource getImage(@PathVariable String storeFieName, @PathVariable String category)
    throws MalformedURLException {
    return new UrlResource("file:" + imageService.getFullPathByCategory(category, storeFieName));
  }

  @GetMapping("/attach/{category}/{storeFieName}")
  public ResponseEntity<Resource> attach(@PathVariable String storeFieName, @PathVariable String category)
    throws MalformedURLException {
    String uploadName = imageService.getUploadFileName(storeFieName);
    UrlResource resource = new UrlResource(
      "file:" + imageService.getFullPathByCategory(category, storeFieName)
    );
    String encoudedUploadFileName = UriUtils.encode(uploadName, StandardCharsets.UTF_8);
    String contentDisposition = "attachment; filename=\"" + encoudedUploadFileName + "\"";
    return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, contentDisposition).body(resource);
  }
}
