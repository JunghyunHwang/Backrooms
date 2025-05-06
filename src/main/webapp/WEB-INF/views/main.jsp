<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>BackRooms</title>
	<jsp:include page="commonCss.jsp"></jsp:include>   
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  	<script type="text/javascript">
  		$(function(){
  			$("#searchBth").click(function(){
  				$("#searchForm").attr("action","SearchResult").submit()
  			})//end #searchBth click
  			
  			
  		})//end function
  		
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
                <a href="Main">
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

    <!-- Start Header -->
    <jsp:include page="common/header.jsp"></jsp:include>
    <!-- End Header -->

    <!-- Start Slider -->
    <section class="tr_slider_wrap text-center wow fadeInUp">
      <div class="container-fluid">
        <div class="tr_slider">
          <div class="swiper-wrapper">
            <div class="swiper-slide">
              <div
                class="slider_item"
                style="background-image: url(assets/img/slider/travel1.jpg)"
              >
                <div class="container">
                  <span class="subheading animated"
                    >Best Choice for Family</span
                  >
                  <h1 class="heading animated">
                    Embark on Your Next <br />
                    Adventure Today !
                  </h1>
                  <p class="animated">
                    There are many variations of passages of Lorem Ipsum
                    available, but the <br />
                    majority have suffered alteration in some form
                  </p>
                  <a href="#" class="yellow_btn animated"
                    >Explore More <i class="ph ph-arrow-right"></i
                  ></a>
                </div>
              </div>
            </div>
            <!-- End swiper-slide -->

            <div class="swiper-slide">
              <div
                class="slider_item"
                style="background-image: url(assets/img/slider/travel2.jpg)"
              >
                <div class="container">
                  <span class="subheading animated"
                    >The Perfect Choice for Family</span
                  >
                  <h1 class="heading animated">
                    Begin Your Next <br />
                    Adventure Today !
                  </h1>
                  <p class="animated">
                    There are many variations of passages of Lorem Ipsum
                    available, but the <br />
                    majority have suffered alteration in some form
                  </p>
                  <a href="#" class="yellow_btn animated"
                    >Explore More <i class="ph ph-arrow-right"></i
                  ></a>
                </div>
              </div>
            </div>
            <!-- End swiper-slide -->
          </div>

          <div class="hs_prev_arrow harrow">
            <i class="ph ph-caret-left"></i>
          </div>
          <div class="hs_next_arrow harrow">
            <i class="ph ph-caret-right"></i>
          </div>
        </div>
      </div>
    </section>
    <!-- End Slider -->

    <!-- Start Searh filter -->
    <div class="container">
      <div class="row">
        <div class="col-xl-10 col-lg-12 col-md-10 col-10 mx-auto text-center">
          <div class="tr_search_filter">
            <form
              action="#"
              class="d-flex justify-content-center"
              method="post"
              id="searchForm"
            >
              <div class="tr_search_location">
                <label for="trs_location">Location*</label>
                <select id="trs_location" name="hotelCity">
                  <option>서울</option>
                  <option>베이징</option>
                  <option>도쿄</option>
                  <option>마닐라</option>
                  <option>하노이</option>
                  <option>방콕</option>
                  <option>뉴델리</option>
                  <option>카이로</option>
                  <option>런던</option>
                  <option>파리</option>
                  <option>베를린</option>
                  <option>바르셀로나</option>
                  <option>로마</option>
                  <option>호놀룰루</option>
                  <option>뉴욕</option>
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
    </div>
    <!-- End Searh filter -->

    <!-- Start Tour Category -->
    <section class="travel_category pb100 wow fadeInUp">
      <div class="container">
        <div class="row">
          <div class="col-12">
            <div class="section-heading">
              <span>Popular Destination</span>
              <h2>Trendy Travel Locations</h2>
            </div>
          </div>

          <div class="col-12">
            <div class="trcategory_slider owl-carousel">
              <div class="category_item text-center">
                <a href="#">
                  <div class="tcat_image_wrap">
                    <div
                      class="tcat_img"
                      style="background-image: url(assets/dummy/China.jpg)"
                    >
                      <i class="ph ph-arrow-square-out"></i>
                    </div>
                  </div>
                  <h4>China</h4>
                  <span>200 Places</span>
                </a>
              </div>

              <div class="category_item text-center">
                <a href="#">
                  <div class="tcat_image_wrap">
                    <div
                      class="tcat_img"
                      style="background-image: url(assets/dummy/India.jpg)"
                    >
                      <i class="ph ph-arrow-square-out"></i>
                    </div>
                  </div>
                  <h4>India</h4>
                  <span>150 Places</span>
                </a>
              </div>

              <div class="category_item text-center">
                <a href="#">
                  <div class="tcat_image_wrap">
                    <div
                      class="tcat_img"
                      style="background-image: url(assets/dummy/Italia.jpg)"
                    >
                      <i class="ph ph-arrow-square-out"></i>
                    </div>
                  </div>
                  <h4>Italia</h4>
                  <span>220 Places</span>
                </a>
              </div>

              <div class="category_item text-center">
                <a href="#">
                  <div class="tcat_image_wrap">
                    <div
                      class="tcat_img"
                      style="background-image: url(assets/dummy/ThaiLand.jpg)"
                    >
                      <i class="ph ph-arrow-square-out"></i>
                    </div>
                  </div>
                  <h4>ThaiLand</h4>
                  <span>150 Places</span>
                </a>
              </div>

              <div class="category_item text-center">
                <a href="#">
                  <div class="tcat_image_wrap">
                    <div
                      class="tcat_img"
                      style="background-image: url(assets/dummy/France.jpg)"
                    >
                      <i class="ph ph-arrow-square-out"></i>
                    </div>
                  </div>
                  <h4>France</h4>
                  <span>160 Places</span>
                </a>
              </div>

              <div class="category_item text-center">
                <a href="#">
                  <div class="tcat_image_wrap">
                    <div
                      class="tcat_img"
                      style="background-image: url(assets/dummy/USA.jpg)"
                    >
                      <i class="ph ph-arrow-square-out"></i>
                    </div>
                  </div>
                  <h4>USA</h4>
                  <span>225 Places</span>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- End Tour Category -->

<jsp:include page="common/footer.jsp"></jsp:include>
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
    <!-- JS Script -->
   
    <script>
      // START Recomanded
      var mixproduct = mixitup(".tour_items");
      // END Recomanded

      jQuery("select").niceSelect();
    </script>
  </body>
</html>
