const HEADER = `
    <!-- Start Header -->
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

              <a href="login.html" class="green_btn align-self-center"
                >Login / Register <i class="ph ph-arrow-right"></i
              ></a>
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
    <!-- End Header -->

`;

const headerElement = document.querySelector("#tr_header");
headerElement.innerHTML = HEADER;
