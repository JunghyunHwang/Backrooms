<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trvelo - Travel Agency HTML Template</title>
<jsp:include page="commonCss.jsp"></jsp:include>
</head>

<body>

	<!-- Start Preloader -->
	<div class="preloader_wrap">
		<div class="preloader">
			<span style="-i: 1"></span> <span style="-i: 2"></span> <span
				style="-i: 3"></span> <span style="-i: 4"></span> <span
				style="-i: 5"></span> <span style="-i: 6"></span> <span
				style="-i: 7"></span> <span style="-i: 8"></span> <span
				style="-i: 9"></span> <span style="-i: 10"></span> <span
				style="-i: 11"></span> <span style="-i: 12"></span> <span
				style="-i: 13"></span> <span style="-i: 14"></span> <span
				style="-i: 15"></span> <span style="-i: 16"></span> <span
				style="-i: 17"></span> <span style="-i: 18"></span> <span
				style="-i: 19"></span> <span style="-i: 20"></span>
			<h2>Trvelo</h2>
			<div class="preloader_icon fa-solid fa-jet-fighter"></div>
		</div>
	</div>
	<!-- End Preloader -->

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

	<jsp:include page="common/header.jsp"></jsp:include>

	<!-- Start Left Bar -->
	<section class="tour_details section-padding">
		<div class="container">
			<div class="row">

				<div class="col-lg-4 col-12 wow fadeIn">
					<div class="tour_widget">
						<h2 class="tw_title">내 페이지</h2>
						<ul class="tw_info">
							<li><a href="<c:url value='/MyPage?myPage=profile' />">회원 정보</a></li>
							<li><a href="<c:url value='/MyPage?myPage=reservation' />">예약 관리</a></li>
							<li><a href="<c:url value='/MyPage?myPage=myqna' />">내 문의</a></li>
							<li><a href="<c:url value='/MyPage?myPage=review' />">내 리뷰</a></li>
						</ul>

					</div>


				</div>
				<!--- END COL -->
				<c:set var="myPage" value="${param.myPage}" />
				<c:choose>
					<c:when test="${myPage eq 'reservation'}">
						<jsp:include page="myPage/reservation.jsp" />
					</c:when>
					<c:when test="${myPage eq 'myqna'}">
						<jsp:include page="myPage/myqna.jsp" />
					</c:when>
					<c:when test="${myPage eq 'review'}">
						<jsp:include page="myPage/review.jsp" />
					</c:when>
					<c:otherwise>
						<jsp:include page="myPage/profile.jsp" />
					</c:otherwise>

				</c:choose>
				<!--- END COL -->

			</div>
			<!--- END ROW -->
		</div>
		<!--- END CONTAINER -->
	</section>
	<!-- End Left Bar -->

	<jsp:include page="common/footer.jsp"></jsp:include>

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
	<script>
			// START Recomanded
			var mixproduct = mixitup('.tour_items');			
			// END Recomanded

			jQuery('select').niceSelect();
					
		</script>
</body>
</html>