<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-lg-8 col-12 wow fadeIn"
	style="min-height: calc(100vh - 100px);">

	<c:set var="member" value="${member}" />
	<div class="single_tour_details">
		<div class="user-container">
			<div class="title">회원 정보</div>
			<div class="profile-section">
				<div class="profile-photo">프로필 사진</div>
				<div class="readonly-info">
					<div>
						<strong>이름:</strong>${member.getMemberName()}</div>
					<div>
						<strong>생년월일:</strong>${member.getBirth()}</div>
					<div>
						<strong>이메일:</strong> ${member.getEmail()}
					</div>
				</div>
			</div>
			<div class="info-box">
				<form action="ModifyProfile" method="post">
					 <table>
						 <tr>
						 	<td>
						 	<label>전화번호</label>
					 		<input type="text" name="phone" value="${member.getPhone()}"> 
						 	</td>
						 	<td>
						 	<label>국가</label>
						 	<input type="text" name="address1" value="${member.getAddress1()}">
						 	</td>
						 	<td>
						 	<label>지역</label>
						 	<input type="text" name= "address2" value="${member.getAddress2()}">
						 	</td>
						 </tr>
					 </table>
					 <br>
					 <input type="submit" value="수정">
				</form>


			</div>
		</div>
	</div>
</div>