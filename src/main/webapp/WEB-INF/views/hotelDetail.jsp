<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상세 페이지</title>
    <jsp:include page="commonCss.jsp"></jsp:include>
    <link rel="stylesheet" href="assets/css/hotel-details.css">
</head>

<body>
<!-- Start Preloader -->
<div class="preloader_wrap">
    <div class="preloader">
        <span style="--i:1"></span>
        <span style="--i:2"></span>
        <span style="--i:3"></span>
        <span style="--i:4"></span>
        <span style="--i:5"></span>
        <span style="--i:6"></span>
        <span style="--i:7"></span>
        <span style="--i:8"></span>
        <span style="--i:9"></span>
        <span style="--i:10"></span>
        <span style="--i:11"></span>
        <span style="--i:12"></span>
        <span style="--i:13"></span>
        <span style="--i:14"></span>
        <span style="--i:15"></span>
        <span style="--i:16"></span>
        <span style="--i:17"></span>
        <span style="--i:18"></span>
        <span style="--i:19"></span>
        <span style="--i:20"></span>
        <h2>Backrooms</h2>
        <div class="preloader_icon fa-solid fa-jet-fighter"></div>
    </div>
</div>
<!-- End Preloader -->

<!-- Offcanvas Area Start -->
<div class="fix-area">
    <div class="offcanvas__info">
        <div class="offcanvas__wrapper">
            <div class="offcanvas__content">
                <div class="offcanvas__top d-flex justify-content-between align-items-center">
                    <div class="offcanvas__logo">
                        <a href="index.html">
                            <img src="assets/img/logo.svg" alt="edutec">
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

<!-- Start Banner -->
<section class="main_banner" style="background-image: url(../resources/static/assets/img/sample/hotel-main.jpg);">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <h1>Hotel Details</h1>
            </div>
        </div>
    </div>
</section>
<!-- End Start Banner -->

<!-- Start searchFilter -->
<jsp:include page="common/searchFilter.jsp"></jsp:include>
<!-- End searchFilter -->

<!-- Start hotel info -->
<section class="p-3">
    <div class="container">
        <div class="row">
            <div class="col-12 wow fadeIn">
                <div class="section-hotel-details">
                    <div class="hotel-details-meta">
                        <div class="hotel-info d-flex justify-content-between align-items-center rounded">
                            <div>
                                <div><h4>${ hotel.hotelName }</h4></div>
                                <a href="https://www.google.com/maps/search/?api=1&query=${ hotel.hotelName }"
                                   target="_blank">
                                    지도에서 보기
                                </a>
                            </div>
                            <div class="text-primary fw-bold fs-4">
                                ${ hotel.rooms[0].formattedPrice }원
                                <a href="#select-rooms" class="btn btn-primary btn-lg">객실 선택</a>
                            </div>
                        </div>
                    </div>
                    <c:set var="exteriorImageCount" value="${ hotel.hotelImageCount}" />
                    <c:set var="hotelName" value="${ hotel.hotelName }"/>

                    <div class="gallery-grid">
                        <img alt="main-exterior" src="assets/img/hotel-rooms/${ hotel.hotelName }_외관1.jpg" id="main-image" class="img-fluid photo-thumbnail" data-bs-toggle="modal" data-bs-target="#photoModal">
                        <c:forEach var="mainImg" items="${ hotel.mainImageNames }">
                            <img alt="main-images" src="assets/img/hotel-rooms/${ mainImg }" class="img-fluid photo-thumbnail" data-bs-toggle="modal" data-bs-target="#photoModal">
                        </c:forEach>

                        <div class="modal fade" id="photoModal" tabindex="-1" aria-labelledby="photoModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="photoModalLabel">호텔 사진</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <h6>호텔 외관</h6>
                                        <c:forEach var="i" begin="0" end="${ hotel.hotelImageCount - 1 }">
                                            <img src="assets/img/hotel-rooms/${ hotelName }_외관${ i + 1 }.jpg" class="img-fluid mb-3" alt="호텔 외관">
                                        </c:forEach>

                                        <h6>객실</h6>
                                        <div class="row">
                                            <c:forEach var="room" items="${ hotel.rooms }">
                                                <c:forEach var="i" begin="0" end="${ room.roomImageCount - 1 }">
                                                    <img
                                                            src="assets/img/hotel-rooms/${ hotel.hotelName }_${ room.roomName }${ i + 1 }.jpg"
                                                            class="img-fluid" alt="객실${ i + 1 }">
                                                </c:forEach>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <c:forEach var="room" items="${ hotel.rooms }">
                    <div class="section-hotel-details" id="select-rooms">
                        <h4>${ room.roomName }</h4>
                        <div class="d-flex flex-row">
                            <div class="d-flex flex-column">
                                <div class="room-meta-item">
                                    <img src="assets/img/hotel-rooms/${ hotel.hotelName }_${ room.roomName }1.jpg" class="room-img" alt="room-img">
                                </div>
                                <c:forEach var="amenity" items="${ room.roomAmenity }">
                                    <div> ${ amenity } </div>
                                </c:forEach>
                            </div>
                            <div class="mx-4 flex-grow-1">
                                <div class="row bg-light fw-bold text-center py-2 border">
                                    <div class="col-6">객실 옵션 상세</div>
                                    <div class="col-2">정원</div>
                                    <div class="col-4">오늘의 요금</div>
                                </div>

                                <div class="row align-items-center p-3 m-50">
                                    <!-- 객실 옵션 -->
                                    <div class="col-6">
                                        <p>🍽 높은 퀄리티의 조식 (선택)</p>
                                        <p>🔄 부분 환불 가능</p>
                                        <p>⚡ 대기 없이 바로확정!</p>
                                        <p>💳 온라인 사전 결제</p>
                                    </div>

                                    <!-- 정원 -->
                                    <div class="col-2 text-center">
                                        <c:forEach var="i" begin="1" end="${ room.capacity }">
                                            👤
                                        </c:forEach>
                                    </div>

                                    <!-- 가격 및 예약 -->
                                    <div class="col-4 text-end">
                                        <form action="Reservation" method="post">
                                            <p class="fw-bold">총금액: ${ room.formattedPrice }원</p>
                                            <input type="hidden" name="hotelNum" value="${ hotel.hotelNum }">
                                            <input type="hidden" name="roomNum" value="${ room.roomNum }">
                                            <input type="hidden" name="checkIn" value="${ checkIn }">
                                            <input type="hidden" name="checkOut" value="${ checkOut }">
                                            <button type="submit" class="btn btn-primary">예약</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <div class="section-hotel-details">
                    <div>
                        <h4>투숙객 리뷰</h4>
                    </div>
                    <div class="d-flex flex-row">
                        <c:forEach var="review" items="${reviews}" varStatus="status">
                            <c:if test="${status.index < 3}">
                                <!-- 리뷰 출력 -->
                                <p>${review.content}</p>
                            </c:if>
                        </c:forEach>

                        <c:forEach var="review" items="${ roomReviews }" varStatus="status">
                            <c:if test="${ status.index < 3 }">
                                <div class="section-hotel-review p-3 mx-2 mt-3" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                                    <div class="d-flex flex-row">
                                        <div class="profile-img">
                                            <img src="assets/img/sample/default-profile-picture.jpg" alt="프로필 이미지" width="32" height="32">
                                        </div>
                                        <div data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                                            <div class="uesr-name mx-1">
                                                ${ review.memberName }
                                            </div>
                                            <div class="review-time mx-1">
                                                ${ review.reviewDate }
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        ${ review.reviewText }
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="text-center">
                        <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">더 보기</button>
                    </div>
                    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
                        <div class="offcanvas-header">
                            <h5 class="offcanvas-title" id="offcanvasRightLabel">투숙객 리뷰</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                            <c:forEach var="review" items="${ roomReviews }">
                                <div class="section-hotel-review p-3 mx-2">
                                    <div class="d-flex flex-row">
                                        <div class="profile-img">
                                            <img src="assets/img/sample/default-profile-picture.jpg" alt="프로필 이미지" width="32" height="32">
                                        </div>
                                        <div>
                                            <div class="uesr-name mx-1">
                                                ${ review.memberName }
                                            </div>
                                            <div class="review-time mx-1">
                                                ${ review.reviewDate }
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        ${ review.reviewText }
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="section-hotel-details">
                    <div>
                        <h4>위치</h4>
                    </div>
                    <!-- START MAP -->
                    <div class="tour-map">
                        <iframe
                                height="300"
                                id="gmap_canvas"
                                src="https://www.google.com/maps/embed/v1/place?key==${ hotel.hotelName }">
                        </iframe>
                    </div>
                    <!-- END MAP -->
                </div>
                <div class="section-hotel-details">
                    <div>
                        <h4>숙소 규정</h4>
                    </div>
                </div>
                <div class="section-hotel-details">
                    <div>
                        <h4>다른 추천 호텔</h4>
                    </div>
                </div>
            </div><!-- End Col-->
        </div>
    </div>
</section>
<!-- End hotel info -->

<!-- Start footer -->
<jsp:include page="common/footer.jsp"></jsp:include>
<!-- End footer -->

<!-- Start progress-wrap -->
<div class="progress-wrap">
    <svg class="progress-circle svg-content" width="100%" height="100%" viewBox="-1 -1 102 102">
        <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98"/>
    </svg>
</div>
<!-- End progress-wrap -->

<!-- JS Script -->
<jsp:include page="commonJs.jsp"></jsp:include>
</body>
</html>