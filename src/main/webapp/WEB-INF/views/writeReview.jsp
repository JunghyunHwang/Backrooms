<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>리뷰 작성</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script type="text/javascript">
$(document).ready(function(){ // 페이지 로드 완료 후 실행되도록 보장
    $("#submit").click(function(){
        // 부모 창 새로고침
        if (window.opener) { // 부모 창이 존재하는지 확인 (보안 및 안정성)
             window.opener.location.reload();
             // 또는 특정 URL로 이동: window.opener.location.href = '원하는_부모창_URL';
        }

        // 자식 창 닫기
        window.close();
    });
});
</script>
</head>
<body>
<form action="/backrooms/WriteReview" method="post">
  <div class="form-container">
    <h3>리뷰 작성</h3>
    <input type="text" id="reviewTitle" name="reviewTitle" placeholder="제목" required>
    <select id="rating" name="rating" required>
      <option value="">별점 선택</option>
      <option value="1">⭐ (1점)</option>
      <option value="2">⭐⭐ (2점)</option>
      <option value="3">⭐⭐⭐ (3점)</option>
      <option value="4">⭐⭐⭐⭐ (4점)</option>
      <option value="5">⭐⭐⭐⭐⭐ (5점)</option> 
    </select>
    <textarea id="reviewText" name="reviewText" placeholder="리뷰 내용을 입력하세요" required></textarea>
    <input type="file" id="imageUpload" name="imageUpload" accept="image/*">
    <img id="imagePreview" style="display:none;"><br>

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

