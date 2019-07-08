package com.gsitm.meeting.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Attendee {
	
	private String resId;
	private String attendId;
	private String attendType;
	private String deptId;
	private int deptCost;
	
}
