package com.backrooms.dto;

// 관리자 페이지에서 이벤트, 공지사항 게시판을 수정을 요청할때 사용되는 dto입니다 
public class PostUpdateRequestDTO {
	private int postNum;
	private String title;
	private String text;
	public PostUpdateRequestDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PostUpdateRequestDTO(int postNum, String title, String text) {
		super();
		this.postNum = postNum;
		this.title = title;
		this.text = text;
	}
	public int getPostNum() {
		return postNum;
	}
	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	@Override
	public String toString() {
		return "PostUpdateRequestDTO [postNum=" + postNum + ", title=" + title + ", text=" + text + "]";
	}
}
