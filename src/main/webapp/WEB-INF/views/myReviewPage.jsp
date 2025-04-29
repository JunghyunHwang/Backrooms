<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="com.backrooms.dto.MemberDTO"%>
<%@page import="com.backrooms.dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Backroom - 내 리뷰</title>
<link rel="icon" type="image/x-icon" href="assets/img/favicon.ico">
<!-- CSS Files -->
<jsp:include page="commonCss.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<script type="text/javascript">
 $(document).ready(function() {
	$(".delBtn").click(function() {
		var num = $(this).attr("data-xxx");
		location.href = "/deleteReview";
	});
}); 
</script>
</head>

<body>

	<!-- Start Preloader -->

	<!--  
	<div class="preloader_wrap">
		<div class="preloader">
			<span style="--i: 1"></span> <span style="--i: 2"></span> <span
				style="--i: 3"></span> <span style="--i: 4"></span> <span
				style="--i: 5"></span> <span style="--i: 6"></span> <span
				style="--i: 7"></span> <span style="--i: 8"></span> <span
				style="--i: 9"></span> <span style="--i: 10"></span> <span
				style="--i: 11"></span> <span style="--i: 12"></span> <span
				style="--i: 13"></span> <span style="--i: 14"></span> <span
				style="--i: 15"></span> <span style="--i: 16"></span> <span
				style="--i: 17"></span> <span style="--i: 18"></span> <span
				style="--i: 19"></span> <span style="--i: 20"></span>  -->
	<!-- <h2>Trvelo</h2>-->
	<!-- 	<div class="preloader_icon fa-solid fa-jet-fighter"></div> -->
	<!-- </div>
	</div> -->
	<!--   End Preloader -->

	<!-- Offcanvas Area Start -->
	<div class="fix-area">
		<div class="offcanvas__info">
			<div class="offcanvas__wrapper">
				<div class="offcanvas__content">
					<div
						class="offcanvas__top d-flex justify-content-between align-items-center">
						<div class="offcanvas__logo">
							<a href="index.html"> <img src="assets/img/logo.svg"
								alt="edutec">
							</a>
						</div>
						<div class="offcanvas__close">
							<button>
								<i class="fas fa-times"></i>
							</button>
						</div>
					</div>
					<div class="mobile-menu fix mb-3"></div>
				</div>
			</div>
		</div>
	</div>

	<div class="offcanvas__overlay"></div>

	<!-- Start Header -->
	<jsp:include page="common/header.jsp"></jsp:include>
	<!-- End Header -->

	<!-- Start Left Bar -->
	<section class="tour_details section-padding"
		style="min-height: calc(100vh - 100px);">
		<div class="container">
			<div class="row">

				<div class="col-lg-4 col-12 wow fadeIn">
					<div class="tour_widget">
						<h2 class="tw_title">내 페이지</h2>
						<ul class="tw_info">
							<li><a href="myPageUserProf.html">회원 정보</a></li>
							<li><a href="myPageResBox.html">예약 관리</a></li>
							<li><a href="MyQnA.html">내 문의</a></li>
							<li><a href="MyReview">내 리뷰</a></li>
						</ul>

					</div>


				</div>
				<!--- END COL -->
				<div class="col-lg-8 col-12 wow fadeIn">
					<div class="reviewbody">
						<div class="tdetails_meta">
							<div class="reviewcontainer">
								<h1>내 리뷰</h1>

								<!-- 리뷰 리스트 -->
								<table class="review-list">
									<thead>
										<tr>
											<th>제목</th>
											<th>별점</th>
											<th>내용</th>
											<th>날짜</th>
											<th>이미지</th>
											<th>삭제버튼</th>
										</tr>
									</thead>
									<tbody id="reviewList">
<c:set var="rlist" value="${requestScope.myReview}" /> <%-- EL로 request attribute 접근 --%>
<c:if test="${empty rlist}"> <%-- 목록이 비어있거나 null인 경우 --%>
						<tr>
							<td colspan="6">목록이 없습니다.</td>
						</tr>
						</c:if>
<c:if test="${not empty rlist}"> <%-- 목록이 비어있지 않은 경우 --%>
<c:forEach var="review" items="${rlist}"> <%-- 목록을 반복하며 review 변수에 담음 --%>
									<tr>
											<th>${review.reviewTitle}</th>
											<th>${review.starRating}</th>
											<th>${review.reviewText}</th>
											<th>${review.reviewDate}</th>
											<th>image</th>
											<form class="delForm" action="/backrooms/deleteReview" method="post">
											 <input type="hidden" id="reviewNumInput" name="reviewNum" value="${review.reviewTitle}">
											<th><button class="delBtn">삭제</button></th>
											</form>
										</td>
											
										</tr>
										</c:forEach>
											</c:if>
									</tbody>
								</table>

								<!-- 페이지네이션 -->
								<div class="reviewpagination"
									style="display: flex; justify-content: center; margin-top: 20px;">
									<button onclick="prevPage()"><</button>
									<span id="currentPage">1</span>
									<button onclick="nextPage()">></button>
								</div>

								<!-- 리뷰 작성 버튼 -->

								<div class="review-container" style="text-align: right;">
									<button class="form-button" onclick="openReviewWrite()">리뷰
										작성</button>
								</div>

							</div>
						
							<script>

						
    var currentPage = 1;
    var reviewsPerPage = 5;
    var reviews = []; // 리뷰 데이터를 저장할 배열

    var now = new Date();
    var dateStr = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
   // 페이지네이션 기능
    function prevPage() {
      if (currentPage > 1) {
        currentPage--;
        renderReviews();
      }
    }

    function nextPage() {
      if (currentPage < Math.ceil(reviews.length / reviewsPerPage)) {
        currentPage++;
        renderReviews();
      }
    }

    // 자식 창 열기
    function openReviewWrite() {
      window.open('/backrooms/WriteReview', '리뷰 작성', 'width=600,height=600');
    }
  </script>

						</div>
						<!-- END Tour Meta -->


					</div>
				</div>
				<!--- END COL -->

			</div>
			<!--- END ROW -->
		</div>
		<!--- END CONTAINER -->
	</section>
	<!-- End Left Bar -->

	<!-- Start footer -->
	<jsp:include page="common/footer.jsp"></jsp:include>
	<!-- End footer -->

	<!-- Start progress-wrap -->
	<div class="progress-wrap">
		<svg class="progress-circle svg-content" width="100%" height="100%"
			viewBox="-1 -1 102 102">
				<path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98" />
			</svg>
	</div>
	<!-- End progress-wrap -->

	<!-- JS Script -->

	<jsp:include page="commonJs.jsp"></jsp:include>
</body>
</html>