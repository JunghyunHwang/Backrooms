
  var currentPage = 1;
  var reviewsPerPage = 5;
  var reviews = []; // 리뷰 데이터를 저장할 배열

  // 자식 창에서 데이터를 받아오는 함수
  function addReview(reviewData) {
    reviews.push(reviewData);
    renderReviews();
  }

  // 리뷰 리스트 렌더링
  function renderReviews() {
    var reviewList = document.getElementById("reviewList");
    reviewList.innerHTML = "";

    var startIndex = (currentPage - 1) * reviewsPerPage;
    var endIndex = startIndex + reviewsPerPage;
    var paginatedReviews = reviews.slice(startIndex, endIndex);

    for (var i = 0; i < paginatedReviews.length; i++) {
      var reviewParts = paginatedReviews[i];
      var tr = document.createElement("tr");
      tr.innerHTML = `
        <td>${reviewParts.author}</td>
        <td class="rating">${reviewParts.rating}</td>
        <td class="content">${reviewParts.content}</td>
        <td>${reviewParts.date}</td>
        <td class="image">${reviewParts.imageUrl ? `<img src="${reviewParts.imageUrl}" alt="리뷰 이미지" style="max-width: 100px; border-radius: 5px;">` : ""}</td>
      `;
      reviewList.appendChild(tr);
    }

    document.getElementById("currentPage").textContent = currentPage;
  }

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
    window.open('write_review.html', '리뷰 작성', 'width=500,height=600');
  }