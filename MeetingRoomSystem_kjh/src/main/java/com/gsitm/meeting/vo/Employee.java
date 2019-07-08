package com.gsitm.meeting.vo;

public class Employee {
	
	private String empId;
	private String empName;
	private String empPwd;
	private String deptId;
	private String brId;
	private String empLevel;
	private String empEnabled;
	private int empFailureCnt;
	private String empEmail;
	
	private String deptName;
	
	public Employee(String empId, String empName, String empPwd, String deptId, String brId, String empLevel,
			String empEnabled, int empFailureCnt, String empEmail, String deptName) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.empPwd = empPwd;
		this.deptId = deptId;
		this.brId = brId;
		this.empLevel = empLevel;
		this.empEnabled = empEnabled;
		this.empFailureCnt = empFailureCnt;
		this.empEmail = empEmail;
		this.deptName = deptName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public Employee() {
		super();
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getEmpPwd() {
		return empPwd;
	}
	public void setEmpPwd(String empPwd) {
		this.empPwd = empPwd;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getBrId() {
		return brId;
	}
	public void setBrId(String brId) {
		this.brId = brId;
	}
	public String getEmpLevel() {
		return empLevel;
	}
	public void setEmpLevel(String empLevel) {
		this.empLevel = empLevel;
	}
	public String getEmpEnabled() {
		return empEnabled;
	}
	public void setEmpEnabled(String empEnabled) {
		this.empEnabled = empEnabled;
	}
	public int getEmpFailureCnt() {
		return empFailureCnt;
	}
	public void setEmpFailureCnt(int empFailureCnt) {
		this.empFailureCnt = empFailureCnt;
	}
	public String getEmpEmail() {
		return empEmail;
	}
	public void setEmpEmail(String empEmail) {
		this.empEmail = empEmail;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Employee [empId=");
		builder.append(empId);
		builder.append(", empName=");
		builder.append(empName);
		builder.append(", empPwd=");
		builder.append(empPwd);
		builder.append(", deptId=");
		builder.append(deptId);
		builder.append(", brId=");
		builder.append(brId);
		builder.append(", empLevel=");
		builder.append(empLevel);
		builder.append(", empEnabled=");
		builder.append(empEnabled);
		builder.append(", empFailureCnt=");
		builder.append(empFailureCnt);
		builder.append(", empEmail=");
		builder.append(empEmail);
		builder.append(", deptName=");
		builder.append(deptName);
		builder.append("]");
		return builder.toString();
	}

}
