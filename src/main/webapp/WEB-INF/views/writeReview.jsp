<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>리뷰 작성</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script type="text/javascript">

</script>
</head>
<body>
<form id="review" action="/backrooms/UploadReview" method="post" enctype="multipart/form-data">
  <div class="form-container">
    <h3>리뷰 작성</h3>
    <input type="text" id="reviewTitle" name="reviewTitle" placeholder="제목" required>
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
    <input type="file" name="uploaderFile"><br>
	<!-- </form> -->
    <button type="submit" id="submit">등록</button>
    <button type="button" onclick="window.close()">취소</button>
  </div>
</form>
  <script>
    // 이미지 업로드 시 미리보기 표시
    document.getElementById("imageUpload").addEventListener("change", function(event) {
      var file = event.target.files[0];
      if (file) {
        var reader = new FileReader();
        reader.onload = function(e) {
          var imgPreview = document.getElementById("imagePreview");
          imgPreview.src = e.target.result;
          imgPreview.style.display = "block";
        };
        reader.readAsDataURL(file);
      }
    });

    // 리뷰 작성 후 저장
    function submitReview() {
      var author = document.getElementById("author").value.trim();
      var rating = document.getElementById("rating").value;
      var content = document.getElementById("reviewContent").value.trim();
      var imageUpload = document.getElementById("imageUpload");

      if (!author || !rating || !content) {
        alert("모든 필드를 입력해주세요.");
        return;
      }

      // 현재 날짜 가져오기
      var now = new Date();
      var dateStr = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();

      // 이미지 처리
      var imageUrl = "";
      if (imageUpload.files.length > 0) {
        var reader = new FileReader();
        reader.onload = function(e) {
          imageUrl = e.target.result; // base64 URL
          passReviewData(author, rating, content, dateStr, imageUrl);
        };
        reader.readAsDataURL(imageUpload.files[0]);
      } else {
        passReviewData(author, rating, content, dateStr, "");
      }
    }

    // 부모 창으로 데이터 전달
    function passReviewData(author, rating, content, date, imageUrl) {
      var reviewData = {
        author: author,
        rating: rating,
        content: content,
        date: date,
        imageUrl: imageUrl
      };

    </script>

</body>
</html>

