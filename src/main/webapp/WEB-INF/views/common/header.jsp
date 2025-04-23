<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Start Header -->
<header id="tr_header">
  <div class="container">
    <div class="row">
      <div class="col-xl-2 col-md-3 align-self-center">
        <div class="site_logo">
          <a href="<c:url value='/' />">
            <img src="<c:url value='/assets/img/Backrooms.svg' />" alt="Trvelo" />
          </a>
        </div>
      </div>
      <!-- End Col -->
      <div class="col-xl-10 col-md-9">
        <div class="header_right d-flex justify-content-end">
          <nav class="main-menu align-self-center">
            <ul>
              <li><a href="<c:url value='/' />">Home</a></li>
              <li>
                <c:choose>
                  <c:when test="${member != null && member.role == 9}">
                    <a href="<c:url value='/console/board' />">관리자</a>
                  </c:when>
                  <c:otherwise>
                    <a href="#">게시판 <i class="fa-solid fa-chevron-down"></i></a>
                    <ul class="sub-menu">
                      <li><a href="<c:url value='/notice/list' />">공지사항</a></li>
                      <li><a href="<c:url value='/event/list' />">이벤트</a></li>
                    </ul>
                  </c:otherwise>
                </c:choose>
                <c:choose>
                  <c:when test="${member != null}">
                    <li><a href="<c:url value='/qna' />">문의하기</a></li>
                  </c:when>
                </c:choose>
              </li>
            </ul>
          </nav>

          <c:set var="member" value="${member}" />

          <c:choose>
            <c:when test="${member == null}">
              <a href="<c:url value='/SignIn' />" class="green_btn align-self-center" id="guest">
                Login / Register <i class="ph ph-arrow-right"></i>
              </a>
            </c:when>
            <c:otherwise>
              <div class="profile_btn" id="user">
                <div class="green_btn align-self-center">
                  회원정보 <i class="ph ph-arrow-down align-right"></i>
                </div>
                <ul class="sub-menu">
                  <li><a href="<c:url value='/MyPage?myPage=profile' />">회원 정보</a></li>
                  <li><a href="<c:url value='/MyPage?myPage=reservation' />">예약 관리</a></li>
                  <li><a href="<c:url value='/MyPage?myPage=myqna' />">내 문의</a></li>
                  <li><a href="<c:url value='/MyPage?myPage=review' />">내 리뷰</a></li>
                  <li><a href="<c:url value='/SignOut' />">로그아웃</a></li>
                </ul>
              </div>
            </c:otherwise>
          </c:choose>

          <div class="header__hamburger d-xl-none my-auto">
            <div class="sidebar__toggle">
              <i class="ph ph-list"></i>
            </div>
          </div>
        </div>
      </div>
      <!-- End Col -->
    </div>
  </div>
</header>
<!-- End Header -->
