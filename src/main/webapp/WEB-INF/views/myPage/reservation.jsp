<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="ko_KR"/>
<fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd" var="todayStr"/>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<div class="col-lg-8 col-12 wow fadeIn" style="min-height: calc(100vh - 100px);">
    <h3 class="mb-4">📅 나의 예약 내역</h3>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:choose>
    <c:when test="${empty reservationList}">
        <p>예약 내역이 없습니다.</p>
    </c:when>
    <c:otherwise>
        <c:forEach var="res" items="${reservationList}">
            <div class="card shadow-sm p-4 mb-4">
                <div class="card-body">
                    <h5 class="card-title">${res.roomName}</h5>
                    <p class="card-text"><strong>체크인:</strong> ${res.checkIn}</p>
                    <p class="card-text"><strong>체크아웃:</strong> ${res.checkOut}</p>
                    <p class="card-text"><strong>조식:</strong>
                        <c:out value="${res.reservationBreakfast == 1 ? '포함' : '미포함'}" />
                    </p>
                    <p class="card-text"><strong>상태:</strong>
                        <c:out value="${res.reservationState == 1 ? '✅ 결제 완료' : '❌ 결제 미완료'}" />
                    </p>

                    <div class="d-flex justify-content-end gap-2 mt-3">
                        <button class="btn btn-outline-danger btn-sm cancel-btn"
                                data-id="${res.reservationNum}">예약 취소</button>

                        <!-- 체크아웃 날짜가 오늘 이전이면 리뷰 버튼 표시 -->
                        <c:if test="${res.reservationState == 1 && res.checkOut lt todayStr}">
                            <button class="btn btn-outline-primary btn-sm"
                                    onclick="window.open('writeReview.jsp?roomNum=${res.roomNum}&reservationNum=${res.reservationNum}',
                                                 '리뷰 작성', 'width=600,height=600')">
                                리뷰 작성
                            </button>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>

</div>


<script>
$(document).on("click", ".cancel-btn", function () {
    const reservationNum = $(this).data("id");

    if (!confirm("정말 이 예약을 취소하시겠습니까?")) return;

    fetch("/backrooms/CancelReservation", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ reservationNum: reservationNum })
    })
    .then(res => {
        if (res.ok) {
            alert("예약이 취소되었습니다.");
            location.reload();
        } else {
            alert("예약 취소에 실패했습니다.");
        }
    });
});

$(document).on("click", ".write-review", function () {
    const roomNum = $(this).data("room");
    const hotelNum = $(this).data("hotel");
    const url = `writeReview.jsp?roomNum=${roomNum}&hotelNum=${hotelNum}`;
    window.open(url, "리뷰 작성", "width=600,height=600");
});


function openReviewWrite(reservationNum, roomNum) {
	  window.open('writeReview.jsp?reservationNum=' + reservationNum + '&roomNum=' + roomNum,
	              '리뷰 작성', 'width=600,height=600');
	}
</script>
