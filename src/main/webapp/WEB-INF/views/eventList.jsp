<%@page import="java.util.List"%>
<%@page import="com.backrooms.dto.EventDTO"%>
<%@page import="com.backrooms.dto.EventPageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Backroom - event</title>
	<jsp:include page="commonCss.jsp"></jsp:include>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
	<script>
		$(function() {
			//일반적인 경우: 페이지 하단에있는 페이지 숫자버튼을 클릭해서 이동(이때는 해당 숫자로 getNoticeList(해당페이지 숫자)로 호출해서
			//해당 페이지를 동적으로 채워줌.
			//예외 경우:
			//메뉴에서 공지사항 버튼클릭해서 들어오는 경우: 첫번째 페이지를 보여줌 
			//url치고 들어오는 경우: url 파라미터값 curpage=x에서 숫자 x를 가지고 해당 페이지 데이터를 ajax요청해서 채워줌.
			// 왼쪽값 ?? 오른쪽값: 왼쪽갑이 null이나 undefined이면 오른쪽값 반환하고 null이나 undefined이 아니면 왼쪽값 반환
			const curPage = (window?.location?.search)?.split?.("=")?.[1] ?? 1;
			fetchAndDisplayBoardList(curPage);
			
			function fetchAndDisplayBoardList(curPage) {
				$.ajax({
					type : "get",
					url : "${pageContext.request.contextPath}/event/list/"+curPage,
					dataType : "json", //text, json, html, xml
					success : function(data, status, xhr) {
						loadTable(data);
				        window.history.pushState("","", "${pageContext.request.contextPath}/event/list?curPage="+curPage);
				        $(window).scrollTop(0);
					},
					error : function(xhr, status, error) {
						console.log("error: error");
					}
				})

			}
			
		      function loadTable(data) {
		          const tableBody = document.getElementById("eventTableBody");
		          const eventList = data.eventList;
		          const curPage = data.curPage;
		          const perPage = data.perPage;
		          const totalCount = data.totalCount;
		          const totalPages = Math.ceil(totalCount / perPage);
		          tableBody.innerHTML = ""; // Clear existing rows
		          const start = (curPage - 1) * perPage;
		          const end = start + perPage;
		          
		          eventList.forEach((event, index) => {
		            const row = document.createElement("tr");
		            const postStatus = event.eventState == 9 ? "진행중" : (start + index + 1);
		            row.classList.add("align-middle");
		            row.style.cursor = "pointer";
		            row.onclick = () => {
		            	//상세페이지
		                window.location.href="${pageContext.request.contextPath}/event/detail/"+event.eventNum;
		            };
		            row.innerHTML = 
					  '<th scope="row" class="text-center">' + postStatus + '</th>' +
  					  '<td class="text-center text-muted">' + event.eventDate + '</td>' +
  					  '<td class="text-truncate">' + event.eventTitle + '</td>' +
  					 '<td class="text-center text-muted">' + event.memberName + '</td>';
  					 
		            tableBody.appendChild(row);
		          });
		          updatePagination(totalPages, curPage);
		        }
			
		      function renderFirstPages(limit, curPage, totalPages, category, PAGE_STEP) {
		    	   //첫페이지 부터 limit페이지까지 버튼을 만듭니다
			        for (let i = 1; i <= limit; i++) {
			          let li = document.createElement("li");
			          li.classList.add("page-item");
			          if (i === curPage) li.classList.add("active");

			          let link = document.createElement("a");
			          link.classList.add("page-link");
			          link.style.cursor = "pointer";
			          link.innerText = i;
			          link.onclick = (e) => {
			        	  fetchAndDisplayBoardList(i);
			          };
			          li.appendChild(link);
			          pagination.appendChild(li);
			        }
			    	  //total < 5 : stop to other adding a link(.... , lastpage), return
			    	  // 총페이지수가 5개 미만이면 이후에 ...버튼과 마지막 페이지 버튼은 보여주지 않습니다
			       	if (limit == totalPages ) return;
			       	  // ...버튼
			           li = document.createElement("li");
			          li.classList.add("page-item");
			           link = document.createElement("a");
			          link.classList.add("page-link");
			          link.style.cursor = "pointer";
			          link.innerText = " ... ";
			          link.onclick = (e) => {
			        	  fetchAndDisplayBoardList(curPage + PAGE_STEP);
			          };
			          li.appendChild(link);
			          pagination.appendChild(li);
			      
			       	// 마지막 페이지 버튼 
			           li = document.createElement("li");
			          li.classList.add("page-item");
			           link = document.createElement("a");
			          link.classList.add("page-link");
			          link.style.cursor = "pointer";
			          link.innerText = totalPages
			          link.onclick = (e) => {
			        	  fetchAndDisplayBoardList(totalPages);
			          };
			          li.appendChild(link);
			          pagination.appendChild(li);
		    	  
		      }
		      function renderMiddlePages(curPage, totalPages, category, PAGE_STEP) {
		    	  //첫페이지 버튼 
				 li = document.createElement("li");
		          li.classList.add("page-item");
		           link = document.createElement("a");
		          link.classList.add("page-link");
		          link.style.cursor = "pointer";
		          link.innerText = 1;
		          link.onclick = (e) => {
		        	  fetchAndDisplayBoardList(1);
		          };
		          li.appendChild(link);
		          pagination.appendChild(li);
		       		
		          // ...버튼
		           li = document.createElement("li");
		          li.classList.add("page-item");
		           link = document.createElement("a");
		          link.classList.add("page-link");
		          link.style.cursor = "pointer";
		          link.innerText = " ... ";
		          link.onclick = (e) => {
		        	  fetchAndDisplayBoardList(curPage - PAGE_STEP);
		          };
		          li.appendChild(link);
		          pagination.appendChild(li);
		       		
		       	// 3개 페이지 버튼:  curPage - 1, curPage, curPage + 1
		       	 for (let i = curPage - 1; i <= curPage + 1; i++) {
		          let li = document.createElement("li");
		          li.classList.add("page-item");
		          if (i === curPage) li.classList.add("active");

		          let link = document.createElement("a");
		          link.classList.add("page-link");
		          link.style.cursor = "pointer";
		          link.innerText = i;
		          link.onclick = (e) => {
		        	  fetchAndDisplayBoardList(i);
		          };
		          li.appendChild(link);
		          pagination.appendChild(li);
		        }
		          // ...버튼 
		           li = document.createElement("li");
		          li.classList.add("page-item");
		           link = document.createElement("a");
		          link.classList.add("page-link");
		          link.style.cursor = "pointer";
		          link.innerText = " ... ";
		          link.onclick = (e) => {
		        	  fetchAndDisplayBoardList(curPage + PAGE_STEP);
		          };
		          li.appendChild(link);
		          pagination.appendChild(li);
		          
		          // 마지막 페이지 버튼
		           li = document.createElement("li");
			          li.classList.add("page-item");
			           link = document.createElement("a");
			          link.classList.add("page-link");
			          link.style.cursor = "pointer";
			          link.innerText = totalPages
			          link.onclick = (e) => {
			        	  fetchAndDisplayBoardList(totalPages);
			          };
			          li.appendChild(link);
			          pagination.appendChild(li);
		      }
		      function renderLastPages(curPage, totalPages, category, PAGE_STEP) {
		       		//첫페이지 버튼 
					 li = document.createElement("li");
			          li.classList.add("page-item");
			           link = document.createElement("a");
			          link.classList.add("page-link");
			          link.style.cursor = "pointer";
			          link.innerText = 1;
			          link.onclick = (e) => {
			        	  fetchAndDisplayBoardList(1);
			          };
			          li.appendChild(link);
			          pagination.appendChild(li);
			          
			          //  ...버튼 
			           li = document.createElement("li");
			          li.classList.add("page-item");
			           link = document.createElement("a");
			          link.classList.add("page-link");
			          link.style.cursor = "pointer";
			          link.innerText = " ... ";
			          link.onclick = (e) => {
			        	  fetchAndDisplayBoardList( curPage - PAGE_STEP);
			          };
			          li.appendChild(link);
			          pagination.appendChild(li);

			      // 마지막 5개 페이지 버튼 
			     for (let j = 0 ; j <= 4; j ++) {
			     const i = (totalPages - 4 +j);
			      
		          let li = document.createElement("li");
		          li.classList.add("page-item");
		          if (i === curPage) li.classList.add("active");

		          let link = document.createElement("a");
		          link.classList.add("page-link");
		          link.style.cursor = "pointer";
		          link.innerText = i;
		          link.onclick = (e) => {
		        	  fetchAndDisplayBoardList( i);
		          };
		          li.appendChild(link);
		          pagination.appendChild(li); 
		        }
		      }
		      
		      function updatePagination(totalPages, curPage, category) {
		        let pagination = document.getElementById("pagination");
		        pagination.innerHTML = "";

		        const PAGE_STEP = 3;
		        const FIRST_PAGES_BUTTON_COUNT = 5;
		        //start type view에서 보여질 페이지 버튼 수를 설정합니다
		       	const limit = totalPages >= FIRST_PAGES_BUTTON_COUNT ? FIRST_PAGES_BUTTON_COUNT : totalPages //total page => 5이상이면 
		       			
		      if (curPage < limit) {
		    	  renderFirstPages(limit, curPage, totalPages, category, PAGE_STEP);
		       	} else if (limit <= curPage && curPage < totalPages - PAGE_STEP) {
		       		renderMiddlePages(curPage, totalPages, category, PAGE_STEP);
		       	} else if (curPage >= totalPages - 3) {
		       		renderLastPages(curPage, totalPages, category, PAGE_STEP);
		       	}
		      }		    	  
		})
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

    <div class="d-flex flex-column min-vh-100">
      <!-- Start Header -->
      <jsp:include page="common/header.jsp"></jsp:include>
      <!-- End Header -->
      <!-- Main Content with fixed height so that 7 rows are visible -->
      <!-- 메인 콘텐츠: 고정 높이를 지정하여 7개의 데이터 행이 항상 보이도록 합니다. -->
      <main class="container my-5 flex-grow-1">
        <h2 class="fw-bold mb-3">이벤트</h2>
        <section
          class="bg-white p-4 rounded border shadow-sm d-flex flex-column"
        >
          <!-- Fixed table container with vertical scroll -->
          <!-- 테이블 컨테이너의 높이를 고정하여 스크롤 가능하도록 설정합니다. -->
          <div
            class="table-responsive flex-grow-1"
            style="height: 600px; overflow-y: auto"
          >
            <!-- Use table-layout: fixed for constant column widths -->
            <table
              class="table table-striped table-hover"
              style="table-layout: fixed"
            >
              <thead class="table-dark">
                <tr>
                  <!-- Set explicit column widths using inline styles and Bootstrap text utility classes -->
                  <th scope="col" style="width: 10%" class="text-center">#</th>
                  <th scope="col" style="width: 30%" class="text-center">
                    작성일
                  </th>
                  <th scope="col" style="width: 40%" class="text-start">
                    제목
                  </th>
                  <th scope="col" style="width: 20%" class="text-center">
                    작성자
                  </th>
                </tr>
              </thead>
              <tbody id="eventTableBody">
                <!-- Table rows start -->
				<!-- Table rows end -->
              </tbody>
            </table>
          </div>
          <!-- Pagination area: Centered pagination with a fixed margin at the bottom -->
          <!-- 페이지네이션 영역: 페이지 번호는 중앙에 고정되고, 적당한 마진을 갖습니다. -->
          <nav aria-label="Event Pagination" class="mt-3">
            <ul class="pagination justify-content-center" id="pagination">
              <!-- Pagination start -->
              <!-- Pagination end -->
            </ul>
          </nav>
        </section>
      </main>

      <!--TODO:  footer id footer로 변경 예정: footer 공용틀 id만 남기고 class삭제한 이후에 -->
      <!-- Start footer -->
		<jsp:include page="common/footer.jsp"></jsp:include>
    </div>
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
    <script>
    //
    
    //
    </script>
    <!-- Include Bootstrap JS and dependencies -->
	<jsp:include page="commonJs.jsp"></jsp:include>
  </body>
</html>