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

    <!-- Start searchFilter -->
    <jsp:include page="common/searchFilter.jsp"></jsp:include>
    <!-- End searchFilter -->

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

    <!-- Start About -->
    <section
      class="tr_about"
      style="background-image: url(assets/img/bg/about_bg.jpg)"
    >
      <div class="container">
        <div class="row">
          <div class="col-xl-6 wow fadeInLeft">
            <div class="about_image position-relative">
              <img src="assets/dummy/est.jpg" class="ab_img_1" alt="img" width = "1024" />
              <div class="about_badge">
                <span>Established In</span>
                <h3>2025</h3>
              </div>
              <img
                src="assets/img/about/plane_shape.png"
                alt="img"
                class="about_shape"
              />
            </div>
          </div>
          <!-- End Col -->

          <div class="col-xl-6 align-self-center wow fadeInRight">
            <div class="about_content">
              <div class="section-heading">
                <span>About Our Company</span>
                <h2>
                  Discover Every Corner of The <br />
                  World With Us
                </h2>
              </div>

              <p>
                There are many variations of passages of Lorem Ipsum available,
                but the majority have suffered alteration in some form, by
                injected humour, or randomised words which don't look even
                slightly believable. If you are going to use a passage of Lorem
                Ipsum
              </p>
              <div class="d-flex gap-4 about_btm">
                <a href="#" class="green_btn"
                  >About Info <i class="ph ph-arrow-right"></i
                ></a>
                <div class="phone_number align-self-center">
                  <i class="ph ph-phone-call"></i>
                  <a href="tel:+880325468756">+88032 546 87 56</a>
                </div>
              </div>
            </div>
          </div>
          <!-- End Col -->
        </div>
      </div>
    </section>
    <!-- End About -->

    <!-- Start Counter Up -->
    <section class="counter_up section-padding">
      <div class="container">
        <div class="row">
          <div class="col-xl-3 col-md-6 col-12 wow fadeInUp">
            <div
              class="counter_item"
              style="background-image: url(assets/img/counter-up/1.jpg)"
            >
              <i class="ph ph-smiley"></i>
              <h4><span class="count">85974</span>+</h4>
              <p>Satisfied Clients</p>
            </div>
          </div>
          <!-- End Col -->

          <div class="col-xl-3 col-md-6 col-12 wow fadeInUp">
            <div
              class="counter_item"
              style="background-image: url(assets/img/counter-up/2.jpg)"
            >
              <i class="ph ph-star"></i>
              <h4><span class="count">9875</span>+</h4>
              <p>Positive Review</p>
            </div>
          </div>
          <!-- End Col -->

          <div class="col-xl-3 col-md-6 col-12 wow fadeInUp">
            <div
              class="counter_item"
              style="background-image: url(assets/img/counter-up/3.jpg)"
            >
              <i class="ph ph-heart"></i>
              <h4><span class="count">5647</span>+</h4>
              <p>Satisfied Clients</p>
            </div>
          </div>
          <!-- End Col -->

          <div class="col-xl-3 col-md-6 col-12 wow fadeInUp">
            <div
              class="counter_item"
              style="background-image: url(assets/img/counter-up/4.jpg)"
            >
              <i class="ph ph-trophy"></i>
              <h4><span class="count">1200</span>+</h4>
              <p>Wining Awards</p>
            </div>
          </div>
          <!-- End Col -->
        </div>
      </div>
    </section>
    <!-- End Counter Up -->

    <!-- Start Tour Packages -->
    <section class="tour_packages wow fadeInUp">
      <div class="container">
        <div class="row">
          <div class="col-xl-12 text-center wow fadeInUp">
            <div class="section-heading">
              <span>Popular Tour</span>
              <h2>Amazing Tour Places</h2>
            </div>
          </div>
          <!-- End Col -->

          <div class="col-xl-12">
            <ul class="package_nav">
              <li class="filter" data-filter="all">New</li>
              <li class="filter" data-filter=".featured">Featured</li>
              <li class="filter" data-filter=".discount">Discount</li>
              <li class="filter" data-filter=".popular">Popular</li>
            </ul>

            <div class="packages_wrap wow fadeInUp">
              <div class="row tour_items">
                <div class="col-xl-4 col-md-6 col-12 mix new featured">
                  <div class="package_item">
                    <div class="pack_image">
                      <img src="assets/dummy/tour/Busan.jpg" alt="img" />
                      <div class="pac_badge">
                        <span class="feat">Featured</span>
                        <span class="day">5 Days</span>
                      </div>

                      <a href="hotel-details.html" class="tour_btn"
                        ><i class="fa-regular fa-eye"></i
                      ></a>
                    </div>

                    <div class="pack_content">
                      <h3>
                        <a href="hotel-details.html"
                          >Busan</a
                        >
                      </h3>
                      <div class="pac_location d-flex gap-2">
                        <i class="ph ph-map-pin-area align-self-center"></i>
                        <span class="align-self-center">Busan, Korea</span>
                      </div>
                      <div class="pack_btm d-flex">
                        <span class="pack_price"
                          >$245 / <small>Person</small></span
                        >
                        <span class="pack_rating ms-auto align-self-center"
                          ><i class="fa-regular fa-star"></i> 4.8</span
                        >
                      </div>
                    </div>
                  </div>
                </div>
                <!-- End Col -->

                <div class="col-xl-4 col-md-6 col-12 mix new discount">
                  <div class="package_item">
                    <div class="pack_image">
                      <img src="assets/dummy/tour/Chiangmai.jpg" alt="img" />
                      <div class="pac_badge">
                        <span class="feat">30% Off</span>
                        <span class="day">5 Days</span>
                      </div>

                      <a href="hotel-details.html" class="tour_btn"
                        ><i class="fa-regular fa-eye"></i
                      ></a>
                    </div>

                    <div class="pack_content">
                      <h3>
                        <a href="hotel-details.html"
                          >Ciang mai</a
                        >
                      </h3>
                      <div class="pac_location d-flex gap-2">
                        <i class="ph ph-map-pin-area align-self-center"></i>
                        <span class="align-self-center">Chiang mai, Thai</span>
                      </div>
                      <div class="pack_btm d-flex">
                        <span class="pack_price"
                          >$245 / <small>Person</small></span
                        >
                        <span class="pack_rating ms-auto align-self-center"
                          ><i class="fa-regular fa-star"></i> 4.8</span
                        >
                      </div>
                    </div>
                  </div>
                </div>
                <!-- End Col -->

                <div class="col-xl-4 col-md-6 col-12 mix new featured popular">
                  <div class="package_item">
                    <div class="pack_image">
                      <img src="assets/dummy/tour/Hanoi.jpg" alt="img" />
                      <div class="pac_badge">
                        <span class="feat">Featured</span>
                        <span class="day">5 Days</span>
                      </div>

                      <a href="hotel-details.html" class="tour_btn"
                        ><i class="fa-regular fa-eye"></i
                      ></a>
                    </div>

                    <div class="pack_content">
                      <h3>
                        <a href="tour-details.html"
                          >Hanoi</a
                        >
                      </h3>
                      <div class="pac_location d-flex gap-2">
                        <i class="ph ph-map-pin-area align-self-center"></i>
                        <span class="align-self-center">Hanoi, Vietnam</span>
                      </div>
                      <div class="pack_btm d-flex">
                        <span class="pack_price"
                          >$245 / <small>Person</small></span
                        >
                        <span class="pack_rating ms-auto align-self-center"
                          ><i class="fa-regular fa-star"></i> 4.8</span
                        >
                      </div>
                    </div>
                  </div>
                </div>
                <!-- End Col -->

                <div class="col-xl-4 col-md-6 col-12 mix new discount popular">
                  <div class="package_item">
                    <div class="pack_image">
                      <img src="assets/dummy/tour/Meongdong.jpg" alt="img" />
                      <div class="pac_badge">
                        <span class="feat">25% Off</span>
                        <span class="day">5 Days</span>
                      </div>

                      <a href="hotel-details.html" class="tour_btn"
                        ><i class="fa-regular fa-eye"></i
                      ></a>
                    </div>

                    <div class="pack_content">
                      <h3>
                        <a href="hotel-details.html"
                          >Myeong dong</a
                        >
                      </h3>
                      <div class="pac_location d-flex gap-2">
                        <i class="ph ph-map-pin-area align-self-center"></i>
                        <span class="align-self-center">Seoul, Korea</span>
                      </div>
                      <div class="pack_btm d-flex">
                        <span class="pack_price"
                          >$245 / <small>Person</small></span
                        >
                        <span class="pack_rating ms-auto align-self-center"
                          ><i class="fa-regular fa-star"></i> 4.8</span
                        >
                      </div>
                    </div>
                  </div>
                </div>
                <!-- End Col -->

                <div class="col-xl-4 col-md-6 col-12 mix new discount popular">
                  <div class="package_item">
                    <div class="pack_image">
                      <img src="assets/dummy/tour/Tokyo.jpg" alt="img" />
                      <div class="pac_badge">
                        <span class="feat">20% Off</span>
                        <span class="day">5 Days</span>
                      </div>

                      <a href="hotel-details.html" class="tour_btn"
                        ><i class="fa-regular fa-eye"></i
                      ></a>
                    </div>

                    <div class="pack_content">
                      <h3>
                        <a href="hotel-details.html"
                          >Tokyo</a
                        >
                      </h3>
                      <div class="pac_location d-flex gap-2">
                        <i class="ph ph-map-pin-area align-self-center"></i>
                        <span class="align-self-center">Tokyo, Japan</span>
                      </div>
                      <div class="pack_btm d-flex">
                        <span class="pack_price"
                          >$245 / <small>Person</small></span
                        >
                        <span class="pack_rating ms-auto align-self-center"
                          ><i class="fa-regular fa-star"></i> 4.8</span
                        >
                      </div>
                    </div>
                  </div>
                </div>
                <!-- End Col -->

                <div class="col-xl-4 col-md-6 col-12 mix new popular featured">
                  <div class="package_item">
                    <div class="pack_image">
                      <img src="assets/dummy/tour/Sokcho.jpg" alt="img" />
                      <div class="pac_badge">
                        <span class="feat">Featured</span>
                        <span class="day">5 Days</span>
                      </div>

                      <a href="hotel-details.html" class="tour_btn"
                        ><i class="fa-regular fa-eye"></i
                      ></a>
                    </div>

                    <div class="pack_content">
                      <h3>
                        <a href="tour-details.html"
                          >Sokcho</a
                        >
                      </h3>
                      <div class="pac_location d-flex gap-2">
                        <i class="ph ph-map-pin-area align-self-center"></i>
                        <span class="align-self-center">Sokcho, Korea</span>
                      </div>
                      <div class="pack_btm d-flex">
                        <span class="pack_price"
                          >$245 / <small>Person</small></span
                        >
                        <span class="pack_rating ms-auto align-self-center"
                          ><i class="fa-regular fa-star"></i> 4.8</span
                        >
                      </div>
                    </div>
                  </div>
                </div>
                <!-- End Col -->
              </div>
            </div>

            <div class="text-center mt-4 wow fadeInUp">
              <a href="tour.html" class="green_btn"
                >Explore More <i class="ph ph-arrow-right"></i
              ></a>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- End Tour Packages -->

    <!-- Start Clients -->
    <div class="tr_clients wow fadeInUp">
      <div class="container-fluid">
        <div class="clients_slider owl-carousel">
          <div class="client_item">
            <a href="hotel-details.html"><img src="assets/dummy/clients/1.jpg" alt="img" /></a>
          </div>

          <div class="client_item">
            <a href="hotel-details.html"><img src="assets/dummy/clients/2.jpg" alt="img" /></a>
          </div>

          <div class="client_item">
            <a href="hotel-details.html"><img src="assets/dummy/clients/3.jpg" alt="img" /></a>
          </div>

          <div class="client_item">
            <a href="hotel-details.html"><img src="assets/dummy/clients/4.jpg" alt="img" /></a>
          </div>

          <div class="client_item">
            <a href="hotel-details.html"><img src="assets/dummy/clients/5.jpg" alt="img" /></a>
          </div>

          <div class="client_item">
            <a href="hotel-details.html"><img src="assets/dummy/clients/6.jpg" alt="img" /></a>
          </div>

          <div class="client_item">
            <a href="hotel-details.html"><img src="assets/dummy/clients/7.jpg" alt="img" /></a>
          </div>
        </div>
      </div>
    </div>
    <!-- End Clients -->

    <!-- Start Testimonials -->
    <section
      class="testimonials"
      style="background-image: url(assets/img/bg/rev_bg.png)"
    >
      <div class="container">
        <div class="row">
          <div class="col-lg-6 wow fadeInLeft">
            <div class="testimonials_image">
              <div class="row">
                <div class="col-sm-6 text-center">
                  <img
                    src="assets/dummy/clients/1.jpg"
                    class="test_image1"
                    alt="img"
                  />
                  <img
                    src="assets/dummy/clients/2.jpg"
                    class="test_image3"
                    alt="img"
                  />
                </div>

                <div class="col-sm-6 align-self-center text-center">
                  <img
                    src="assets/dummy/clients/3.jpg"
                    class="test_image2"
                    alt="img"
                  />
                  <div class="test_arrow">
                    <span class="tarrow_left"
                      ><i class="ph ph-arrow-left"></i
                    ></span>
                    <span class="tarrow_right"
                      ><i class="ph ph-arrow-right"></i
                    ></span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- End Col -->

          <div class="col-lg-6 align-self-center overflow wow fadeInRight">
            <div class="section-heading mb-40 position-relative">
              <span>Testimonials</span>
              <h2>Our Valuable Customer Says</h2>
              <hr />
              <img src="assets/img/icons/quote.svg" class="test_quote" alt="" />
            </div>

            <div class="test_slider">
              <div class="swiper-wrapper">
                <div class="swiper-slide">
                  <div class="testimonials_item">
                    <div class="test_rating">
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                    </div>

                    <p>
                      “ Contrary to popular belief, Lorem Ipsum is not simply
                      random text. It has roots in a piece of classical Latin
                      literature from 45 BC, making it over 2000 years old ”
                    </p>
                    <h4>Masum Billah</h4>
                    <span class="designation">CEO of ABC LTD</span>
                  </div>
                </div>

                <div class="swiper-slide">
                  <div class="testimonials_item">
                    <div class="test_rating">
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                    </div>

                    <p>
                      “ Contrary to popular belief, Lorem Ipsum is not simply
                      random text. It has roots in a piece of classical Latin
                      literature from 45 BC, making it over 2000 years old ”
                    </p>
                    <h4>Muntasir Billah</h4>
                    <span class="designation">CEO of ABC LTD</span>
                  </div>
                </div>

                <div class="swiper-slide">
                  <div class="testimonials_item">
                    <div class="test_rating">
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                    </div>

                    <p>
                      “ Contrary to popular belief, Lorem Ipsum is not simply
                      random text. It has roots in a piece of classical Latin
                      literature from 45 BC, making it over 2000 years old ”
                    </p>
                    <h4>Mutasim Billah</h4>
                    <span class="designation">CEO of ABC LTD</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- End Col -->
        </div>
      </div>
    </section>
    <!-- End Testimonilas -->

    <!-- Start Features -->
    <section class="features section-padding wow fadeInUp">
      <div class="container">
        <div class="row">
          <div class="col-12 wow fadeInUp">
            <div class="section-heading text-center">
              <span>Special Features</span>
              <h2>Our Tour Features</h2>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-xl-3 col-md-6 col-12 wow fadeInUp">
            <div class="feature_item">
              <i class="ph ph-wifi-high"></i>
              <div class="feature_content">
                <h3>Use Free Wifi</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
              </div>
            </div>
          </div>
          <!-- End Col -->

          <div class="col-xl-3 col-md-6 col-12 wow fadeInUp">
            <div class="feature_item">
              <i class="ph ph-shield-plus"></i>
              <div class="feature_content">
                <h3>Special Security</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
              </div>
            </div>
          </div>
          <!-- End Col -->

          <div class="col-xl-3 col-md-6 col-12 wow fadeInUp">
            <div class="feature_item">
              <i class="ph ph-person-simple-swim"></i>
              <div class="feature_content">
                <h3>Swimming & Fishing</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
              </div>
            </div>
          </div>
          <!-- End Col -->

          <div class="col-xl-3 col-md-6 col-12 wow fadeInUp">
            <div class="feature_item">
              <i class="ph ph-barbell"></i>
              <div class="feature_content">
                <h3>Gym Center</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
              </div>
            </div>
          </div>
          <!-- End Col -->

          <div class="col-xl-3 col-md-6 col-12 wow fadeInUp">
            <div class="feature_item">
              <i class="ph ph-bed"></i>
              <div class="feature_content">
                <h3>Luxury Room</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
              </div>
            </div>
          </div>
          <!-- End Col -->

          <div class="col-xl-3 col-md-6 col-12 wow fadeInUp">
            <div class="feature_item">
              <i class="ph ph-tent"></i>
              <div class="feature_content">
                <h3>Night Campaign</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
              </div>
            </div>
          </div>
          <!-- End Col -->

          <div class="col-xl-3 col-md-6 col-12 wow fadeInUp">
            <div class="feature_item">
              <i class="ph ph-person-simple-bike"></i>
              <div class="feature_content">
                <h3>Cycling Trips</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
              </div>
            </div>
          </div>
          <!-- End Col -->

          <div class="col-xl-3 col-md-6 col-12 wow fadeInUp">
            <div class="feature_item">
              <i class="ph ph-solar-panel"></i>
              <div class="feature_content">
                <h3>Solar Energy System</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
              </div>
            </div>
          </div>
          <!-- End Col -->
        </div>
      </div>
    </section>
    <!-- End Features -->
    
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
