package com.gsitm.mbms.util;

import com.gsitm.mbms.approval.ApprovalDTO;
import com.gsitm.mbms.reserve.ReserveHistoryDTO;
import com.gsitm.mbms.room.RoomDTO;

public interface MailService {
	public void send(String subject, String to, ApprovalDTO reserve, String comment);
	public void send(String subject, String to, ReserveHistoryDTO reserveHistory, RoomDTO roomDTO, String comment);
	public String getMailTemplate(ReserveHistoryDTO reserveHistory, RoomDTO roomDTO, String comment);
	public String getMailTemplate(ApprovalDTO reserve, String comment);
	
	/** 예약 시작 30분전 메일알림 **/
	public boolean reservedMailSend();
}
