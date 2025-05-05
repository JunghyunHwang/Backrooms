<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>리뷰 작성</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    /* 전체 페이지 스타일 */
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f4f7f6;
      margin: 0;
      padding: 20px;
      display: flex;
      justify-content: center;
      align-items: flex-start; /* 위쪽에 정렬 */
      min-height: 100vh;
    }

    /* 폼 컨테이너 스타일 */
    .form-container {
      background-color: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 500px; /* 폼의 최대 너비 설정 */
    }

    /* 제목 스타일 */
    h3 {
      text-align: center;
      color: #333;
      margin-bottom: 25px;
      font-size: 24px;
    }

    /* 입력 필드 및 선택 박스 스타일 */
    input[type="text"],
    textarea,
    select {
      width: calc(100% - 22px); /* 패딩 고려하여 너비 설정 */
      padding: 11px;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 16px;
      box-sizing: border-box; /* 패딩과 테두리를 너비에 포함 */
    }

    textarea {
      resize: vertical; /* 세로 방향으로만 크기 조절 가능 */
      min-height: 150px; /* 최소 높이 설정 */
    }

    /* 파일 입력 필드 스타일 */
    input[type="file"] {
      margin-bottom: 15px;
      display: block; /* 블록 요소로 만들어 줄바꿈 */
    }

    /* 버튼 스타일 */
    button {
      padding: 10px 20px;
      margin-right: 10px;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    /* 등록 버튼 스타일 */
    button[type="submit"] {
      background-color: #007bff;
      color: white;
    }

    button[type="submit"]:hover {
      background-color: #0056b3;
    }

    /* 취소 버튼 스타일 */
    button[type="button"] {
      background-color: #6c757d;
      color: white;
    }

    button[type="button"]:hover {
      background-color: #5a6268;
    }

    /* 별점 선택 드롭다운 스타일 */
    select#rating {
        appearance: none; /* 기본 화살표 제거 (선택 사항) */
        background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.362%22%20height%3D%22292.362%22%3E%3Cpath%20fill%3D%22%23000000%22%20d%3D%22M287.857%2069.426l-14.292-14.292c-2.807-2.807-6.523-4.39-10.515-4.39s-7.708%201.584-10.515%204.39L146.181%20195.284%2040.016%2090.12c-2.807-2.807-6.523-4.39-10.515-4.39s-7.708%201.584-10.515%204.39l-14.292%2014.292c-2.807%202.807-4.39%206.523-4.39%2010.515s1.584%207.708%204.39%2010.515l117.333%20117.333c2.807%202.807%206.523%204.39%2010.515%204.39s7.708-1.584%2010.515-4.39l117.333-117.333c2.807-2.807%204.39-6.523%204.39-10.515s-1.584-7.708-4.39-10.515z%22%2F%3E%3C%2Fsvg%3E');
        background-repeat: no-repeat;
        background-position: right 10px center; /* 화살표 위치 조정 */
        background-size: 12px; /* 화살표 크기 조정 */
        padding-right: 30px; /* 화살표 공간 확보 */
    }
  </style>
</head>
<body>
<form id="review" action="/backrooms/UploadReview" method="post" enctype="multipart/form-data">
  <div class="form-container">
    <h3>리뷰 작성</h3>
    <input type="text" id="reviewTitle" name="reviewTitle" placeholder="제목" required>
    <!-- 숨겨진 입력 필드는 UI에 영향을 주지 않으므로 그대로 둡니다. -->
    <input type="hidden" id="memberNum" name="memberNum" value="1">
    <input type="hidden" id="roomNum" name="roomNum" value="1">
    <input type="hidden" id="hotelNum" name="hotelNum" value="1">
    <select id="rating" name="rating" required>
      <option value="">별점 선택</option>
      <option value="1">⭐ (1점)</option>
      <option value="2">⭐⭐ (2점)</option>
      <option value="3">⭐⭐⭐ (3점)</option>
      <option value="4">⭐⭐⭐⭐ (4점)</option>
      <option value="5">⭐⭐⭐⭐⭐ (5점)</option>
    </select>
    <textarea id="reviewText" name="reviewText" placeholder="리뷰 내용을 입력하세요" required></textarea>
   <%-- <form id="img" action="<c:url value="/upload1"/>" method="post" enctype="multipart/form-data"> --%>
   <input type="hidden" name="uploaderName">
    <input type="file" name="uploaderFile">
	<!-- </form> -->
    <button type="submit" id="submit">등록</button>
    <button type="button" onclick="window.close()">취소</button>
  </div>
</form>
  <script>
    // 기존 JavaScript 코드는 UI와 직접적인 관련이 적으므로 그대로 유지하거나 필요에 따라 수정합니다.
    // 이미지 미리보기 관련 코드는 input file 태그의 id가 imageUpload에서 uploaderFile로 변경되었으므로 수정이 필요합니다.
    // 또한, submitReview 함수는 현재 HTML form의 submit과는 별개로 작동하는 함수이므로, 만약 form submit을 사용하시려면 해당 함수는 제거하거나 로직을 변경해야 합니다.

    // 이미지 업로드 시 미리보기 표시 (uploaderFile ID 사용)
    // HTML에 imagePreview 요소가 없으므로, 미리보기를 원하시면 img 태그를 추가해야 합니다.
    const fileInput = document.getElementById("uploaderFile");
    // const imgPreview = document.getElementById("imagePreview"); // HTML에 추가 필요

    if (fileInput) {
        fileInput.addEventListener("change", function(event) {
            const file = event.target.files[0];
            if (file /* && imgPreview */) { // imgPreview 요소 존재 시 실행
                const reader = new FileReader();
                reader.onload = function(e) {
                    // imgPreview.src = e.target.result;
                    // imgPreview.style.display = "block";
                    console.log("Image selected, but no preview element (imagePreview) found in HTML.");
                    // TODO: 이미지 미리보기를 원하시면 <img id="imagePreview" style="display: none; max-width: 100%; margin-top: 15px;" src="#" alt="Image Preview"> 와 같은 요소를 form 안에 추가해주세요.
                };
                reader.readAsDataURL(file);
            } else if (!file) {
                 // 파일 선택이 취소되었을 때 미리보기 숨김 (imagePreview 요소 존재 시)
                // if(imgPreview) imgPreview.style.display = "none";
            }
        });
    }


    // 리뷰 작성 후 저장 함수 (HTML form submit과 별개로 작동)
    // 이 함수는 현재 HTML form 태그에 의해 submit 되는 방식과 다릅니다.
    // 만약 form 태그의 action="/backrooms/UploadReview" 경로로 데이터를 전송하려면
    // 이 submitReview 함수 대신 form의 기본 submit 동작을 사용해야 합니다.
    // 현재 <button type="submit"> 등록</button> 버튼은 form의 submit을 트리거합니다.
    // 따라서 아래 submitReview 함수는 사용되지 않을 가능성이 높습니다.
    /*
    function submitReview() {
      var author = document.getElementById("author").value.trim(); // HTML에 author ID 없음
      var rating = document.getElementById("rating").value;
      var content = document.getElementById("reviewContent").value.trim(); // HTML에 reviewContent ID 없음
      var imageUpload = document.getElementById("imageUpload"); // HTML에 imageUpload ID 없음

      // 필요한 요소 ID가 HTML과 일치하지 않습니다. (author, reviewContent, imageUpload)
      console.error("submitReview function: Element IDs do not match HTML structure.");

      if (!author || !rating || !content) {
        alert("모든 필드를 입력해주세요.");
        return;
      }

      var now = new Date();
      var dateStr = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();

      var imageUrl = "";
      if (imageUpload && imageUpload.files.length > 0) { // imageUpload 요소 존재 및 파일 선택 시
        var reader = new FileReader();
        reader.onload = function(e) {
          imageUrl = e.target.result;
          passReviewData(author, rating, content, dateStr, imageUrl);
        };
        reader.readAsDataURL(imageUpload.files[0]);
      } else {
        passReviewData(author, rating, content, dateStr, "");
      }
    }

    function passReviewData(author, rating, content, date, imageUrl) {
      var reviewData = {
        author: author,
        rating: rating,
        content: content,
        date: date,
        imageUrl: imageUrl
      };
       // 이 함수는 부모 창으로 데이터를 전달하는 로직이 빠져있습니다.
       // window.opener.postMessage(reviewData, '*'); 또는 다른 방법을 사용해야 합니다.
       console.log("Review data prepared:", reviewData);
    }
    */

  </script>

</body>
</html>
