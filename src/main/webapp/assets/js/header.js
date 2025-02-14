const HEADER = `
<!-- Start Header -->
    <header id="tr_header">
      <div class="container">
        <div class="row">
          <div class="col-xl-2 col-md-3 align-self-center">
            <div class="site_logo">
              <a href="index.html"
                ><img src="assets/img/Backrooms.svg" alt="Trvelo"
              /></a>
            </div>
          </div>
          <!-- End Col -->

          <div class="col-xl-10 col-md-9">
            <div class="header_right d-flex justify-content-end">
              <nav class="main-menu align-self-center">
                <ul>
                  <li><a href="index.html">Home</a></li>
                  <li>
                    <a href="#"
                      >게시판 <i class="fa-solid fa-chevron-down"></i
                    ></a>
                    <ul class="sub-menu">
                      <li><a href="notice.html">공지사항</a></li>
                      <li><a href="event.html">이벤트 게시판</a></li>
                    </ul>
                  </li>
                  <li><a href="inquiryForm.html">문의하기</a></li>
                </ul>
              </nav>

              <a href="login.html" class="green_btn align-self-center" id="guest" style="display:block;">Login / Register <i class="ph ph-arrow-right"></i></a>
              
              <div class="profile_btn" id="user" style="display: none;">
			    <div class="green_btn align-self-center"> 
			        회원정보 <i class="ph ph-arrow-down align-right"></i> 
			    </div>
			    <ul class="sub-menu">
			        <li><a href="UserProfile.html">회원 정보</a></li>
					<li><a href="reservationInfoBox.html">예약 관리</a></li>
					<li><a href="MyQnA.html">내 문의</a></li>
					<li><a href="Myreview.html">내 리뷰</a></li>
			    </ul> 
			</div>
              
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
`;

const headerElement = document.querySelector("#tr_header");
headerElement.innerHTML = HEADER;
