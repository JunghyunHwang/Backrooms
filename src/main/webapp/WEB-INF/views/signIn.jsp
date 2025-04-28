<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Backroom - login</title>
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
								<a href="Main">
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
		
		<!-- login start -->
		<div class="d-flex justify-content-center align-items-center vh-100">
  			<div class="shadow-lg p-5 bg-body-tertiary rounded" style="padding: 40px; width: 800px; height: 500px;">
  				<form id="loginForm" method="post" action = "SignIn">
					<label for="formGroupExampleInput" class="form-label">ID</label>
					<input type="text" class="form-control mb-3" id="userId" placeholder="아이디를 입력해주세요" name = "memberId">

					<label for="formGroupExampleInput2" class="form-label">Password</label>
					<input type="password" class="form-control mb-5" id="passWard" placeholder="비밀번호를 입력해주세요"  name="passwd">

					<!-- 로그인 버튼 -->
					<div class="d-grid gap-2 mb-5">
					<!--  -->
						<input type="submit" class="btn btn-primary w-100" value="Sign in">
					</div>
				</form>
				<!-- 아이디 찾기, 패스워드 찾기, 회원가입 -->
				<ul class="list-unstyled d-flex justify-content-between text-center">
					<li><a href="FindAccount">아이디&패스워드 찾기</a></li>
					<li><a href="SignUp">회원가입</a></li>
				</ul>
			</div>
		</div>
		<!-- login end -->
		
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
    </body>
</html>