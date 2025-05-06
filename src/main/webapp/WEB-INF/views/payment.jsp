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

    <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script>
  window.onload = function () {
    const IMP = window.IMP;
    IMP.init("imp20026124"); // 본인 테스트 가맹점 코드

    // PG 매핑 객체
    const pgMap = {
      html5_inicis: "html5_inicis.INIpayTest"
    };

    // 결제 요청 함수
    window.requestPay = function () {
      const selectedMethod = document.querySelector("input[name='payMethod']:checked");

      if (!selectedMethod) {
        alert("결제 수단을 선택해주세요.");
        return;
      }

      const pgCode = pgMap[selectedMethod.value];
      if (!pgCode) {
        alert("유효하지 않은 결제 수단입니다.");
        return;
      }

      IMP.request_pay({
        pg: pgCode,
        pay_method: "card", // 포트원이 자동 해석함
        merchant_uid: "mid_" + new Date().getTime(),
        name: "호텔 결제",
        amount: 1000, // 테스트 고정 금액
        buyer_email: "${member.email}",
        buyer_name: "${member.memberName}",
        buyer_tel: "${member.phone}",
        popup: true 
      }, function (rsp) {
        if (rsp.success) {
          fetch("${pageContext.request.contextPath}/paymentComplete", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
              reservationNum: "${reservationNum}",
              payMethod: selectedMethod.value,
              payment: rsp.paid_amount
            })
          }).then(res => {
            if (res.ok) {
              alert("결제가 완료되었습니다.");
              window.opener.location.href = "/backrooms";
              window.close();
            } else {
              alert("서버에 결제 정보 저장 실패");
            }
          });
        } else {
          alert("결제에 실패했습니다: " + rsp.error_msg);
        }
      });
    };
  };
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
	<p>예약 번호: ${reservationNum}</p>
    <form id="paymentForm" action="${pageContext.request.contextPath}/paymentComplete" method="post">
        <input type="hidden" name="reservationNum" value="${reservationNum}" />
        <input type="hidden" name="memberNum" value="${member.memberNum}" />
        <input type="hidden" name="payment" value="${payment}" />

<label><input type="radio" name="payMethod" value="html5_inicis"> 카드결제</label><br>
        <br>
        <button type="button" onclick="requestPay()">결제하기</button>
    </form>
</div>

</body>
</html>
