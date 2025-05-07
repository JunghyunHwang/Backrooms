<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- CSS Files -->
    <script>
		$(function() {
 			const params = new URLSearchParams(window.location.search);
 			const curPage = params.get("curPage") ?? 1;  
 			const category = "myqna";
 			
 			fetchAndDisplayBoardList(category, curPage);
 			
 			// fetchAndDisplayBoardList는 3가지 경우로 호출됩니다.
 			// 1. 새로 고침시(url입력해서 들어오는 경우도 포함):  url에 이전 curPage 정보가 있으면 해당 페이지의 데이터를 가져와서 보여줍니다.
 			// 2.메뉴를 통해 들어올때: url 이전 curPage 정보가 없으므로 1(첫페이지) 값에대한 데이터를 받아와서 보여줍니다.
 			// 3. 하단부에 페이지네이션 버튼을 클릭하는 경우: 해당 curPage값이 바인딩된 페이지 버튼을 클릭시 해당 페이지 데이터를 가져와서 보여줍니다. 			
			function fetchAndDisplayBoardList(category, curPage)  {
 				$.ajax({
					type : "get",
					url : "${pageContext.request.contextPath}/qna/my/"+curPage, 
					dataType : "json", //text, json, html, xml
					success : function(data, status, xhr) {
						displayData(data);
						window.history.pushState("","", "<%=request.getContextPath()%>/qna/my?curPage="+curPage);
				       	$(window).scrollTop(0);
					},
					error : function(xhr, status, error) {
						console.log("error: error");
					}
				}) 
				
			} 
			
 			// 게시글 클릭시 호출됩니다
			function fetchAndDisplayPostDetail(curPage, postNum) {
 				$.ajax({
					type : "get",
					url : "${pageContext.request.contextPath}/qna/myDetail/" + postNum,
					dataType : "json", //text, json, html, xml
					success : function(data, status, xhr) {
						console.log("fetchAndDisplayPostDetail response data: ======== " , data);
						displayDetailData(data);
						 window.history.pushState("","", "${pageContext.request.contextPath}" + "?category="+category+"&curPage="+curPage+"&postNum="+postNum);
				        //$(window).scrollTop(0);
					},
					error : function(xhr, status, error) {
						console.log("error: ", error);
					}
				}) 
				
			} 
			
			function displayData(data) {
				  const tableHead = document.getElementById("boardTablehead");
		          const tableBody = document.getElementById("boardTableBody");
		          const curPage = data.curPage;
		          const perPage = data.perPage;
		          const totalCount = data.totalCount;
		          const totalPages = Math.ceil(totalCount / perPage);
		          tableBody.innerHTML = ""; // Clear existing rows
		          tableHead.innerHTML = ""; //
		          const start = (curPage - 1) * perPage;
		          const end = start + perPage;
		          
		         
		          const tableHeadTr = document.createElement("tr");
	                tableHeadTr.innerHTML = 
	                    '<th scope="col" style="width:  5%" class="text-center">#</th>' +
	                    '<th scope="col" style="width: 25%" class="text-center">작성일</th>' +
	                    '<th scope="col" style="width: 50%" class="text-start">제목</th>' +
	                    '<th scope="col" style="width: 20%" class="text-center">작성자</th>' +
	                    '<th scope="col" style="width: 20%" class="text-center">답변상태</th>';
	                tableHead.appendChild(tableHeadTr);

	                const qnaList = data.qnaList;
	                qnaList.forEach((qna, index) => {
	                	const replayStatusTd = qna.qnaReply ? 
	                		    '<td class="text-center text-muted">✅</td>' : 
	                		    '<td class="text-center text-muted">❌</td>';
	                    const row = document.createElement("tr");
	                    row.classList.add("align-middle");
	                    row.style.cursor = "pointer";
	                    row.onclick = () => {
	                        //상세보기 페이지 정보를 가져와서 표시할때 필요한 해당 UI탬플릿으로 section을 교체합니다.
	                        swichTemplateTo();
	                        //탬플릿이 교체된 이후에 뒤로가기 버튼이 만들지고 이 시점에 뒤로가기 버튼에 클릭이벤트를 등록합니다
	                        bindBackBtnClickEvent(curPage);
	                        fetchAndDisplayPostDetail(curPage, qna.qnaNum);
	                        
	                    };
	                    row.innerHTML = 
	                        '<th scope="row" class="text-center">' + (start + index + 1) + '</th>' +
	                        '<td class="text-center text-muted">' + qna.qnaDate + '</td>' +
	                        '<td class="text-truncate">' + qna.qnaTitle + '</td>' +
	                        '<td class="text-center text-muted">' + qna.memberName + '</td>' + 
	                        replayStatusTd;

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
			        	  fetchAndDisplayBoardList(category, i);
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
			        	  fetchAndDisplayBoardList(category, curPage + PAGE_STEP);
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
			        	  fetchAndDisplayBoardList(category, totalPages);
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
		        	  fetchAndDisplayBoardList(category, 1);
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
		        	  fetchAndDisplayBoardList(category, curPage - PAGE_STEP);
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
		        	  fetchAndDisplayBoardList(category, i);
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
		        	  fetchAndDisplayBoardList(category, curPage + PAGE_STEP);
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
			        	  fetchAndDisplayBoardList(category, totalPages);
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
			        	  fetchAndDisplayBoardList(category, 1);
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
			        	  fetchAndDisplayBoardList(category, curPage - PAGE_STEP);
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
		        	  fetchAndDisplayBoardList(category, i);
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
			
			
			
			function displayDetailData(data) {
				const title = data.qnaTitle;
				const memberName = data.memberName;
				const date = data.qnaDate;
				const text = data.qnaText;
				const replyText = data.qnaReply;
				const file = data.imageFileName;
				
				$("#title").text(title);
				$("#memberName").text(memberName);
				$("#date").text(" | 🕐 " + date);
				$("#text").text(text);
				$("#inputTitle").val(title);
				$("#textarea").val(text);
				$("#replyText").text(replyText);
				
				if (file) {
				const contextPath = "${pageContext.request.contextPath}";
				const imageUrl = contextPath + "/assets/img/qna/"+file;
				console.log(imageUrl);
				const imageElement = '<img src="' + imageUrl + '" alt="게시글 이미지" class="mt-3" style="width: 500px; height: auto;">';

			    $("#text").after(imageElement); // 텍스트 아래에 이미지를 추가
				}
			}
			
			function bindBackBtnClickEvent(curPage) {
			    $("#backBtn").click(function() {
				      //window.history.back();
				      const backURL = "${pageContext.request.contextPath}/MyPage?myPage=myqna";
				      window.location.href = backURL;
				    });
			}
			
			function swichTemplateTo(type) {
				//문의내역 myqna list를 표시하던 section을 문의상세페이지를 표시할수있는 detail section으로 교체합니다
				const templateContainer = document.querySelector("#main");
				templateContainer.innerHTML = "";
					template = `
						<!-- Inquiry Detail Section -->
						<section id="detailQnaSection" class="bg-white p-4 rounded border shadow-sm d-flex flex-column">
						  <div class="table-responsive">
						    <!-- Read-Only Display for Inquiry Post -->
						    <div id="displayMode">
						      <div class="mb-2">
						        <h2 id="title" class="mb-3 fs-2"></h2>
						        <span id="memberName" class="fs-6 fw-bold"></span>
						        <span id="date" class="text-muted fs-6"></span>
						      </div>
						      <hr>
						      <p id="text" class="fs-5"></p>
						    </div>
						  </div>
						</section>

						<!-- Reply Detail Section (unchanged) -->
						<section id="detailReplySection" class="bg-white p-4 rounded border shadow-sm d-flex flex-column mt-4">
						  <div class="table-responsive flex-grow-1">
						    <!-- Header: always visible -->
						    <div class="mb-2">
						      <h2 id="replyTitle" class="mb-3 fs-2">답변</h2>
						      <span id="replyMemberName" class="fs-6 fw-bold"></span>
						      <span id="replyDate" class="text-muted fs-6"></span>
						    </div>
						    <hr>
						    <!-- Content Area: toggles between display and edit mode -->
						    <div id="replyContentArea">
						      <!-- Display Mode for Reply Content -->
						      <div id="replyDisplayMode">
						        <p id="replyText" class="fs-5"></p>
						      </div>
						    </div>
						  </div>
						  <!-- Button Row: 뒤로가기 and 작성하기/완료 -->
						  <div class="d-flex justify-content-center mt-3">
						    <button id="backBtn" class="btn btn-secondary me-3">뒤로가기</button>
						  </div>
						</section>
							`
						templateContainer.innerHTML = template;
			}

	        });
	</script>
    <!-- Start Preloader -->
    <!-- End Preloader -->
    <!-- Offcanvas Area Start -->
    <!-- Offcanvas Area End -->
    <!-- Start Left Bar -->
	<div class="col-lg-8 col-md-8 col-sm-12">
    <main class="container" style="display: inline-block;">
     
        <main class="col-md-9 d-flex flex-column vh-100" id="main">
          <section
            id="noticeSection"
            class="bg-white p-4 rounded border shadow-sm d-flex flex-column h-75"
          >
            <h2 class="fw-bold" id="boardName">Q&A</h2>
            <div
              class="table-responsive flex-grow-1"
              style="overflow-y: scroll"
            >
              <table
                class="table table-striped table-hover w-100"
                style="table-layout: fixed"
              >
                <thead class="table-dark" id="boardTablehead">
                </thead>
                <tbody id="boardTableBody"></tbody>
              </table>
            </div>
		 <!-- Pagination area: Centered pagination with a fixed margin at the bottom -->
          <!-- 페이지네이션 영역: 페이지 번호는 중앙에 고정되고, 적당한 마진을 갖습니다. -->
          <div id="imageContainer"></div>
          <nav aria-label="Notice Pagination" class="mt-3">
            <ul class="pagination justify-content-center" id="pagination">
              <!-- Pagination start -->
              <!-- Pagination end -->
            </ul>
          </nav>
            <nav class="position-relative w-100 mt-4">
              <div class="d-flex justify-content-center">
                <ul
                  class="pagination flex-nowrap"
                  id="noticeTableBodyPagination"
                ></ul>
              </div>
            </nav>
          </section>
        </main>
      
    </main>
    </div>

