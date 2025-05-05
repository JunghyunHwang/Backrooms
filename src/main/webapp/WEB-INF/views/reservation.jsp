<%@page import="java.lang.reflect.Parameter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>예약</title>
		
		<style>
			.midpage {
				display: flex;
				
			}
			
			.midpage-left {
				flex: 3;
            	padding: 20px;
			}
			
			
			.midpage-right {
				flex: 2;
            	padding: 20px;
			}
		</style>
		<script>
		    document.addEventListener("DOMContentLoaded", function () {
		        const allAgreeCheckbox = document.getElementById("flexCheckDefault-1");
		        const checkboxes = [
		            document.getElementById("flexCheckDefault-2"),
		            document.getElementById("flexCheckDefault-3"),
		            document.getElementById("flexCheckDefault-4"),
		            document.getElementById("flexCheckDefault-5"),
		        ];
		
		        allAgreeCheckbox.addEventListener("change", function () {
		            for (var i = 0; i < checkboxes.length; i++) {
		                checkboxes[i].checked = allAgreeCheckbox.checked;
		            }
		        });
		
		        for (var i = 0; i < checkboxes.length; i++) {
		            checkboxes[i].addEventListener("change", function () {
		                var allChecked = true;
		                for (var j = 0; j < checkboxes.length; j++) {
		                    if (!checkboxes[j].checked) {
		                        allChecked = false;
		                        break;
		                    }
		                }
		                allAgreeCheckbox.checked = allChecked;
		            });
		        }
		
		        // '결제' 버튼 클릭 이벤트 리스너 추가
		        document.getElementById("payButton").addEventListener("click", function () {
		            let name = document.getElementById("name").value.trim();
		            let email = document.getElementById("email").value.trim();
		            let phone = document.getElementById("phone").value.trim();
		            let agreeAll = document.getElementById("flexCheckDefault-1").checked; // 전체 동의 체크 여부
		
		            if (name === "" || email === "" || phone === "") {
		                alert("이름, 이메일, 전화번호를 모두 입력해주세요.");
		                return; // 중단
		            }
		
		            if (!agreeAll) {
		                alert("이용약관에 전체 동의해야 합니다.");
		                return; // 중단
		            }
		
		            // 폼 데이터를 임시로 보낼 form
		            const form = document.getElementById("reservationform");

		            // 새 창을 팝업으로 연다 (크기 제한, 툴바/크기 변경 불가)
		            const popup = window.open('', 'paymentPopup',
		                'width=600,height=800,scrollbars=no,resizable=no,toolbar=no,location=no,status=no');

		            // 팝업 타겟으로 설정 후 제출
		            form.target = 'paymentPopup';
		            form.submit();
		        });
		        
		        document.getElementById("payButton").addEventListener("click", function(){
		            document.getElementById("reservationform").submit();
		          });
		        
		    });
		</script>
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
									<img src="<%=request.getContextPath()%>/assets/img/logo.svg" alt="edutec">
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
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- Start Header -->
    <jsp:include page="common/header.jsp"></jsp:include>
    <!-- End Header -->
		
		
		<div class = "midpage">
				<div class = midpage-left>
				
					<div class = midpage-mid>
						<div class ="contact-info">
								<h3>투숙객 정보</h3>
							<section class="contact-area">
							    <div class="container">                    
							            <div class="col-xl-8 col-md-8 col-12 wow fadeInUp">
							                <div class="contact-form">
							                    <form id="contact-form">                                
							                        <div class="row">
							                            <div class="col-12">
							                             	<label for="name">이름</label>
							                                <input type="text" class="form-control" placeholder="Name" name="name" id="name" value="${mdto.memberName}">
							                            </div>
							                            <div class="col-12 mt-3">
							                            	<label for="name">이메일</label>
							                                <input type="email" class="form-control" placeholder="Email" name="email" id="email" value="${mdto.email}">
							                            </div>
							                            <div class="col-12 mt-3">
							                                <label for="name">전화번호</label>
							                                <input type="tel" class="form-control" placeholder="Phone" name="phone" id="phone" value="${mdto.phone}">
							                            </div>
							                            
							                        </div>                                
							                    </form>
							                </div>
							                <br>
							                <h3>서비스 여부</h3>
							                <form id="reservationform" action="PaymentPage" method="POST" >
							                	<input type="hidden" name="hotelNum" value="${parameterMap.hotelNum}" />
											    <input type="hidden" name="roomNum" value="${parameterMap.roomNum}" />
											    <input type="hidden" name="checkIn" value="${parameterMap.checkIn}" />
											    <input type="hidden" name="checkOut" value="${parameterMap.checkOut}" />
							                	<input type="hidden" name="nights" value="${parameterMap.nights}">
												<input type="hidden" name="roomPrice" value="${hrdto.roomPrice}">
								                <input type="checkbox" id="reservationbreakfast" name="reservationbreakfast" value="option1">
								                <label for="breakfast-checkbox">조식</label>
							                </form>
							            </div>
							    </div>
							</section>
						</div>
	
					</div>
				
				<div class ="contact-info">
					<h3>이용약관</h3>
					<div class="form-check">
						<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault-1">
						<label class="form-check-label" for="flexCheckDefault">
						전체 동의
						</label>
					</div>					
					<br>
						<div class = midpage-mid>
							<div class="form-check">
							  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault-2">
							  <label class="form-check-label" for="flexCheckDefault">
							    18세 이상 및 이용약관동의 (필수)
							  </label>
							</div>	
							
							<div class="form-check">
							  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault-3">
							  <label class="form-check-label" for="flexCheckDefault">
							    개인정보 제3자 제공동의 (필수)
							  </label>
							</div>	
							
							<div class="form-check">
							  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault-4">
							  <label class="form-check-label" for="flexCheckDefault">
							    개인정보 수집 및 이용동의 (필수)
							  </label>
							</div>	
							
							<div class="form-check">
							  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault-5">
							  <label class="form-check-label" for="flexCheckDefault">
							    개인정보 해외 이전동의 (필수)
							  </label>
							</div>	
						</div>
						
					<br>
				</div>
				
				<div class="d-grid gap-2">
					 <button class="btn-payment" type="button" id="payButton">결제</button>
				</div>
			</div>

			</div>
			
			<div class = midpage-right>
				<div class ="contact-info">
					<div class = midpage-mid>
						<image src="assets/img/sample/hotel-main.jpg">
						<h3>${hdto.hotelName}</h3>
						<h6>객실 이름:${hrdto.roomName}</h6>
						<h6>평점: ${hdto.hotelRating} </h6>
					</div>
					
				</div>
				<div class ="contact-info">
					<div class = midpage-mid>
						<h3>숙박 일정</h3>
						<br>
						<h6>체크인</h6>
						${parameterMap.checkInDisp}<br>
						<h6>체크아웃</h6>
						${parameterMap.checkOutDisp}<br>
						<br>
					</div>
					
					<div class = midpage-mid>
						<h3>요금 정보</h3>
						객실 1개 * ${parameterMap.nights}박 가격: ${totalPrice}원<br>
						<hr>
						총합: ${totalPrice}원
					</div>
				</div>
				
				<div class ="contact-info">
					<div class = midpage-mid>
						<h3>취소 정책</h3>
						환불 불가
						본 예약은 변경이 불가능한 상품으로, 취소 시 요금이 환불되지 않습니다. 호텔에 체크인하지 않으실 경우, 취소 수수료와 동일한 금액의 위약금이 청구됩니다.
					</div>
				</div>
			</div>
			
			
		</div>
		
	<!-- Start footer -->
     <jsp:include page="common/footer.jsp"></jsp:include>
    <!-- End footer -->
		
		<!-- JS Script -->
        <jsp:include page="commonJs.jsp"></jsp:include>
	</body>
</html>