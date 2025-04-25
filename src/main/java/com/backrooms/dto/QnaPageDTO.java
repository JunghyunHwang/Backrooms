package com.backrooms.dto;

import java.util.List;

public class QnaPageDTO {
	private List<QnaDTO> qnaList;
	private int curPage;
	private int perPage = 4;
	private int totalCount;
	public QnaPageDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public QnaPageDTO(List<QnaDTO> qnaList, int curPage, int perPage, int totalCount) {
		super();
		this.qnaList = qnaList;
		this.curPage = curPage;
		this.perPage = perPage;
		this.totalCount = totalCount;
	}
	public List<QnaDTO> getQnaList() {
		return qnaList;
	}
	public void setQnaList(List<QnaDTO> qnaList) {
		this.qnaList = qnaList;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	@Override
	public String toString() {
		return "QnaPageDTO [qnaList=" + qnaList + ", curPage=" + curPage + ", perPage=" + perPage + ", totalCount="
				+ totalCount + "]";
	}
	
	
	
}
