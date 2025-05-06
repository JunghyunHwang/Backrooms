<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PaymentService</title>
</head>
<body>


<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script>
  const IMP = window.IMP;
  IMP.init("imp00000000"); // 테스트용 가맹점 코드

  function requestPay() {
    IMP.request_pay({
      pg: "html5_inicis", // 테스트 결제 PG사
      pay_method: "card",
      merchant_uid: "mid_" + new Date().getTime(),
      name: "호텔 결제",
      amount: ${payment}, // 결제 금액
      buyer_email: "${member.email}",
      buyer_name: "${member.memberName}",
      buyer_tel: "${member.phone}"
    }, function (rsp) {
      if (rsp.success) {
        // 서버에 결제 정보 전송 (fetch or form POST)
        fetch("/backrooms/paymentComplete", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            reservationNum: "${reservationNum}",
            payMethod: rsp.pay_method,
            payment: rsp.paid_amount
          })
        }).then(res => {
          if (res.ok) {
            window.location.href = "/backrooms/reservation_completed";
          } else {
            alert("결제 정보 저장 실패");
          }
        });
      } else {
        alert("결제에 실패했습니다: " + rsp.error_msg);
      }
    });
  }
</script>

<!-- 버튼 -->
<button onclick="requestPay()">결제하기</button>

</body>
</html>
