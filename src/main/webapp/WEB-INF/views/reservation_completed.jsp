<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>결제 완료</title>
</head>
<body>
    <div style="text-align: center; padding-top: 100px;">
        <h2>${message}</h2>
        <p>예약번호: <strong>${reservationNum}</strong></p>
        <br>
        <a href="/MyPage?myPage=reservation">내 예약 확인하기</a>
    </div>
</body>
</html>
