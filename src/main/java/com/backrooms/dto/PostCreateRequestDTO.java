package com.backrooms.dto;

//이벤트, 공지사항 게시글 등록시 사용되는 dto입니다
public class PostCreateRequestDTO {
	private String postTitle;
	private String postText;
	private int postState; //9: top, 0: normal
	public PostCreateRequestDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PostCreateRequestDTO(String postTitle, String postText, int postState) {
		super();
		this.postTitle = postTitle;
		this.postText = postText;
		this.postState = postState;
	}
	public String getPostTitle() {
		return postTitle;
	}
	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}
	public String getPostText() {
		return postText;
	}
	public void setPostText(String postText) {
		this.postText = postText;
	}
	public int getPostState() {
		return postState;
	}
	public void setPostState(int postState) {
		this.postState = postState;
	}
	@Override
	public String toString() {
		return "NewPostDTO [postTitle=" + postTitle + ", postText=" + postText + ", postState=" + postState + "]";
	}
	
	
	

}
