package com.gsitm.meeting.branch.dto;

import com.gsitm.meeting.reservation.dto.ReservationDTO;

import lombok.Data;

public class DepartmentDTO {
	private String deptId;
	private String deptName;
	private int deptCost;
	private String brId;
	//결재관리 : 지사위치
	private String brName;
	@Data
	public static class DepartmentTest{
		private String deptId;
		private String deptName;
		private int deptCost;
		private String brName;
	}
	
	public DepartmentDTO() {
		super();
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public int getDeptCost() {
		return deptCost;
	}
	public void setDeptCose(int deptCost) {
		this.deptCost = deptCost;
	}
	public String getBrId() {
		return brId;
	}
	public void setBrId(String brId) {
		this.brId = brId;
	}
	
	

}
