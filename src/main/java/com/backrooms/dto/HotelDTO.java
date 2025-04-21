package com.backrooms.dto;

import org.apache.ibatis.type.Alias;

@Alias("HotelDTO")
public class HotelDTO {
	private int hotelNum;
	private String hotelName;
	private double hotelRating;
	private int hotelGrade;
	private String hotelAddress;
	private String hotelCity;
	private String latitude;
	private String longitude;
	private int breakfastPrice;

	public HotelDTO() {}
	
	public HotelDTO(int hotelNum, String hotelName, int hotelRating, int hotelGrade, String hotelAddress, String hotelCity,
			String latitude, String longitude, int breakfastPrice) {
		super();
		this.hotelNum = hotelNum;
		this.hotelName = hotelName;
		this.hotelRating = hotelRating;
		this.hotelGrade = hotelGrade;
		this.hotelAddress = hotelAddress;
		this.hotelCity = hotelCity;
		this.latitude = latitude;
		this.longitude = longitude;
		this.breakfastPrice = breakfastPrice;
	}
	
	public int getHotelNum() {
		return hotelNum;
	}
	
	public void setHotelNum(int hotelNum) {
		this.hotelNum = hotelNum;
	}
	
	public String getHotelName() {
		return hotelName;
	}
	
	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}
	
	public double getHotelRating() {
		return hotelRating;
	}
	
	public void setHotelRating(double hotelRating) {
		this.hotelRating = hotelRating;
	}
	
	public int getHotelGrade() {
		return hotelGrade;
	}
	
	public void setHotelGrade(int hotelGrade) {
		this.hotelGrade = hotelGrade;
	}
	
	public String getHotelAddress() {
		return hotelAddress;
	}
	
	public void setHotelAddress(String hotelAddress) {
		this.hotelAddress = hotelAddress;
	}
	
	public String getHotelCity() {
		return hotelCity;
	}
	
	public void setHotelCity(String hotelCity) {
		this.hotelCity = hotelCity;
	}
	
	public String getLatitude() {
		return latitude;
	}
	
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	
	public String getLongitude() {
		return longitude;
	}
	
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	
	public int getBreakfastPrice() {
		return breakfastPrice;
	}
	
	public void setBreakfastPrice(int breakfastprice) {
		this.breakfastPrice = breakfastprice;
	}
}
