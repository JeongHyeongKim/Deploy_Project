package com.gsitm.meeting.reservation.dto;

import lombok.Data;

public class ReservationDTO {
	
	@Data
	public static class mySchedule{
		private String resId;
		private String mrName;
		private String brName;
		private String resState;
		private String resStartDate;
		private String resEndDate;
		private String resDate;
	}
	
	@Data
	public static class ReservationTest{
		private String resId;
		private String empId;
		private String mrId;
		private String deptId;
		private String deptName;
		private String resStartDate;
		private String resEndDate;
		private String resDate;
		private String resPurpose;
		private int resAttendCnt;
		private String resAddRequest;
		private String resState;
		private int resSnack;
		private String resType;
		private String resCancle;
		private int resCost;
		private int resOutside;
		private String empEmail;
		private String headEmail;
		
		
		//예약자 이름
		private String empName;
		//예약정보 중 회의실 이름
		private String mrName;
		//지사
		private String brName;
	}
	
}
