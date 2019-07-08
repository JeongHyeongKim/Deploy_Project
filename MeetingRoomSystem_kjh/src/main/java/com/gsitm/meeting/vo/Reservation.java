package com.gsitm.meeting.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reservation {
	
	private String resId;
	private String empId;
	private String mrId;
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
	private int resNW;
	
}
