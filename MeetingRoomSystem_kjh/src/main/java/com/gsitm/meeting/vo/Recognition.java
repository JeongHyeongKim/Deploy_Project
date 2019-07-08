package com.gsitm.meeting.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Recognition {
	
	private String recId;
	private String deptHeadId;
	private String manId;
	private String recAcceptDate;
	private String resId;
	private String recRefuse;
	
	public Recognition(String recId, String resId) {
		super();
		this.recId = recId;
		this.resId = resId;
	}
	
}
