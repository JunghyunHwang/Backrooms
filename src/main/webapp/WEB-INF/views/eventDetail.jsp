<%@page import="java.util.List"%>
<%@page import="com.backrooms.dto.EventDTO"%>
<%@page import="com.backrooms.dto.EventPageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Backroom - eventDetail</title>
	<jsp:include page="commonCss.jsp"></jsp:include>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
	<script>
	  $(function() {
		    $("#backBtn").click(function() {
		      window.history.back();
		    });
		  });
	</script>
  </head>
  <body>
  <div class="d-flex flex-column min-vh-100">
    <jsp:include page="common/header.jsp"></jsp:include>
    <main class="container my-5 flex-grow-1">
      <h2 class="fw-bold mb-3">공지사항</h2>
      <section id="detailSection" class="bg-white p-4 rounded border shadow-sm d-flex flex-column">
        <div class="table-responsive flex-grow-1" style="overflow-y: auto">
          <div class="mb-3">
            <h2 id="title" class="fs-2 mb-3">${eventDetail.eventTitle}</h2>
            <span class="fs-6 fw-bold me-2">${eventDetail.memberName}</span>
            <span  class="text-muted fs-6">| 🕐 ${eventDetail.eventDate}</span>
          </div>
          <hr class="mb-4"/>

          <c:if test="${not empty eventDetail.imageFileNamesList}">
            <c:set var="contextPath" value="${pageContext.request.contextPath}" />
          <div id="imageContainer" class="mb-4 d-flex flex-wrap gap-3">
            <c:forEach var="image" items="${eventDetail.imageFileNamesList}">
              <c:set var="fileName" value="${image.imageUploadFileName}" />
              <c:set var="ext" value="${fn:substringAfter(fileName, '.')}" />

              <c:if test="${ext == 'jpg' || ext == 'jpeg' || ext == 'png' || ext == 'gif' || ext == 'raw'}">
                <div class="text-center me-3">
                  <img
                          src="${contextPath}/images/board/${image.imageStoreFileName}"
                          alt="${image.imageUploadFileName}"
                          class="img-thumbnail mb-2"
                          style="max-width: 300px;" />
                  <div class="small text-muted">${image.imageUploadFileName}</div>
                </div>
              </c:if>
            </c:forEach>
            </c:if>
          </div>
          <div class="mb-4">
            <p id="text" class="fs-5 lh-lg px-2 py-1" style="min-height: 207px;">${eventDetail.eventText}</p>
          </div>

          <c:if test="${not empty eventDetail.imageFileNamesList}">
          <div id="attachContainer" class="border p-3 mt-3">
            <div class="mb-2">
              <span class="fw-bold">원본 첨부파일</span>
              <span id="attachCount" class="text-danger fw-bold">${fn:length(eventDetail.imageFileNamesList)}</span>
            </div>
            <div id="attachList">
              <c:if test="${not empty eventDetail.imageFileNamesList}">
                <c:set var="contextPath" value="${pageContext.request.contextPath}" />
                <c:forEach var="image" items="${eventDetail.imageFileNamesList}">
                  <a
                          href="${contextPath}/attach/board/${image.imageStoreFileName}"
                          class="text-decoration-none text-dark me-3">
                      ${image.imageUploadFileName}
                  </a>
                </c:forEach>
              </c:if>
            </div>
          </div>
          </c:if>

          <div class="d-flex justify-content-center mt-3">
            <button id="backBtn" class="btn btn-secondary me-3">뒤로가기</button>
          </div>
      </section>
    </main>
    <jsp:include page="common/footer.jsp"></jsp:include>
  </div>

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
  <!-- Include Bootstrap JS and dependencies -->
  <jsp:include page="commonJs.jsp"></jsp:include>
  </body>
</html>