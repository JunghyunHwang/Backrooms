<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Backroom - register</title>
        <jsp:include page="commonCss.jsp"></jsp:include>   
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
		
		<!-- register start -->
		<div class="d-flex justify-content-center align-items-center vh-100 mb-5 mt-5">
  <div class="shadow-lg bg-body-tertiary rounded" style="padding: 40px; width: 800px; height: 100%;">
    <form id="signupForm" method="post" action="SignUp">
      <label for="userId" class="form-label">아이디</label>
      <input type="text" class="form-control mb-3" id="userId" placeholder="아이디를 입력해주세요" required name="memberId">
      
      <label for="password" class="form-label">비밀번호</label>
      <input type="password" class="form-control mb-3" id="password" placeholder="비밀번호" required name="passwd">
      
      <label for="confirmPassword" class="form-label">비밀번호 확인</label>
      <input type="password" class="form-control mb-3" id="confirmPassword" placeholder="비밀번호를 확인" required>
      
      <label for="email" class="form-label">Email</label>
      <input type="email" class="form-control mb-3" id="email" placeholder="이메일 주소" required name="email">
      
      <label for="userName" class="form-label">이름</label>
      <input type="text" class="form-control mb-3" id="userName" placeholder="이름" required name="memberName">
      
      <label for="birthDate" class="form-label">생년월일</label>
      <input type="date" class="form-control mb-3" id="birthDate" required name="birth">
      
     <label for="phoneNumber" class="form-label">핸드폰 번호</label>
      <input type="tel" class="form-control mb-5" id="phoneNumber" placeholder="010-1234-5678" required name="phone">
      
      <div class="form-check mb-5 border">
      <p>이용약관 내용</p>
        <input class="form-check-input" type="checkbox" id="termsCheck" required>
        <label class="form-check-label" for="termsCheck">
          약관에 동의합니다
        </label>
      </div>
      
      <div class="d-grid">
        <button type="submit" class="btn btn-primary">회원가입</button>
      </div>
    </form>
  </div>
</div>

		<!-- register end -->
		
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
		<script>
			// START Recomanded
			var mixproduct = mixitup('.tour_items');			
			// END Recomanded

			jQuery('select').niceSelect();
					
		</script>
<script>
				
/// TODO jQuery 방식으로 바꾸기?
document.getElementById("signupForm").addEventListener("submit", function (event) {
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;

    if (password !== confirmPassword) {
        event.preventDefault();
        alert("비밀번호가 일치하지 않습니다.");
    }
});
</script>

    </body>
</html>