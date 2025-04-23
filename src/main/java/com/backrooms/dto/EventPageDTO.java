package com.backrooms.dto;

import java.util.List;

public class EventPageDTO {
	private List<EventDTO> eventList;
	private int curPage;
	private int perPage = 4;
	private int totalCount;
	public EventPageDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public EventPageDTO(List<EventDTO> eventList, int curPage, int perPage, int totalCount) {
		super();
		this.eventList = eventList;
		this.curPage = curPage;
		this.perPage = perPage;
		this.totalCount = totalCount;
	}
	public List<EventDTO> getEventList() {
		return eventList;
	}
	public void setEventList(List<EventDTO> eventList) {
		this.eventList = eventList;
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
		return "EventPageDTO [eventList=" + eventList + ", curPage=" + curPage + ", perPage=" + perPage
				+ ", totalCount=" + totalCount + "]";
	}
	
	
}
