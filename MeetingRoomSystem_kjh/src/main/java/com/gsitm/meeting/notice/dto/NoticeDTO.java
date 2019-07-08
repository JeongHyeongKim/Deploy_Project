package com.gsitm.meeting.notice.dto;

import java.util.Date;

import com.gsitm.meeting.reservation.dto.ReservationDTO;

import lombok.Data;

public class NoticeDTO {
	@Data
	public static class NoticeList{
		private String noticeId;
		private String noticeTitle;
		private String empName;
		private String noticeWriter;
		private String noticeDate;
		private String noticeContent;
	}
	public static class NoticeTest{
		private String noticeId;
		private String noticeTitle;
		private String noticeWriter;
		private String noticeDate;
		public String getNoticeWriter() {
			return noticeWriter;
		}
		public void setNoticeWriter(String noticeWriter) {
			this.noticeWriter = noticeWriter;
		}
		public String getNoticeDate() {
			return noticeDate;
		}
		public void setNoticeDate(String noticeDate) {
			this.noticeDate = noticeDate;
		}
		public String getNoticeContent() {
			return noticeContent;
		}
		public void setNoticeContent(String noticeContent) {
			this.noticeContent = noticeContent;
		}
		private String noticeContent;
		public String getNoticeId() {
			return noticeId;
		}
		public void setNoticeId(String noticeId) {
			this.noticeId = noticeId;
		}
		public String getNoticeTitle() {
			return noticeTitle;
		}
		public void setNoticeTitle(String noticeTitle) {
			this.noticeTitle = noticeTitle;
		}
		public NoticeTest() {
			super();
		}
		public NoticeTest(String noticeId, String noticeTitle) {
			super();
			this.noticeId = noticeId;
			this.noticeTitle = noticeTitle;
		}
		@Override
		public String toString() {
			StringBuilder builder = new StringBuilder();
			builder.append("NoticeTest [noticeId=");
			builder.append(noticeId);
			builder.append(", noticeTitle=");
			builder.append(noticeTitle);
			builder.append("]");
			return builder.toString();
		}
		
	}
}
