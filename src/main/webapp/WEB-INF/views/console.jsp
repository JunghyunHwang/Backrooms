<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Backroom - console</title>
    <!-- CSS Files -->
    <jsp:include page="commonCss.jsp"></jsp:include>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
	
    <script>
		$(function() {
 			const params = new URLSearchParams(window.location.search);
 			const category = params.get("category") ?? "notice"; 
 			const curPage = params.get("curPage") ?? 1;  
 			const postNum = params.get("postNum");
 			const type = params.get("type");
 			const filter = params.get("filter") ?? "all";
			 const Templates = {
			    LIST_NOTICE: "listNotice",
			    LIST_EVENT:"listEvent",
			    LIST_QNA:"listQna",
			    DETAIL : "detail", //현재는 이벤트, 공지사항이 같은 상세페이지의 탬플릿을 사용하지만 필요해지면 따로 분리할 예정.
			    DETAIL_QNA: "detailQna", 
			    NEW : "new"
			}
			 const TEMPLATES_LIST_MAPPER = {"notice": Templates.LIST_NOTICE, "event":  Templates.LIST_EVENT, "qna": Templates.LIST_QNA};
 			//컨텐츠 내용이 변경되는 색션에 어떤 탬플릿으로 채워서 데이터를 받을지를 결정합니다.
 			//url에 postNum이 있으면 detail 데이터를 표시할수있는 detail 탬플릿을 <main>안에 추가합니다
 			//url에 postNum이 없으면 list 데이터를 표시할수있는 list 탬플릿을 <main>안에 추가합니다
 			
 			//postNum == null 이면 게시판 리스트 페이지
 			if (postNum == null) {
 				//데이터를 받아오기전에, 해당 데이터를 표시할수있는 탬플릿UI로 변경후 데이터를 가져와서 해당탬플릿내에 데이터를 표시합니다
  			  switchTemplateTo(TEMPLATES_LIST_MAPPER[category]);
  			  bindFilterBtns(category, filter);
 			  fetchAndDisplayBoardList(category, curPage)
 			  setActiveFilterBtnFromURL(category, filter)

 			} else {
 				//상세페이지에서 새로고침시
 			 	category == 'qna' && switchTemplateTo(Templates.DETAIL_QNA);
 				category != 'qna' && switchTemplateTo(Templates.DETAIL);

 				fetchAndDisplayPostDetail(category, postNum);
 				//detail페이지에서 사용하는 뒤로가기,작성, 수정하기 버튼에 클릭이벤트를 등록합니다
 				BindDetailBtns(category);
 			}
 			
 			setActiveMenuFromURL(category);
 			bindActiveMenu(category, filter);
 			bindNewPostButton();
 			bindDeleteButton();
 			
 			
 			function bindFilterBtns(category, filter) {
 				switch(category) {
 				
 				case "notice":
 					$("#noticeAllBtn").on("click", noticeAllBtnHandler);
 					$("#noticeTopBtn").on("click", noticeTopBtnHandler);
 					break;
 				case "event":
 					$("#eventAllBtn").on("click", eventAllBtnHandler);
 					$("#eventTopBtn").on("click", eventTopBtnHandler);
 					break;
 				case "qna":
 					$("#replayAllBtn").on("click", replayAllBtnHandler);
 					$("#replyPendingBtn").on("click", replyPendingBtnHandler);
 					$("#replyCompletionBtn").on("click", replyCompletionBtnHandler);
 					break;
 				default:
 					throw new Error(filter + "은 " + category + "에서 지원되지 않는 필터 형식입니다.");
 				}
 			}
 			
 			function setActiveFilterBtn(category, filter) {
				$.each( $(".filter-btn"), function(){
                    this.classList.remove("active");
				})
				const target = document.querySelector("button[data-filter="+filter+"]");
				target.classList.add("active");
 			}
 			
 			
 			function replayAllBtnHandler(event) {
 				setActiveFilterBtn("qna", "all");
 				fetchAndDisplayBoardList("qna", 1, "all");
 			}
 			
 			
 			function replyPendingBtnHandler(event) {
 				setActiveFilterBtn("qna", "pending");
 				fetchAndDisplayBoardList("qna", 1, "pending");
 			}
 			
 			
 			function replyCompletionBtnHandler(event) {
 				setActiveFilterBtn("qna", "completion");
 				fetchAndDisplayBoardList("qna", 1, "completion");
 			}
 			
 			function eventTopBtnHandler(event) {
 				setActiveFilterBtn("event", "top");
 				fetchAndDisplayBoardList("event", 1, "top");
 			}
 			
 			
 			function eventAllBtnHandler(event) {
 				setActiveFilterBtn("event", "all");
 				fetchAndDisplayBoardList("event", 1, "all");
 			}
 			
 			function noticeTopBtnHandler(event) {
 				setActiveFilterBtn("notice", "top");
 				fetchAndDisplayBoardList("notice", 1, "top");
 			}
 			
 			function noticeAllBtnHandler(event) {
 				setActiveFilterBtn("notice", "all");
 				fetchAndDisplayBoardList("notice", 1, "all");
 			}
 			

 			//등록 버튼에 클릭 이벤트 핸들러를 바인딩시킵니다
 			function bindNewPostButton() {
			$("#postRegisterButton").on("click", function () {
	 			const params = new URLSearchParams(window.location.search);
	 			const category = params.get("category");
				//1. template -> "new" 로 교체.
				switchTemplateTo(Templates.NEW);
				//뒤로가기 버튼에 클릭이벤트 추가
				bindBackbtn();
				//등록 버튼에 submit이벤트 추가 
				bindPostFormSubmit();
				//
			})
			
 			}
 			//###
 			function bindPostFormSubmit() {
               const formEle = $("#postForm");
              formEle.on("submit", function(event) {
 				const topPostCheckbox = $("#topPostCheckbox")[0].checked;
                const postState = topPostCheckbox === true ? 9 : 0;
 	 			const params = new URLSearchParams(window.location.search);
 	 			const category = params.get("category") ?? "notice";
                const url = "${pageContext.request.contextPath}/console/board/" + category;
                $("#postState").val(postState);
                formEle.attr("action", url);
              });
            }
 				// $.ajax({
					// type : "post",
					// url : url,
					// dataType : "text ", //text, json, html, xml
					// data: {
					// 	postTitle: postTitle,
					// 	postText: postText,
					// 	postState: postState
					// },
					//
					// success : function(data, status, xhr) {
				 //        //window.history.pushState("","", "Console?category="+category+"&curPage="+ curPage +"&postNum="+postNum);
				 //        //$(window).scrollTop(0);
				 //        //등록이 완료되면 등록한 글을 볼수있게 해당 카테고리의 첫페이지로 이동합니다
				 //        	const firstPageUrl = (window.location).toString().split("&curPage=")[0];
				 //        	window.location.href = firstPageUrl;
				 //        	alert("등록 완료!");
					// },
					// error : function(xhr, status, error) {
					// 	if (xhr.status == 403) {
					// 		window.location.href = "SignIn";
					// 		alert("해당 작업에대한 권한이 없습니다.")
					// 	} else {
					// 		console.log("error: ", error);
					// 		alert("등록 실패!");
					// 	}
					// }
 				// })
 				// })

 			// }
 			
 			function bindDeleteButton() {
			$("#postDeleteButton").on("click", function () {
	 			const params = new URLSearchParams(window.location.search);
	 			const category = params.get("category");
				const listToBeDeleted = [];
				$("input:checked").each(function() {
					if (this.dataset.pknum !== undefined) {
						listToBeDeleted.push(this.dataset.pknum)
					}
						
				})
				
				if (listToBeDeleted.length == 0) {
					alert("삭제할 게시글을 선택해주세요.");
					return;
				}
				
				$.ajax({
        type: "DELETE",
        url: "${pageContext.request.contextPath}/console/board/" + category,
        contentType: "application/json",
        data: JSON.stringify({list: listToBeDeleted}),  // JSON 형태로 데이터 전송
        success: function (data, status, xhr) {
            console.log("삭제 성공:", data);
            alert("삭제 완료!");
            location.reload();
        },
        error: function (xhr, status, error) {
        	
			if (xhr.status == 403) {
				window.location.href = "SignIn";
				alert("해당 작업에대한 권한이 없습니다.")
			} else {
				console.log("삭제하는 도중에 에러 발생: ", error);
				alert("삭제 실패");
			}
        	

        }
   		 });
			})
 				
 			}
 			
 			
 			function bindBackbtn() {
		    $("#backBtn").click(function() {
			      //window.history.back();
			      //뒤로가기버튼 클릭시 새로고침이 일어납니다. 이전 url로 재요청하는거라서 console.jsp다시 받아서 ajax로 동적으로 채웁니다
			      const backURL = window.location.href.split("&postNum=")[0];
			      window.location.href = backURL;
			    });
 				
 			}
				function fetchAndDisplayPostDetail(category, postNum) {
	 			const params = new URLSearchParams(window.location.search);
	 			const curPage = params.get("curPage") ?? 1;
 				$.ajax({
					type : "get",
					url: "${pageContext.request.contextPath}/console/board/" + category + "/detail/" + postNum,
					dataType : "json", //text, json, html, xml
					success : function(data, status, xhr) {
						displayDetailData(data, category);
				        window.history.pushState("","", "${pageContext.request.contextPath}/console/board" + "?category="+category+"&curPage="+curPage+"&postNum="+postNum);
				        //$(window).scrollTop(0);
					},
					error : function(xhr, status, error) {
						console.log("error: ", error);
					}
				}) 
			} 
			//###
            function extractExtension(fileName) {
               if (fileName === undefined || fileName?.length == 0)  {
                 return;
               }
              const dotIndex = fileName?.lastIndexOf('.');
              return dotIndex !== -1 ? fileName.substring(dotIndex + 1) : '';
          }

          function isImageIncluded(imageFileNameList) {
            const imageExtensionMapper = {
              "jpeg": "jpeg",
              "jpg": "jpg",
              "png": "png",
              "gif": "gif",
              "raw": "raw",
            }
            return imageFileNameList
            .map(fileNames => extractExtension(fileNames.imageUploadFileName))
            .map(ext => ext.toLowerCase(ext))
            .some(ext => imageExtensionMapper[ext]);
          }
          function displayFileAndAttach(data) {
            console.log(data?.imageFileNamesList);
            const list = data?.imageFileNamesList;
            const contextPath = '${pageContext.request.contextPath}';
            const imageContainer = document.getElementById("imageContainer");
            const attachList = document.getElementById("attachList");
            const attachCountElement = document.getElementById("attachCount");
            const attachContainer = document.getElementById("attachContainer");
            const attachCount = list?.length;

            if (attachCount === 0) {
              attachContainer.classList.add("d-none");
              return;
            }

            attachCountElement.textContent =  list?.length;
            if (!isImageIncluded(list)) {
              imageContainer.classList.add("d-none");
            }

            list.forEach( item => {
              console.log(item);
              const storeFileName = item.imageStoreFileName;
              const uploadFileName = item.imageUploadFileName;

              const wrapper = document.createElement('div');
              wrapper.className = 'text-center';
              wrapper.style.maxWidth = '300px';

              const img = document.createElement('img');
              img.src = contextPath + '/images/board/' + storeFileName;
              img.alt = uploadFileName;
              img.className = 'img-thumbnail mb-2';

              const fileName = document.createElement('div');
              fileName.textContent = uploadFileName;
              fileName.className = 'small text-muted';

              wrapper.appendChild(img);
              wrapper.appendChild(fileName);

              imageContainer.appendChild(wrapper);

              const href = contextPath + '/attach/board/' + storeFileName;
              const anchorElement = document.createElement("a");
              anchorElement.href = href;
              anchorElement.textContent = uploadFileName
              anchorElement.className = "text-decoration-none text-dark me-3 ml-2";
              attachList.appendChild(anchorElement);
            })
          }
			function displayDetailData(data, category) {
               displayFileAndAttach(data);
              let title = "";
				let memberName = "";
				let date = "";
				let text = "";
				let replayText = "";
				
				switch (category) {
				  case "notice": 
						 title = data.noticeTitle;
						 memberName = data.memberName;
						 date = data.noticeDate;
						 text = data.noticeText;
				    break;
				  case "event":
					  title = data.eventTitle;
						 memberName = data.memberName;
						 date = data.eventDate;
						 text = data.eventText;
					break;

				  case "qna":
						 title = data.qnaTitle;
						 memberName = data.memberName;
						 date = data.qnaDate;
						 text = data.qnaText;
						 replyText = data.qnaReply;
				    break;
				  default:
				    console.log(`${category} 은 지원되지 않는 카테고리입니다.`);
				}
				
				$("#title").text(title);
				$("#memberName").text(memberName);
				$("#date").text(" | 🕐 " + date);
				$("#text").text(text);
				$("#inputTitle").val(title);
				$("#textarea").val(text);
				
				if (category == "qna") {
					$("#replyText").text(replyText);
					$("#editBtn").text(replyText == undefined ? "작성하기" : "수정하기");
				}
				
			}
			
			function BindDetailBtns(category) {
				
				//뒤로가기 버튼하고 수정버튼이 만들어지는 이 시점에 해당버튼에 클릭 이벤트를 등록합니다
				//문의 - 상세페이지에 있는 버튼에 클릭 이벤트를 등록합니다
				if (category == "qna") {
					//문의게시판의 상세페이지는 버튼이 다른 상세페이지와 다르게 들어가서 다르게 표시합니다
				    $("#editBtn").click(function() {
				    	const isEditBtnClicked = $(this).text().trim() === "작성하기" || $(this).text().trim() === "수정하기";
				        if (isEditBtnClicked) {
				         const replayText = $("#replyText").text();
				          $("#replyEditMode").removeClass("d-none");
				          $("#replyInput").val(replayText);
				          $("#replyDisplayMode").addClass("d-none");
				          $(this).text("등록하기");
				          $("#replyInput")[0].focus();
				        } else {
				          const qnaReplay = $("#replyInput").val();
				    	  const params = new URLSearchParams(window.location.search);
				 		  const category = params.get("category");  			
				 		  const postNum = parseInt(params.get("postNum"));
				    	  $.ajax({
								type : "PUT",
								url: "${pageContext.request.contextPath}/console/board/" + category,
								//보내는 데이터 타입 
								contentType: 'application/json',
								//받는 데이터 타입 
								dataType : "text", //text, json, html, xml
								data: JSON.stringify({
							        postNum: postNum,
							        qnaReplay: qnaReplay
							    }),
								success : function(data, status, xhr) {
									 console.log("등록 성공:", data);
							            alert("등록 완료!");
							            //const backURL = window.location.href.split("&postNum=")[0];
									      //window.location.href = backURL;
									      //window.location.href == window.location.href;
									      //서버에 저장을 성공적으로 하고나면 새로고침을 해서 서버에서 업데이트된 데이터를 가져 보여줍니다. 
									      //변경된 사항을 다시 보고 제대로 변경되었는지 확인 할수있습니다. 
									      window.location.reload();
								},
								error : function(xhr, status, error) {
								if (xhr.status == 403) {
									window.location.href = "SignIn";
									alert("해당 작업에대한 권한이 없습니다.")
								} else {
									console.log("수정시 에러 발생: ", error);
									alert("수정 실패!");
								}
								}
								
							}) 
				        }
				      });
					
				} else {
			 //공지, 이벤- 상세페이지에 있는 버튼에 클릭 이벤트를 등록합니다
			    $("#editBtn").click(function() {
				      if ($(this).text().trim() === "수정하기") {


				        // Switch to edit mode: hide display div, show input fields, change button text
				        $(this).text("등록하기");
                        $('#title').toggleClass('d-none');
                        $('#inputTitle').toggleClass('d-none');
                        $('#text').toggleClass('d-none');
                        $('#textarea').toggleClass('d-none');
                        //TODO: 첨부파일도 추가/삭제 할수있는 기능도 추가하기: 이미지테이블에 status 컬럼 추가 필요) 0: 기본 1: 삭제
				        $("#textarea")[0].focus();

				      } else {
                        //등록하기 버튼 클릭시
				        // Complete editing: update display with new values, revert button text, switch back to read-only
				    	  const params = new URLSearchParams(window.location.search);
				 			const category = params.get("category");  			
				 			const postNum = parseInt(params.get("postNum"));
				    	    const title = $("#inputTitle").val();
					        const text = $("#textarea").val();
					        
				    	  $.ajax({
								type : "PUT",
								url: "${pageContext.request.contextPath}/console/board/" + category,
								//보내는 데이터 타입 
								contentType: 'application/json',
								//받는 데이터 타입 
								dataType : "text", //text, json, html, xml
								data: JSON.stringify({
							        postNum: postNum,
							        title: title,
							        text: text
							    }),
								success : function(data, status, xhr) {
									 console.log("등록 성공:", data);
							            alert("등록 완료!");
							            //const backURL = window.location.href.split("&postNum=")[0];
									      //window.location.href = backURL;
									      //window.location.href == window.location.href;
									      //서버에 저장을 성공적으로 하고나면 새로고침을 해서 서버에서 업데이트된 데이터를 가져 보여줍니다. 
									      //변경된 사항을 다시 보고 제대로 변경되었는지 확인 할수있습니다. 
									      window.location.reload();
								},
								error : function(xhr, status, error) {
									if (xhr.status == 403) {
										window.location.href = "SignIn";
										alert("해당 작업에대한 권한이 없습니다.")
									} else {
										console.log("수정시 에러 발생: ", error);
										alert("수정 실패!");
									}
								}
							}) 
				      }
				    });
				}
				  //
				    $("#backBtn").click(function() {
				      //window.history.back();
				      //뒤로가기버튼 클릭시 새로고침이 일어납니다. 이전 url로 재요청하는거라서 console.jsp다시 받아서 ajax로 동적으로 채웁니다
				      const backURL = window.location.href.split("&postNum=")[0];
				      window.location.href = backURL;
				    });
				
			}
			

			function fetchAndDisplayBoardList(category, curPage, filterFromArgument) {
	 			const params = new URLSearchParams(window.location.search);
	 			const filterFromURL = params.get("filter") ?? "all";
	 			const filter = filterFromArgument === undefined ? filterFromURL :  filterFromArgument
 				$.ajax({
					type : "get",
					url : "${pageContext.request.contextPath}/console/board/" + category + "/list/" + curPage + "?filter=" + filter,
					dataType : "json", //text, json, html, xml
					success : function(data, status, xhr) {
						displayListData(category, data);
				        window.history.pushState("","", "${pageContext.request.contextPath}/console/board" + "?category="+category+"&curPage="+curPage+"&filter="+filter);
				       // $(window).scrollTop(0);
					},
					error : function(xhr, status, error) {
					}
				}) 
				
			} 
			
			function displayListData(category, data) {
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
		 		  const BOARD_CATEGORY_MAPPING = {notice:"공지", event:"이벤트", qna: "문의"};
		 		 $("#boardName").text(BOARD_CATEGORY_MAPPING[category] ?? "공지");
		         
		          switch(category) {
		          case "notice":{
		        	  const tableHeadTr = document.createElement("tr");
		        	  
		        	  tableHeadTr.innerHTML = 
		        		  '<th scope="col" style="width: 10%" class="text-center">#</th>' +
		        		  '<th scope="col" style="width: 30%" class="text-center">작성일</th>' +
		        		  '<th scope="col" style="width: 40%" class="text-start"> 제목</th>' +
		        		  '<th scope="col" style="width: 20%" class="text-center"> 작성자</th>' +
		        		  '<th scope="col" style="width: 20%" class="text-center">' +
							'<div class="d-flex align-items-center justify-content-center">' +
									 '<span>전체선택</span>'+
							'<input type="checkbox" id="checkboxAll" class="ms-2 checkbox" style="width: 25px; height: 25px;">'+
							 '</div>'+
						'</th>';
	                  tableHead.appendChild(tableHeadTr);

		        	  const noticeList = data.noticeList;
			          noticeList.forEach((notice, index) => {
				            const row = document.createElement("tr");
				            //상태가 9이면 상단글 로 표시를, 아니면  번호로  표시합니다 
				            const postStatus = notice.noticeState == 9 ? "필독" : (start + index + 1);
				            row.classList.add("align-middle");
				            row.style.cursor = "pointer";
				            row.onclick = (event) => {
				            	tableRowClickHandler(event, category, notice.noticeNum);
				            };
				            row.innerHTML = 
							  '<th scope="row" class="text-center">' + postStatus + '</th>' +
		  					  '<td class="text-center text-muted">' + notice.noticeDate + '</td>' +
		  					  '<td class="text-truncate">' + notice.noticeTitle + '</td>' +
		  					 '<td class="text-center text-muted">' + notice.memberName + '</td>' +
		  					'<td class="text-center checkbox">' +
		  		             '<input class="checkbox" data-pkNum="' + notice.noticeNum + 
		  		             '" type="checkbox" style="width: 35px; height: 25px;">' +
		  		             '</td>';
				            tableBody.appendChild(row);
				          });
			          
			          break;
		          }
		          case "event": {
		        	  const tableHeadTr = document.createElement("tr");
		        	  
		        	  tableHeadTr.innerHTML = 
		        		  '<th scope="col" style="width: 10%" class="text-center">#</th>' +
		        		  '<th scope="col" style="width: 30%" class="text-center">작성일</th>' +
		        		  '<th scope="col" style="width: 40%" class="text-start"> 제목</th>' +
		        		  '<th scope="col" style="width: 20%" class="text-center"> 작성자</th>' +
		        		  '<th scope="col" style="width: 20%" class="text-center">' +
							'<div class="d-flex align-items-center justify-content-center">' +
									 '<span>전체선택</span>'+
							'<input type="checkbox" id="checkboxAll" class="ms-2 checkbox" style="width: 25px; height: 25px;">'+
							 '</div>'+
						'</th>';
	                  tableHead.appendChild(tableHeadTr);
	                  
		        	  const eventList = data.eventList;
			          eventList.forEach((event, index) => {
				            const row = document.createElement("tr");
				            const postStatus = event.eventState == 9 ? "진행중" : (start + index + 1);
				            row.classList.add("align-middle");
				            row.style.cursor = "pointer";
				            row.onclick = (eventObject) => {
				            	tableRowClickHandler(eventObject, category, event.eventNum);
				            };
				            row.innerHTML = 
							  '<th scope="row" class="text-center">' + postStatus + '</th>' +
		  					  '<td class="text-center text-muted">' + event.eventDate + '</td>' +
		  					  '<td class="text-truncate">' + event.eventTitle + '</td>' +
		  					 '<td class="text-center text-muted">' + event.memberName + '</td>' + 
		  					'<td class="text-center checkbox">' +
		  		             '<input class="checkbox" data-pkNum="' + event.eventNum + 
		  		             '" type="checkbox" style="width: 35px; height: 25px;">' +
		  		             '</td>';
		  					 
		  					 
				            tableBody.appendChild(row);
				          });
			          
			          break;
		          }
		          case "qna": {
		        	  const tableHeadTr = document.createElement("tr");
			        	  tableHeadTr.innerHTML = 
			        		  '<th scope="col" style="width:  5%" class="text-center input">#</th>' +
			        		  '<th scope="col" style="width: 25%" class="text-center">작성일</th>' +
			        		  '<th scope="col" style="width: 50%" class="text-start"> 제목</th>' +
			        		  '<th scope="col" style="width: 20%" class="text-center"> 작성자</th>' +
			        		  '<th scope="col" style="width: 20%" class="text-center"> 답변상태</th>' +
			        		  '<th scope="col" style="width: 20%" class="text-center">' +
  								'<div class="d-flex align-items-center justify-content-center">' +
   									 '<span>전체선택</span>'+
    							'<input type="checkbox" id="checkboxAll" class="ms-2 checkbox" style="width: 25px; height: 25px;">'+
 								 '</div>'+
							'</th>';

	                  tableHead.appendChild(tableHeadTr);

				        	  const qnaList = data.qnaList;
				        	  
				        	  qnaList.forEach((qna, index) => {
				        		  const replayStatusTd = qna.qnaReply === null ? '<td class="text-center text-muted">'+"❌ "+ '</td>' :  '<td class="text-center text-muted">'+"✅ "+ '</td>'
						            const row = document.createElement("tr");
						            row.classList.add("align-middle");
						            row.style.cursor = "pointer";
						            row.onclick = (event) => {
						            	tableRowClickHandler(event, category, qna.qnaNum);
						            	
						            };
						            row.innerHTML = 
									  '<th scope="row" class="text-center">' + (start + index + 1) + '</th>' +
				  					  '<td class="text-center text-muted">' + qna.qnaDate + '</td>' +
				  					  '<td class="text-truncate">' + qna.qnaTitle + '</td>' +
				  					 '<td class="text-center text-muted">' + qna.memberName + '</td>'+
				  					replayStatusTd + 
				  					'<td class="text-center checkbox">' +
				  		             '<input class="checkbox" data-pkNum="' + qna.qnaNum + 
				  		             '" type="checkbox" style="width: 35px; height: 25px;">' +
				  		             '</td>';
				  					
						            tableBody.appendChild(row);
						          });
				        	  
				        	  	break;
				        	  	
		          }
		          }
		          
		          updatePagination(totalPages, curPage, category);
		          addSelectAllToggleEvent();
				
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
		       			
		       //총페이지수가 FIRST_PAGES_BUTTON_COUNT미만인 경우에 처리합니다
		       if (totalPages < FIRST_PAGES_BUTTON_COUNT) {
		    	   renderFirstPages(limit, curPage, totalPages, category, PAGE_STEP);
		    	   return;
		       }
		       
		       //총페이지수가 FIRST_PAGES_BUTTON_COUNT 이상인 경우에 처리합니다
		      if (curPage < limit ) {
		    	  renderFirstPages(limit, curPage, totalPages, category, PAGE_STEP);
		       	} else if (limit <= curPage && curPage < totalPages - PAGE_STEP) {
		       		renderMiddlePages(curPage, totalPages, category, PAGE_STEP);
		       	} else if (totalPages > 4 && curPage >= totalPages - 3) {
		       		renderLastPages(curPage, totalPages, category, PAGE_STEP);
		       	}
		      }		    	  
		       

			// input checkbox외에 다른 부분을 클릭해야 상세보기 페이지로 이동하게하는 함수  
			//fetchDetailAndDisplay(category, notice.noticeNum);
			function tableRowClickHandler(event, category, postNum) {
            	let isCheckbox = false;
            	if (event.target) {
            		isCheckbox = event.target.classList.contains("checkbox");
            	}
            	//체크박스 눌렀을때는 상세페이지로 이동하지 않고 현재페이지에 머물게함. 체크박스가 아닐때만 상세페이지로 이동
            	if (!isCheckbox) {
            		//데이터를 가져와서 표시하기전에, 해당 데이터를 표시할수있는 템플릿으로 먼저 바꾸고 이후에 가져와서 표시합니
            		//qna면 Templates.DETAIL_QNA 으로 변경합니다 
            		category == 'qna' && switchTemplateTo(Templates.DETAIL_QNA);
            		//qna가 아닌 notice, event면 Templates_DETAIL 로 변경합니다 
 				category != 'qna' && switchTemplateTo(Templates.DETAIL);

            		//detail 데이터를 가져와 표시합니다
            		fetchAndDisplayPostDetail(category, postNum);
            		// detail 페이지에서 사용되는 뒤로가기,수정하기,작성하기 버튼이 만들어진 이 시점에 클릭이벤트를 추가합니다.
            		BindDetailBtns(category);
	            	}
            }
			

			function addSelectAllToggleEvent() {
                //tableHead가 생성되는 시점이 동적으로 메뉴탭을 누를때 생성이 되기때문에 해당 html요소들이 미리 만들어져있지 않음. 
                // 등록할 요소가 그 시점에는 아직 없기때문 첫번째 로드될때 onload, domContentload와 같은 이벤트로 등록되게 할수가없음
                //그래서 동적으로 생성될때 추가해야됨. 위에서 요소가 만들어진 뒤에 appendChild 를 통해 html에 동적으로 추가된 상태이기때문에 등록이 가능함
                document.querySelector("#checkboxAll").addEventListener("click", function() {
              	  //전체선택 토글시 아래 체크박스들도 같은 값으로 토글되게하는 코드 
              	    const allCheckBox = document.querySelector("#checkboxAll");
              	    const checked = allCheckBox.checked;
              	    let list = document.querySelectorAll(".checkbox");
              	    list.forEach(function (element, currentIndex, list) {
              	  //class가 checkbox인 요소로 조회하면 checkbox의 부모까지 나오는데 거기서 부모를 제외한 실제 checkbox의 checked값만 변
              	    	  const isParentOfCheckbox = element.classList.contains("text-center");
              	    	  if (!isParentOfCheckbox) {
              	    		  element.checked = checked;
              	    	  }
              	    	}, null);
              	});
			}
			
			//새로고침이나 이전페이지로 돌아왔을때 url에 있는 category에따라 해당 메뉴에 active효과를 주는 함수

			 function setActiveFilterBtnFromURL(category, filter) {
				$.each( $(".filter-btn"), function(){
                    this.classList.remove("active");
				})
				const target = document.querySelector("button[data-filter="+filter+"]");
				target.classList.add("active");
 			}
			
			
 			function setActiveMenuFromURL(category) {
				$.each( $(".nav-link"), function(){
                    this.classList.remove("bg-primary", "text-white");
                    this.classList.add("text-dark");
				})
				const target = document.querySelector("a[data-category="+category+"]");
				target.classList.add("bg-primary", "text-white");
 			}
			
			function bindActiveMenu(category, filter) {
			$("#menu").on("click", function(event) {
				//메뉴 클릭시 해당 메뉴에 active 효과 추가합니다
	 			$.each($(".nav-link"), function() {
                    this.classList.remove("bg-primary", "text-white");
                    this.classList.add("text-dark");
				} ) 
				event.target.classList.add("bg-primary", "text-white");
	 			//get type from event.target
	 			const category = event.target.dataset.category;
	 			//메뉴 클릭시, 클릭한 html요소의 data-type속성에서 type값을 읽은뒤 해당 타입별 첫페이지를 보여줍니다
	 			const BOARD_CATEGORY_MAPPING = {notice:"공지", event:"이벤트", qna: "문의"};
	 			$("#boardName").text(BOARD_CATEGORY_MAPPING[category] ?? "공지");
	 			
	 			//List를 표시할수잇는 탬플릿으로 바꾼 이후에 데이터를 가져와서 표시합니다
	 			switchTemplateTo(TEMPLATES_LIST_MAPPER[category]);
	 			bindFilterBtns(category, filter);
	 			if (category == "notice") {
	 				fetchAndDisplayBoardList(category, 1, "all");
	 			} else if (category == "event") {
	 				fetchAndDisplayBoardList(category, 1, "all");
	 			} else if (category == "qna") {
	 				fetchAndDisplayBoardList(category, 1, "all");
	 			}
	 			
	 			// 템플릿 교체 - 데이터 가져와서 채움 - 탬플릿교체하면서 등록/삭제에 등록되어있는 이벤트도 다시 등록해야됨.
	 			// 탬플릿교체로인해 등록/삭제 버튼에 등록되어있던 이벤트들도 다시 새로운 html요소에 등하는 과정이 필요.
	 			bindNewPostButton();
	 			bindDeleteButton();
	 			
			})
				
			}
			
		
			function switchTemplateTo(TemplateType) {
				const templateContainer = document.querySelector("#main");
				templateContainer.innerHTML = "";
				let template = "";
				
				switch (TemplateType) {
				  case Templates.LIST_NOTICE :
					template = `
				 <section
		            id="listNoticeSection"
		            class="bg-white p-4 rounded border shadow-sm d-flex flex-column h-75"
		          >
		            <h2 class="fw-bold" id="boardName"></h2>
		            <div
		              id="tableContainer"
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
		          <nav class="mt-3 container-fluid">
		          <div class="row align-items-center">
		            <!-- Filter buttons on the left -->
		            <div class="col-4 d-flex ms-2 justify-content-start gap-3">
		              <button type="button" class="filter-btn btn btn-outline-primary active" data-filter="all" id="noticeAllBtn">전체글</button>
		              <button type="button" class="filter-btn btn btn-outline-primary " data-filter="top" id="noticeTopBtn">필독글</button>
		            </div>
		            <!-- Pagination in the center -->
		            <div class="col-4 d-flex justify-content-center">
		              <ul class="pagination flex-nowrap mb-0" id="pagination">
		                <!-- Pagination items here -->
		              </ul>
		            </div>
		            <!-- Register and Delete buttons on the right -->
		            <div class="col d-flex justify-content-end gap-2" id="buttons">
		              <button class="btn btn-primary" id="postRegisterButton">등록</button>
		              <button class="btn btn-danger" id="postDeleteButton">삭제</button>
		            </div>
		          </div>
		        </nav>
						</section>
				`
					break;
				
				  case Templates.LIST_EVENT :
						template = `
					 <section
			            id="listEventSection"
			            class="bg-white p-4 rounded border shadow-sm d-flex flex-column h-75"
			          >
			            <h2 class="fw-bold" id="boardName"></h2>
			            <div
			              id="tableContainer"
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
			          <nav class="mt-3 container-fluid">
			          <div class="row align-items-center">
			            <!-- Filter buttons on the left -->
			            <div class="col-4 d-flex ms-2 justify-content-start gap-3">
			              <button type="button" class="filter-btn btn btn-outline-primary active" data-filter="all" id="eventAllBtn">전체글</button>
			              <button type="button" class="filter-btn btn btn-outline-primary " data-filter="top" id="eventTopBtn">진행중글</button>
			            </div>
			            <!-- Pagination in the center -->
			            <div class="col-4 d-flex justify-content-center">
			              <ul class="pagination flex-nowrap mb-0" id="pagination">
			                <!-- Pagination items here -->
			              </ul>
			            </div>
			            <!-- Register and Delete buttons on the right -->
			            <div class="col d-flex justify-content-end gap-2" id="buttons">
			              <button class="btn btn-primary" id="postRegisterButton">등록</button>
			              <button class="btn btn-danger" id="postDeleteButton">삭제</button>
			            </div>
			          </div>
			        </nav>
							</section>
					`
						break;
					
				//#TODO	
				  case Templates.LIST_QNA :
						template = `
					 <section
			            id="listQnaSection"
			            class="bg-white p-4 rounded border shadow-sm d-flex flex-column h-75"
			          >
			            <h2 class="fw-bold" id="boardName"></h2>
			            <div
			              id="tableContainer"
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
			          <nav class="mt-3 container-fluid">
			          <div class="row align-items-center">
			            <!-- Filter buttons on the left -->
			            <div class="col-4 ms-2 d-flex justify-content-start gap-3">
			              <button type="button" class="filter-btn btn btn-outline-primary active" data-filter="all" id="replayAllBtn">전체글</button>
			              <button type="button" class="filter-btn btn btn-outline-primary" data-filter="pending" id="replyPendingBtn">대기글</button>
			              <button type="button" class="filter-btn btn btn-outline-primary" data-filter="completion" id="replyCompletionBtn">완료글</button>
			            </div>
			            <!-- Pagination in the center -->
			            <div class="col-4 d-flex justify-content-center">
			              <ul class="pagination flex-nowrap mb-0" id="pagination">
			                <!-- Pagination items here -->
			              </ul>
			            </div>
			            <!-- Register and Delete buttons on the right -->
			            <div class="col d-flex justify-content-end gap-2" id="buttons">
			              <button class="btn btn-danger" id="postDeleteButton">삭제</button>
			            </div>
			          </div>
			        </nav>

							</section>
					`
						break;
				//공지, 이벤트 상세보기 템플릿
                    //###
				  case Templates.DETAIL:
						template = `
<section id="detailSection" class="bg-white p-4 rounded border shadow-sm d-flex flex-column">
  <div class="table-responsive flex-grow-1" style="overflow-y: auto">
    <div class="mb-3">
      <h2 id="title" class="fs-2 mb-0"></h2>
      <input type="text" id="inputTitle" class="form-control fs-2 d-none" placeholder="제목을 입력해주세요.">
    </div>
    <div class="mb-3">
      <span id="memberName" class="fs-6 fw-bold me-2"></span>
      <span id="date" class="text-muted fs-6"></span>
    </div>

    <hr class="mb-4"/>
    <!--imageContainer-->
    <div id="imageContainer" class="mb-4 d-flex flex-wrap gap-3"></div>
    <div class="mb-4">
      <p id="text" class="fs-5 lh-lg px-2 py-1" style="min-height: 207px;"></p>
      <textarea id="textarea" class="form-control fs-5 d-none" style="height: 207px;" rows="30" placeholder="내용을 입력해주세요."></textarea>
    </div>
    <!-- Attachments -->
    <div id="attachContainer" class="border p-2 rounded  mb-3">
      <div class="mb-1">
        <span class="fw-bold small">원본 첨부파일</span>
        <span id="attachCount" class="text-danger fw-bold small"></span>
      </div>
      <div id="attachList" class="d-flex flex-wrap gap-2 small text-muted m-lg-1"></div>
    </div>
  </div>

  <!-- Buttons -->
  <div class="d-flex justify-content-center mt-3">
    <button id="backBtn" class="btn btn-secondary me-3">뒤로가기</button>
    <button id="editBtn" class="btn btn-primary">수정하기</button>
  </div>
</section>

<!--<section id="detailSection" class="bg-white p-4 rounded border shadow-sm d-flex flex-column">-->
<!--  <div class="table-responsive flex-grow-1" style="min-height: 300px; overflow-y: auto">-->
<!--    &lt;!&ndash; Display Mode (Read-Only) &ndash;&gt;-->
<!--    <div id="displayMode">-->
<!--      &lt;!&ndash; Title &ndash;&gt;-->
<!--      <h2 id="title" class="mb-3 fs-2"></h2>-->

<!--      &lt;!&ndash; Meta: Writer and Date &ndash;&gt;-->
<!--      <div class="mb-2">-->
<!--        <span id="memberName" class="fs-6 fw-bold me-2"></span>-->
<!--        <span id="date" class="text-muted fs-6"></span>-->
<!--      </div>-->

<!--      &lt;!&ndash; Images &ndash;&gt;-->
<!--      <div id="imageContainer" class="mb-3 d-flex flex-wrap gap-3"></div>-->

<!--      &lt;!&ndash; Divider &ndash;&gt;-->
<!--      <hr>-->

<!--      &lt;!&ndash; Content &ndash;&gt;-->
<!--      <p id="text" class="fs-5"></p>-->

<!--      <div id="attachContainer"></div>-->
<!--    </div>-->

<!--    &lt;!&ndash; Edit Mode (Hidden by default) &ndash;&gt;-->
<!--    <div id="editMode" class="d-none">-->
<!--      &lt;!&ndash; Editable Title &ndash;&gt;-->
<!--      <input type="text" id="inputTitle" class="form-control mb-3 fs-2" placeholder="제목을 입력해주세요.">-->

<!--      &lt;!&ndash; Editable Content &ndash;&gt;-->
<!--      <textarea id="textarea" class="form-control fs-5" style="height: 207px;" rows="30" placeholder="내용을 입력해주세요."></textarea>-->
<!--    </div>-->
<!--  </div>-->

<!--  &lt;!&ndash; Button Row &ndash;&gt;-->
<!--  <div class="d-flex justify-content-center mt-3">-->
<!--    <button id="backBtn" class="btn btn-secondary me-3">뒤로가기</button>-->
<!--    <button id="editBtn" class="btn btn-primary">수정하기</button>-->
<!--  </div>-->
<!--</section>-->
<!--					<section id="detailSection" class=" bg-white p-4 rounded border shadow-sm d-flex flex-column">-->
<!--							<div class="table-responsive flex-grow-1" style="min-height: 300px; overflow-y: auto">-->
<!--								&lt;!&ndash; Read-Only Display &ndash;&gt;-->


<!--								<div id="displayMode">-->
<!--									<div class="mb-2">-->
<!--									<h2 id="title" class="mb-3 fs-2"></h2>-->
<!--										<span id="memberName" class="fs-6 fw-bold"></span>-->
<!--										<span id="date" class="text-muted fs-6"></span>-->
<!--									</div>-->
<!--<div id="imageContainer" class="mb-3 d-flex flex-wrap gap-3"></div>-->
<!--									<hr>-->
<!--									<p id="text" class="fs-5"></p>-->
<!--								</div>-->
<!--								&lt;!&ndash; Edit Mode (hidden by default) &ndash;&gt;-->
<!--						<div id="editMode" class="d-none">-->
<!--							<input type="text" id="inputTitle" class="form-control mb-2 fs-2" >-->
<!--							<textarea id="textarea" class="form-control fs-5" style="height: 207px;" rows="30"></textarea>-->
<!--						</div>-->
<!--							</div>-->
<!--							&lt;!&ndash; Button Row: 뒤로가기 and Edit/Complete &ndash;&gt;-->
<!--							<div class="d-flex justify-content-center mt-3">-->
<!--								<button id="backBtn" class="btn btn-secondary me-3">뒤로가기</button>-->
<!--								<button id="editBtn" class="btn btn-primary">수정하기</button>-->
<!--							</div>-->
<!--						</section>-->
						`
						break;
				 
				  case Templates.DETAIL_QNA:		
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
							      <!-- Edit Mode for Reply Content (hidden by default) -->
							      <div id="replyEditMode" class="d-none">
							        <textarea id="replyInput" class="form-control fs-5" style="height: 207px;" rows="30"  placeholder="답변을 작성해주세요"></textarea>
							      </div>
							    </div>
							  </div>
							  <!-- Button Row: 뒤로가기 and 작성하기/완료 -->
							  <div class="d-flex justify-content-center mt-3">
							    <button id="backBtn" class="btn btn-secondary me-3">뒤로가기</button>
							    <button id="editBtn" class="btn btn-primary">작성하기</button>
							  </div>
							</section>
								`
							break;
				 //게시글 등록시 사용할 UI탬플릿
				  case "new":
					  template = `
						  <section class="card">
						  <div class="card-body">
						    <!-- Heading for the form -->
						    <h4 class="card-title mb-4">게시글 등록</h4>
						    
						    <!-- 상단글 Checkbox Inline: label before checkbox -->
						    <div class="d-flex align-items-center mb-3">
						      <span class="fs-6 me-2 ">상단글</span>
						      <input type="checkbox"  id="topPostCheckbox" class="form-check-input" style="width: 25px; height: 25px;">
						    </div>
						    
						    <!-- Form for creating a post -->

                            <form id="postForm" enctype="multipart/form-data" method="post">
                              <input id="postState" type="hidden" name="postState" value="" />
                              <div class="mb-3">
                                <label for="postTitle" class="form-label">제목</label>
                                <input type="text" name="postTitle" " class="form-control" id="postTitle" placeholder="제목을 입력해주세요." required>
                              </div>

                              <div class="mb-3">
                                <label for="postText" class="form-label">내용</label>
                                <textarea class="form-control" name="postText"   id="postText" style="height: 207px;" rows="30" placeholder="내용을 입력해주세요." required></textarea>
                              </div>

                              <!--  File Upload Input -->
                              <div class="mb-3">
                                <label for="postFiles" class="form-label">파일 업로드</label>
                                <input class="form-control" type="file" id="postFiles" name="files" multiple>
                              </div>

                              <div class="d-flex justify-content-center mt-3">
                                <button id="backBtn" class="btn btn-secondary me-3">취소</button>
                                <button id="submitBtn" type="submit" class="btn btn-primary">등록</button>
                              </div>
                            </form>
						`
					  break;
					default:
						throw new Error(TemplateType + "은 지원되지 않는 탬플릿 타입입니다.");
			}

			
			templateContainer.innerHTML = template;
		}
		});
	</script>
  </head>

  <body>
    <jsp:include page="common/header.jsp"></jsp:include>
    <main class="container-fluid p-5">
      <h1 class="fw-bold">관리자 <span class="fst-italic">메뉴</span></h1>
      <div class="row mt-4">
        <!-- Sidebar -->
        <aside class="col-md-3">
          <div class="bg-white p-3 rounded border shadow-sm">
            <nav class="nav flex-column text-center" id="menu">
            
              <a href="#" class="nav-link text-dark fw-bold" data-category="notice"
                >공지</a
              >
              <a href="#" class="nav-link text-dark fw-bold" data-category="event"
                >이벤트</a
              >
			<a href="#" class="nav-link text-dark fw-bold" data-category="qna"
                >문의</a
              >
            </nav>
          </div>
        </aside>
        <!-- Main Table Content -->
        <main class="col-md-9 d-flex flex-column vh-100" id="main">
        <!--  
       1.  여기에 게시판의 리스트 형식을 표시할수있는 list template ,
       2.  이벤트, 공지 게시판 상세글을 표시할수있는 detail Template ,
       3.  문의 게시판 상세글을 표시할수있는 detailqna template,
       4.  게시글 등록 버튼을 눌렀을때 등록할수있는 양식 보여줄수있는 new template
       위 4가지중 하나의 탬플릿이 이부분에서 만들어집니다
        -->
        
         <!--TODO: 등록중에 주기적으로 세션에 임시저장했다가 새로고침하거나 되돌아왔을때 세션에있는 데이터가 있으면 보여주는 기능 추가해보기  -->
        </main>
      </div>
    </main>
   <jsp:include page="common/footer.jsp"></jsp:include>
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
    <!-- JS Script -->
   <jsp:include page="commonJs.jsp"></jsp:include>
  </body>
</html>
