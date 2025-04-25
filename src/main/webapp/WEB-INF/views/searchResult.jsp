<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.backrooms.dto.SearchArrDTO" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    	<title>backrooms-searchResult</title>
    	<jsp:include page="commonCss.jsp"></jsp:include>  
    	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    	<script type="text/javascript">
    		$(function(){
    			$(".btn_idpw_search").click(function(){
    				$("#detallsForm").submit();
    			})
    			
	  			$("#searchBth").click(function(){
	  				$("#searchForm").submit()
	  			})//end #searchBth click

    		})// function end

    	</script>
	</head>
	<body>
		<!-- Start Preloader -->
	    <div class="preloader_wrap">
	      <div class="preloader">
	        <span style="--i: 1"></span>
	        <span style="--i: 2"></span>
	        <span style="--i: 3"></span>
	        <span style="--i: 4"></span>
	        <span style="--i: 5"></span>
	        <span style="--i: 6"></span>
	        <span style="--i: 7"></span>
	        <span style="--i: 8"></span>
	        <span style="--i: 9"></span>
	        <span style="--i: 10"></span>
	        <span style="--i: 11"></span>
	        <span style="--i: 12"></span>
	        <span style="--i: 13"></span>
	        <span style="--i: 14"></span>
	        <span style="--i: 15"></span>
	        <span style="--i: 16"></span>
	        <span style="--i: 17"></span>
	        <span style="--i: 18"></span>
	        <span style="--i: 19"></span>
	        <span style="--i: 20"></span>
	        <h2>Backrooms</h2>
	        <div class="preloader_icon fa-solid fa-jet-fighter"></div>
	      </div>
	    </div>
	    <!-- End Preloader -->
		<!-- Offcanvas Area Start -->
	    <div class="fix-area">
	      <div class="offcanvas__info">
	        <div class="offcanvas__wrapper">
	          <div class="offcanvas__content">
	            <div
	              class="offcanvas__top d-flex justify-content-between align-items-center"
	            >
	              <div class="offcanvas__logo">
	                <a href="index.html">
 	                  <img src="<%=request.getContextPath()%>/assets/img/logo.svg" alt="edutec" /> 
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
	    <!-- Start Left Bar -->
	     <!-- Start Left Bar -->
	    <section class="tour_details section-padding">
	    	<div class="container" id="search-container">
		        <div class="col-xl-10 col-lg-12 col-md-10 col-10 mx-auto text-center">
		          <div class="tr_search_filter">
		            <form
		              action="SearchResult"
		              class="d-flex justify-content-center"
		              method="post"
		              id="searchForm"
		            >
		              <div class="tr_search_location">
		                <label for="trs_location">Location*</label>
		                <select id="trs_location" name="hotelCity">
		                  <option>서울</option>
		                  <option>부산</option>
		                  <option>인천</option>
		                  <option>강원</option>
		                  <option>제주</option>
		                  <option>전주</option>
		                </select>
		              </div>
		
		              <div class="check_in">
		                <label for="checkin_field">Check - In*</label>
		                <div class="trdate_picker date" id="tr_dpicker1">
		                  <input
		                    type="text"
		                    class="form-control"
		                    placeholder="Check In Date"
		                    id="checkin_field"
		                    name="checkIn"
		                  />
		                  <span class="input-group-append">
		                    <i class="fa-solid fa-calendar-days"></i>
		                  </span>
		                </div>
		              </div>
		
		              <div class="check_out">
		                <label for="checkout_field">Check - Out*</label>
		                <div class="trdate_picker date" id="tr_dpicker2">
		                  <input
		                    type="text"
		                    class="form-control"
		                    placeholder="Check Out Date"
		                    id="checkout_field"
		                    name="checkOut"
		                  />
		                  <span class="input-group-append">
		                    <i class="fa-solid fa-calendar-days"></i>
		                  </span>
		                </div>
		              </div>
		
		              <div class="adut_box">
		                <label>Adult*</label>
		                <select name="guestCount" id="adult">
		                  <option>1</option>
		                  <option>2</option>
		                  <option>3</option>
		                  <option>4</option>
		                  <option>5</option>
		                  <option>6</option>
		                  <option>7</option>
		                  <option>8</option>
		                  <option>9</option>
		                  <option>10</option>
		                </select>
		              </div>
		
		              <button type="button" id="searchBth">
		                Search <i class="ph ph-magnifying-glass"></i>
		              </button>
		            </form>
		          </div>
		        </div>
		      </div>
		      
	      	<div class="container">
			  <div class="row_search">
			    <!-- 왼쪽 필터 -->

			     <div class="col-lg-3" id="tour_widget_serach">
					<br>
			        <!-- 호텔 성급 필터 -->
			        <form action="Condition" id="conForm" method="post">
			        	<input type="hidden" name = "hotelCity" value="${condition.getHotelCity()}">
		              	<input type="hidden" name = "guestCount" value="${condition.getGuestCount()}">
		              	<input type="hidden" name = "checkIn" value="${condition.getCheckIn()}">
		              	<input type="hidden" name = "checkOut" value="${condition.getCheckOut()}">
		               <div class="hotal-star">
		                 <div class="hotal-star-text">
		                   <span id="hotal-text"><h6>호텔성급</h6></span>
		                 </div>
		                
		                 <div class="hotal-star-button">
		                 	<button type="subimt" id="StarBtn" name="StarNum" value=2>2</button>
		                   <button type="subimt" id="StarBtn" name="StarNum" value=3>3</button>
		                   <button type="subimt" id="StarBtn" name="StarNum" value=4>4</button>
		                   <button type="subimt" id="StarBtn" name="StarNum" value=5>5</button>
		                 </div>
		               </div>
		             </form>
				    <!-- 투숙객 평점 -->
		              <form action="Rating" id="RatingForm" method="post">
		              	<input type="hidden" name = "hotelCity" value="${condition.getHotelCity()}">
		              	<input type="hidden" name = "guestCount" value="${condition.getGuestCount()}">
		              	<input type="hidden" name = "checkIn" value="${condition.getCheckIn()}">
		              	<input type="hidden" name = "checkOut" value="${condition.getCheckOut()}">
			              <div class="hotal-star">
			                <div class="visitor-grade">
			                  <hr />
			                  <span id="visitor-grade-text"><h6>투숙객 평점</h6></span>
			                </div>
			                <div class="visitor-grade-button">
			                	<button type="subimt" id="Rating" name="RatingNum" value=3>3</button>
			                	<button type="subimt" id="Rating" name="RatingNum" value=3.5>3.5</button>
			                	<button type="subimt" id="Rating" name="RatingNum" value=4>4</button>
			                	<button type="subimt" id="Rating" name="RatingNum" value=4.5>4.5</button>
			                	<button type="subimt" id="Rating" name="RatingNum" value=5>5</button>
	
			                </div>
			              </div>
		              </form>
		            </div>
		          </div>
		          <!--- END COL -->

			    <!-- 오른쪽 검색 결과 -->
			    
			    <div class="col-lg-9">
			    
			    <c:forEach var="item" items="${hotelList}" >
			    <form action="HotelDetail" id ="detallsForm" method="post"><!-- 이부분 컨트롤러로 변경 필요 -->
			      <div class="single-search-hotal">
		              	<input type="hidden" name = "hotelNum" value="${item.getHotelNum()}">
		              	<input type="hidden" name = "guestCount" value="${condition.getGuestCount()}">
		              	<input type="hidden" name = "checkIn" value="${condition.getCheckIn()}">
		              	<input type="hidden" name = "checkOut" value="${condition.getCheckOut()}">
		                  <div class="single-comment-name">
		                    <a id="hotel-name"> ${item.getName() }</a>
		                    &emsp;호텔 등급 : 
		                   <c:forEach var="i" begin="1" end="${item.getGrade()}" step="1">
		                    <img src="assets/img/icons/Hotel_Star.png" width="20" height="20"/>
		                  </c:forEach>
		                  </div>
		                  <div class="float-start com-rearch-img">
		                    <img src="assets/img/hotel-rooms/${item.getName().trim()}_외관1.jpg" width="200" height="200" />
		                  </div>
		                  <div class="com-content">
		                    	호텔 평점 : ${item.getRating()}
		                  </div>
		                  <div class="com-content-pirce">
		                  	<br>
		                  	<p id="content-pirce-text" style="font:10">< 1박 가격 기준 ></p>	
		                    <p id="content-pirce-text">￦ :${item.getPrice()}</p>
		                    <button style="float: right" class="btn_idpw_search" id="detallBtu">
		                      	예약 하기
		                    </button>
		                  </div>
		                </div>
		                </form>

		              </c:forEach> 
					 </div>
		            </div>
		            <!--- END COL -->
	      <!--- END CONTAINER -->
	    </section>
	    <!-- End Left Bar -->
	   <!-- Start footer -->
	    <footer
	      id="footer"
	      class="my-footer p-3 bg-black text-center text-light"
	    ></footer>
	    <!-- End footer -->
	
	    <!-- Start progress-wrap -->
	    <div class="progress-wrap">
	      <svg
	        class="progress-circle svg-content"
	        width="100%"
	        height="100%"
	        viewBox="-1 -1 102 102"
	      >
	        <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98" />
	      </svg>
	    </div>
	    <!-- End progress-wrap -->
	    <jsp:include page="commonJs.jsp"></jsp:include>
	</body>
</html>
