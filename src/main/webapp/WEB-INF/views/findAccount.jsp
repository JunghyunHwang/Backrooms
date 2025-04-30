<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>backrooms-findAccount</title>
       	<jsp:include page="commonCss.jsp"></jsp:include>
		
	</head>
	
	<body>
	
    <!-- Start Header -->
    <jsp:include page="common/header.jsp"></jsp:include>
    <!-- End Header -->
		
	<!-- content -->
		<section id="content">
				<h5>> ID/PW 찾기</h5>
				<hr>
			<div id="item-box-id">
				<h4>>ID 찾기</h4>
				<hr>
				<div id="id">
					&emsp;&emsp;&emsp;이름&emsp;&emsp;<input type="text" name="memberName"><br>
					<br>
					핸드폰 번호&emsp;&emsp;<input type="text" name="phone"><br>
				</div>
				<button id="btn_id_search" style="float:right;" > ID 찾기</button>
				<input type="hidden" id="find_id_parent">
				
				
					
			</div> 
				
			<div id="item-box-id">
				<h4>>PW 찾기</h4>
				<hr>
				<div id="pw">
					&emsp;&emsp;아이디&emsp;&emsp;<input type="text" name="memberId"><br>
					<br>
					&emsp;&emsp;&emsp;이름&emsp;&emsp;<input type="text" name="memberName"><br>
					<br>
					핸드폰 번호&emsp;&emsp;<input type="text" name="phone"><br>
				</div>
				<button id="btn_pw_search" style="float:right;" > PW 찾기</button>
					
					
						
				</div> 
		</section>
	<!-- content end -->
		
	
		<!-- Start Features -->
    <!-- Start footer -->
   	<jsp:include page="common/footer.jsp"></jsp:include>
    <!-- End footer -->
		<!-- End Features -->
		
	<jsp:include page="commonJs.jsp"></jsp:include>
	<script src="assets/js/findAccount.js"></script>
	
	
	</body>
</html>