<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="com.backrooms.dto.MemberDTO"%>
<%@page import="com.backrooms.dto.ReviewDTO"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<script type="text/javascript">
$(document).ready(function() {
	$(".delBtn").click(function() {
		var num = $(this).attr("data-xxx");
		console.log(num);
		location.href = "DelReview?num=" + num;
	});
});
var currentPage = 1;
var reviewsPerPage = 5;
var reviews = []; // 리뷰 데이터를 저장할 배열

var now = new Date();
var dateStr = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
// 페이지네이션 기능
function prevPage() {
  if (currentPage > 1) {
    currentPage--;
    renderReviews();
  }
}

function nextPage() {
  if (currentPage < Math.ceil(reviews.length / reviewsPerPage)) {
    currentPage++;
    renderReviews();
  }
}

// 자식 창 열기
function openReviewWrite() {
  window.open('writeReview.jsp', '리뷰 작성', 'width=600,height=600');
}
</script>
<div class="col-lg-8 col-12 wow fadeIn">
					<div class="reviewbody">
						<div class="tdetails_meta">
							<div class="reviewcontainer">
								<h1>내 리뷰</h1>

								<!-- 리뷰 리스트 -->
								<table class="review-list">
									<thead>
										<tr>
											<th>제목</th>
											<th>별점</th>
											<th>내용</th>
											<th>날짜</th>
											<th>이미지</th>
											<th>삭제버튼</th>
										</tr>
									</thead>
									<tbody id="reviewList">
<%
	List<ReviewDTO> rlist = (List<ReviewDTO>) request.getAttribute("myReview");
	/* MemberDTO mdto = (MemberDTO)session.getAttribute("member");
	String author = mdto.getMemberName(); */
	//System.out.print(rlist);
	if(rlist==null){
%>
						<tr>
							<td colspan="6">목록이 없습니다.</td>
						</tr>
<%		
	}else{
		for(int i = 0; i < rlist.size(); i++){
	/* HttpSession session1 = request.getSession(); */
	/* MemberDTO mdto = (MemberDTO)session1.getAttribute("member"); */
	/* String author = mdto.getMemberId(); */
	ReviewDTO rdto = rlist.get(i);
	int reviewNum = rdto.getReviewNum();
	String reviewTitle = rdto.getReviewTitle();
	int rating = rdto.getStarRating();
	String content = rdto.getReviewText();
	String date = rdto.getReviewDate();
	String image = "image";
	request.setAttribute("reviewNum", reviewNum);
%>

									<tr>
											<th><%=reviewTitle %></th>
											<th><%=rating %></th>
											<th><%=content %></th>
											<th><%=date %></th>
											<th><%=image %></th>
											<th><button class="delBtn" data-xxx="<%=reviewNum%>">삭제</button></th>
										</tr>
										<%}} %>
									</tbody>
								</table>

								<!-- 페이지네이션 -->
								<div class="reviewpagination"
									style="display: flex; justify-content: center; margin-top: 20px;">
									<button onclick="prevPage()"><</button>
									<span id="currentPage">1</span>
									<button onclick="nextPage()">></button>
								</div>

								<!-- 리뷰 작성 버튼 -->

								

							</div>