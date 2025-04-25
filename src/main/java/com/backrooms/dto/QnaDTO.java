package com.backrooms.dto;

public class QnaDTO {

	int qnaNum;
	String memberName;
	int memberNum;
	String qnaDate;
	String qnaTitle;
	String qnaText;
	int qnaState;
	String qnaReply;
	public QnaDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public QnaDTO(int qnaNum, String memberName, int memberNum, String qnaDate, String qnaTitle, String qnaText,
			int qnaState, String qnaReply) {
		super();
		this.qnaNum = qnaNum;
		this.memberName = memberName;
		this.memberNum = memberNum;
		this.qnaDate = qnaDate;
		this.qnaTitle = qnaTitle;
		this.qnaText = qnaText;
		this.qnaState = qnaState;
		this.qnaReply = qnaReply;
	}
	public int getQnaNum() {
		return qnaNum;
	}
	public void setQnaNum(int qnaNum) {
		this.qnaNum = qnaNum;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public int getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(int memberNum) {
		this.memberNum = memberNum;
	}
	public String getQnaDate() {
		return qnaDate;
	}
	public void setQnaDate(String qnaDate) {
		this.qnaDate = qnaDate;
	}
	public String getQnaTitle() {
		return qnaTitle;
	}
	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}
	public String getQnaText() {
		return qnaText;
	}
	public void setQnaText(String qnaText) {
		this.qnaText = qnaText;
	}
	public int getQnaState() {
		return qnaState;
	}
	public void setQnaState(int qnaState) {
		this.qnaState = qnaState;
	}
	public String getQnaReply() {
		return qnaReply;
	}
	public void setQnaReply(String qnaReply) {
		this.qnaReply = qnaReply;
	}
	@Override
	public String toString() {
		return "QnaDTO [qnaNum=" + qnaNum + ", memberName=" + memberName + ", memberNum=" + memberNum + ", qnaDate="
				+ qnaDate + ", qnaTitle=" + qnaTitle + ", qnaText=" + qnaText + ", qnaState=" + qnaState + ", qnaReply="
				+ qnaReply + "]";
	}
	
	
	
}
