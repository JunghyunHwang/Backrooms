<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제 페이지</title>
    <style>
        .payment-slide {
            width: 500px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
    </style>
    <script>
        function submitPayment() {
            const form = document.getElementById("paymentForm");
            const method = document.querySelector("input[name='payMethod']:checked");
            if (!method) {
                alert("결제 수단을 선택해주세요.");
                return;
            }
            form.submit();
        }
    </script>
</head>
<body>

<div class="payment-slide">
    <h2>결제 정보 확인</h2>
    <p><strong>예약자:</strong> ${member.memberName}</p>
    <p><strong>호텔명:</strong> ${hdto.hotelName}</p>
    <p><strong>객실명:</strong> ${hrdto.roomName}</p>
    <p><strong>숙박일수:</strong> ${nights}박</p>
    <p><strong>결제 금액:</strong> ${payment} 원</p>

    <form id="paymentForm" action="${pageContext.request.contextPath}/paymentComplete" method="post">
        <input type="hidden" name="reservationNum" value="${reservationNum}" />
        <input type="hidden" name="memberNum" value="${member.memberNum}" />
        <input type="hidden" name="payment" value="${payment}" />

        <label><input type="radio" name="payMethod" value="카드"> 카드</label><br>
        <label><input type="radio" name="payMethod" value="무통장입금"> 무통장입금</label><br>
        <label><input type="radio" name="payMethod" value="간편결제"> 간편결제</label><br>
        <br>
        <button type="button" onclick="submitPayment()">결제하기</button>
    </form>
</div>

</body>
</html>
