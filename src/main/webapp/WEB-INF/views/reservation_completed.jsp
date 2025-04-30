<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>결제 완료</title>
    <style>
        .summary-box {
            width: 600px;
            margin: 50px auto;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 12px;
            background-color: #f8f8f8;
        }
        .summary-box h2 {
            text-align: center;
            margin-bottom: 30px;
        }
        .summary-box p {
            margin: 10px 0;
        }
    </style>
</head>
<body>
<div class="summary-box">
    <h2>예약이 완료되었습니다</h2>

    <p><strong>예약자명:</strong> ${member.memberName}</p>
    <p><strong>호텔명:</strong> ${hdto.hotelName}</p>
    <p><strong>객실명:</strong> ${hrdto.roomName}</p>
    <p><strong>체크인:</strong> ${reservation.checkIn}</p>
    <p><strong>체크아웃:</strong> ${reservation.checkOut}</p>
    <p><strong>숙박일수:</strong> ${nights}박</p>
    <p><strong>조식 포함 여부:</strong> <c:choose>
        <c:when test="${reservation.reservationBreakfast == 1}">예</c:when>
        <c:otherwise>아니오</c:otherwise>
    </c:choose></p>
    <p><strong>총 결제금액:</strong> ${totalPrice}원</p>

    <br><hr><br>

    <div style="text-align:center;">
        <a href="/MyPage?myPage=reservation">[마이페이지로 이동]</a>
    </div>
</div>
</body>
</html>
