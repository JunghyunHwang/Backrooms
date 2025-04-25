<%@page import="java.util.List"%>
<%@page import="com.backrooms.dto.EventDTO"%>
<%@page import="com.backrooms.dto.EventPageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Backroom - eventDetail</title>
	<jsp:include page="commonCss.jsp"></jsp:include>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
	<script>
	  $(function() {
		  //console에서 테스트이후에 일반 공지사항, 이벤트 게시판에서 수정버튼 관련 로직은 삭제될 예정 
		  //
		    
		    $("#backBtn").click(function() {
		      window.history.back();
		    });
		  });
	</script>
  </head>
  <body>
    <!-- Start Preloader -->
    <!-- End Preloader -->

    <!-- Offcanvas Area Start -->
     <!-- Offcanvas Area End -->

    <div class="d-flex flex-column min-vh-100">
      <!-- Start Header -->
      <jsp:include page="common/header.jsp"></jsp:include>
      <!-- End Header -->
      <!-- Main Content with fixed height so that 7 rows are visible -->
      <!-- 메인 콘텐츠: 고정 높이를 지정하여 7개의 데이터 행이 항상 보이도록 합니다. -->
      <main class="container my-5 flex-grow-1">
        <h2 class="fw-bold mb-3">이벤트</h2>
  <section class="bg-white p-4 rounded border shadow-sm d-flex flex-column">
  <div class="table-responsive flex-grow-1" style="min-height: 300px; overflow-y: auto">
    <!-- Read-Only Display -->
    <div id="displayMode">
      <div class="mb-2">
      <h2 class="mb-3 fs-2">${eventDetail.eventTitle}</h2>
        <span class="fs-6 fw-bold">${eventDetail.memberName}</span>
        <span class="text-muted fs-6"> | 🕐 ${eventDetail.eventDate}</span>
      </div>
      <hr>
      <p id="eventTextDisplay" class="fs-5">${eventDetail.eventText}</p>
    </div>
    <!-- Edit Mode (hidden by default) -->
<div id="editMode" class="d-none">
  <input type="text" id="eventTitleInput" class="form-control mb-2 fs-2" value="${eventDetail.eventTitle}">
  <textarea id="eventTextInput" class="form-control fs-5" style="height: 207px;" rows="30">${eventDetail.eventText}</textarea>
</div>
  </div>
  <!-- Button Row: 뒤로가기 and Edit/Complete -->
  <div class="d-flex justify-content-center mt-3">
    <button id="backBtn" class="btn btn-secondary me-3">뒤로가기</button>

  </div>
</section>
      </main>

      <!--TODO:  footer id footer로 변경 예정: footer 공용틀 id만 남기고 class삭제한 이후에 -->
      <!-- Start footer -->
		<jsp:include page="common/footer.jsp"></jsp:include>
    </div>
    <!-- End footer -->

    <!-- Start progress-wrap -->
    <div class="progress-wrap">
      <svg
        class="progress-circle svg-content"
        width="100%"
        height="100%"
        viewBox="-1 -1 102 102"
      >
        <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98" />
      </svg>
    </div>
    <!-- End progress-wrap -->
    <script>
    //
    
    //
    </script>
    <!-- Include Bootstrap JS and dependencies -->
	<jsp:include page="commonJs.jsp"></jsp:include>
  </body>
</html>