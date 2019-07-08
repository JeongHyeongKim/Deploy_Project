package com.gsitm.meeting.vo;

import java.util.Date;

public class Notice {
	
	private int noticeId;
	private String noticeTitle;
	private String noticeContent;
	private String noticeWriter;
	private Date noticeDate;
	
	public int getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public String getNoticeWriter() {
		return noticeWriter;
	}
	public void setNoticeWriter(String noticeWriter) {
		this.noticeWriter = noticeWriter;
	}
	public Date getNoticeDate() {
		return noticeDate;
	}
	public void setNoticeDate(Date noticeDate) {
		this.noticeDate = noticeDate;
	}
	
	public Notice(int noticeId, String noticeTitle, String noticeContent, String noticeWriter, Date noticeDate) {
		super();
		this.noticeId = noticeId;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticeWriter = noticeWriter;
		this.noticeDate = noticeDate;
	}
	public Notice() {
		super();
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Notice [noticeId=");
		builder.append(noticeId);
		builder.append(", noticeTitle=");
		builder.append(noticeTitle);
		builder.append(", noticeContent=");
		builder.append(noticeContent);
		builder.append(", noticeWriter=");
		builder.append(noticeWriter);
		builder.append(", noticeDate=");
		builder.append(noticeDate);
		builder.append("]");
		return builder.toString();
	}
	
}
