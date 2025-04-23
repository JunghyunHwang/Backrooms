package com.backrooms.dto;

public class EventDTO {

	 	private int eventNum;
	 	private int memberNum;
	    private String memberName;
	    private String eventDate;
	    private String eventTitle;
	    private String eventText;
	    private int eventState; 
		public EventDTO() {
			super();
			// TODO Auto-generated constructor stub
		}
		public EventDTO(int eventNum, int memberNum, String memberName, String eventDate, String eventTitle,
				String eventText, int eventState) {
			super();
			this.eventNum = eventNum;
			this.memberNum = memberNum;
			this.memberName = memberName;
			this.eventDate = eventDate;
			this.eventTitle = eventTitle;
			this.eventText = eventText;
			this.eventState = eventState;
		}
		public int getEventNum() {
			return eventNum;
		}
		public void setEventNum(int eventNum) {
			this.eventNum = eventNum;
		}
		public int getMemberNum() {
			return memberNum;
		}
		public void setMemberNum(int memberNum) {
			this.memberNum = memberNum;
		}
		public String getMemberName() {
			return memberName;
		}
		public void setMemberName(String memberName) {
			this.memberName = memberName;
		}
		public String getEventDate() {
			return eventDate;
		}
		public void setEventDate(String eventDate) {
			this.eventDate = eventDate;
		}
		public String getEventTitle() {
			return eventTitle;
		}
		public void setEventTitle(String eventTitle) {
			this.eventTitle = eventTitle;
		}
		public String getEventText() {
			return eventText;
		}
		public void setEventText(String eventText) {
			this.eventText = eventText;
		}
		public int getEventState() {
			return eventState;
		}
		public void setEventState(int eventState) {
			this.eventState = eventState;
		}
		@Override
		public String toString() {
			return "EventDTO [eventNum=" + eventNum + ", memberNum=" + memberNum + ", memberName=" + memberName
					+ ", eventDate=" + eventDate + ", eventTitle=" + eventTitle + ", eventText=" + eventText
					+ ", eventState=" + eventState + "]";
		}
	
	    

	    
	    
}
