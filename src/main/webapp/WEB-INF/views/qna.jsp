<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Backroom - qnaForm</title>
    <jsp:include page="commonCss.jsp"></jsp:include>
  </head>

  <body>
   <c:if test="${not empty errorMessage}">
    <script>
      alert("${errorMessage}");
    </script>
  </c:if>
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
            <div
              class="offcanvas__top d-flex justify-content-between align-items-center"
            >
              <div class="offcanvas__logo">
                <a href="index.html">
                  <img src="assets/img/logo.svg" alt="edutec" />
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

    <div class="d-flex flex-column min-vh-100">
      <!-- Start Header -->
      <jsp:include page="common/header.jsp"></jsp:include>
      <!-- End Header -->

      <!-- Start main -->
      <main
        class="container-lg my-5 flex-grow-1 d-flex align-items-center justify-content-center fs-5"
      >
        <section class="w-100" style="margin-bottom: 5em">
          <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
              <article class="card shadow-lg border-dark">
                <header class="card-header bg-white text-center">
                  <h3 class="text-secondary fw-bold">문의 작성</h3>
                </header>
                <div class="card-body">
                  <form action="qna" method="POST">
                    <!-- Inquiry category -->
                    <div class="mb-3">
                      <label for="inquiryCategory" class="form-label"
                        >문의 종류</label
                      >
                      <select
                        id="qnaTitle"
                        name="qnaTitle"
                        class="form-select form-select-lg border-dark shadow-sm"
                      >
                        <option value="" disabled selected>
                          문의 종류 선택
                        </option>
                        <option value="예약문의">예약 문의</option>
                        <option value="객실문의">객실 문의</option>
                        <option value="서비스문의">서비스 문의</option>
                        <option value="결제문의">결제 문의</option>
                        <option value="취소환불문의">취소 및 환불 문의</option>
                        <option value="기타">기타</option>
                      </select>
                    </div>
					<!-- <div class="mb-3">
                      <label for="message" class="form-label">제목</label>
                      <input
                        id="title"
                        name="title"
                        class="form-control form-control-lg border-dark shadow-sm"
                        placeholder="제목을 입력해주세요"
                        required
                      ></input>
                    </div> -->
                    <!-- Message Input -->
                    <div class="mb-3">
                      <label for="message" class="form-label">내용</label>
                      <textarea
                        id="qnaText"
                        name="qnaText"
                        class="form-control form-control-lg border-dark shadow-sm"
                        rows="6"
                        placeholder="내용을 입력해주세요"
                        required
                      ></textarea>
                    </div>

                    <!-- Register Button -->
                    <div class="d-grid">
                      <button
                        type="submit"
                        class="btn btn-dark btn-lg fw-bold shadow"
                      >
                        등록하기
                      </button>
                    </div>
                  </form>
                </div>
                <footer class="card-footer text-center text-muted small">
                  <p>
                    문의를 작성하시면 관리자에게 전달됩니다.<br />
                    문의하신 내용에 대한 답변은 <u>마이페이지 > 내문의</u>에서
                    확인하실 수 있습니다.
                  </p>
                </footer>
              </article>
            </div>
          </div>
        </section>
      </main>
      <!-- End main -->

      <!-- Start footer -->
     <jsp:include page="common/footer.jsp"></jsp:include>
      <!-- End footer -->
    </div>

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

    <!-- JS Scripts -->
   <jsp:include page="commonJs.jsp"></jsp:include>
  </body>
</html>
