package com.backrooms.dto;
public class MemberDTO {
	 
	private int memberNum;
	private String memberId;
	private String passwd;
	private String email;
	private String memberName;
	private String birth;
	private String phone;
	private String post;
	private String address1;
	private String address2;
	private String image;
	/// 역할 번호.
	/// 0 : 탈퇴 회원
	/// 1 : 일반 회원
	/// 9 : 관리자
	private int role;
	
	public MemberDTO(String memberId, String passwd, String email, String memberName, String birth, String phone,
			String post, String address1, String address2, String image, int role) {
		super();
		this.memberId = memberId;
		this.passwd = passwd;
		this.email = email;
		this.memberName = memberName;
		this.birth = birth;
		this.phone = phone;
		this.post = post;
		this.address1 = address1;
		this.address2 = address2;
		this.image = image;
		this.role = role;
	}
	public MemberDTO(String memberId, String passwd, String email, String memberName, String birth, String phone)
	{
		super();
		this.memberId = memberId;
		this.passwd = passwd;
		this.email = email;
		this.memberName = memberName;
		this.birth = birth;
		this.phone = phone;
		this.role = 1;
	}
	public int getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(int memberNum) {
		this.memberNum = memberNum;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getBirth() {
	    var b = birth.split(" ");
		return b[0];
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getRole() {
		return role;
	}
	public void setRole(int role) {
		this.role = role;
	}
	public MemberDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "MemberDTO [memberId=" + memberId + ", passwd=" + passwd + ", email=" + email + ", memberName="
				+ memberName + ", birth=" + birth + ", phone=" + phone + ", post=" + post + ", address1=" + address1
				+ ", address2=" + address2 + ", image=" + image + ", role=" + role + "]";
	}
	
}
