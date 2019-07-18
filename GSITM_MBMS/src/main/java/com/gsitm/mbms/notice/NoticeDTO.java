package com.gsitm.mbms.notice;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @주제 :
 * @작성일 : 2019. 5. 16.
 * @작성자 : 송민기
 */

@Data
@AllArgsConstructor
@NoArgsConstructor

public class NoticeDTO {
	private String noticeNo;
	private String noticeSubject;
	private String noticeContent;
	private String writerEmpNo;
	private String noticeDate;
	
	private String writerEmpName;
	private String writerEmpPosition;

	public NoticeDTO(String noticeNo, String noticeSubject, String noticeContent, String writerEmpNo,
			String noticeDate) {
		super();
		this.noticeNo = noticeNo;
		this.noticeSubject = noticeSubject;
		this.noticeContent = noticeContent;
		this.writerEmpNo = writerEmpNo;
		this.noticeDate = noticeDate;
	}
}
