<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <select id="trs_location" name="location">
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
                name="checkin"
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
                name="checkout"
              />
              <span class="input-group-append">
                <i class="fa-solid fa-calendar-days"></i>
              </span>
            </div>
          </div>

          <div class="adut_box">
            <label>Adult*</label>
            <select name="adult" id="adult">
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