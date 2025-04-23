package com.backrooms.dto;

import org.apache.ibatis.type.Alias;

@Alias("ReviewDTO")
public class ReviewDTO {
	private int reviewNum;
	private int memberNum;
	private int roomNum;
	private int hotelNum;
	private String memberName;
	private String reviewDate;
	private String reviewTitle;
	private String reviewText;
	private int starRating;
	private int reviewState;
	public ReviewDTO() {
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "ReviewDTO [reviewNum=" + reviewNum + ", memberNum=" + memberNum + ", roomNum=" + roomNum + ", hotelNum="
				+ hotelNum + ", memberName=" + memberName + ", reviewDate=" + reviewDate + ", reviewTitle="
				+ reviewTitle + ", reviewText=" + reviewText + ", starRating=" + starRating + ", reviewState="
				+ reviewState + "]";
	}
	public int getReviewNum() {
		return reviewNum;
	}
	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}
	public int getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(int memberNum) {
		this.memberNum = memberNum;
	}
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}
	public int getHotelNum() {
		return hotelNum;
	}
	public void setHotelNum(int hotelNum) {
		this.hotelNum = hotelNum;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(String reviewDate) {
		this.reviewDate = reviewDate;
	}
	public String getReviewTitle() {
		return reviewTitle;
	}
	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}
	public String getReviewText() {
		return reviewText;
	}
	public void setReviewText(String reviewText) {
		this.reviewText = reviewText;
	}
	public int getStarRating() {
		return starRating;
	}
	public void setStarRating(int starRating) {
		this.starRating = starRating;
	}
	public int getReviewState() {
		return reviewState;
	}
	public void setReviewState(int reviewState) {
		this.reviewState = reviewState;
	}
	public ReviewDTO(int reviewNum, int memberNum, int roomNum, int hotelNum, String memberName, String reviewDate,
			String reviewTitle, String reviewText, int starRating, int reviewState) {
		super();
		this.reviewNum = reviewNum;
		this.memberNum = memberNum;
		this.roomNum = roomNum;
		this.hotelNum = hotelNum;
		this.memberName = memberName;
		this.reviewDate = reviewDate;
		this.reviewTitle = reviewTitle;
		this.reviewText = reviewText;
		this.starRating = starRating;
		this.reviewState = reviewState;
	}
	
	
		
}
