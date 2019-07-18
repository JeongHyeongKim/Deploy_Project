package com.gsitm.mbms.payment;

import java.sql.Date;

import lombok.Data;

@Data
public class PaymentDTO {
	private int reserveNo;
	private int roomNo;
	private String reserveEmpNo;
	private Date startDate;
	private Date endDate;
	private int approval1Yn; 
	private String approval1EmpNo;
	private Date approval1Date;
	private int approval2Yn; 
	private String approval2EmpNo;
	private Date approval2Date;
	private int paymentYn;
	private Date paymentDate;
	private Date reserveDate;
	private int reservePrice;
	private String purpose;
	private String category;
	private int priority;
	private int empCount;
	private char snackYn;
	private String empName;
	private String deptName;
	private String empNo; 
	
	private String mgrEmpNo;
	public int cost;
	private String title;


	public PaymentDTO() {
		super();
	}
	
	public PaymentDTO(int reserveNo, int roomNo, String reserveEmpNo, Date startDate, Date endDate,
			int approval1Yn, String approval1EmpNo, Date approval1Date, int approval2Yn, String approval2EmpNo,
			Date approval2Date, int paymentYn, Date paymentDate, Date reserveDate, int reservePrice, String purpose,
			String category, int priority, int empCount, char snackYn, String empName, String deptName, String empNo,
			String mgrEmpNo, int cost, String title) {
		super();
		this.reserveNo = reserveNo;
		this.roomNo = roomNo;
		this.reserveEmpNo = reserveEmpNo;
		this.startDate = startDate;
		this.endDate = endDate;
		this.approval1Yn = approval1Yn;
		this.approval1EmpNo = approval1EmpNo;
		this.approval1Date = approval1Date;
		this.approval2Yn = approval2Yn;
		this.approval2EmpNo = approval2EmpNo;
		this.approval2Date = approval2Date;
		this.paymentYn = paymentYn;
		this.paymentDate = paymentDate;
		this.reserveDate = reserveDate;
		this.reservePrice = reservePrice;
		this.purpose = purpose;
		this.category = category;
		this.priority = priority;
		this.empCount = empCount;
		this.snackYn = snackYn;
		this.empName = empName;
		this.deptName = deptName;
		this.empNo = empNo;
		this.mgrEmpNo = mgrEmpNo;
		this.cost = cost;
		this.title = title;
	}

	public int getReserveNo() {
		return reserveNo;
	}
	public void setReserveNo(int reserveNo) {
		this.reserveNo = reserveNo;
	}
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public String getReserveEmpNo() {
		return reserveEmpNo;
	}
	public void setReserveEmpNo(String reserveEmpNo) {
		this.reserveEmpNo = reserveEmpNo;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public int getApproval1Yn() {
		return approval1Yn;
	}
	public void setApproval1Yn(int approval1Yn) {
		this.approval1Yn = approval1Yn;
	}
	public String getApproval1EmpNo() {
		return approval1EmpNo;
	}
	public void setApproval1EmpNo(String approval1EmpNo) {
		this.approval1EmpNo = approval1EmpNo;
	}
	public Date getApproval1Date() {
		return approval1Date;
	}
	public void setApproval1Date(Date approval1Date) {
		this.approval1Date = approval1Date;
	}
	public int getApproval2Yn() {
		return approval2Yn;
	}
	public void setApproval2Yn(int approval2Yn) {
		this.approval2Yn = approval2Yn;
	}
	public String getApproval2EmpNo() {
		return approval2EmpNo;
	}
	public void setApproval2EmpNo(String approval2EmpNo) {
		this.approval2EmpNo = approval2EmpNo;
	}
	public Date getApproval2Date() {
		return approval2Date;
	}
	public void setApproval2Date(Date approval2Date) {
		this.approval2Date = approval2Date;
	}
	public int getPaymentYn() {
		return paymentYn;
	}
	public void setPaymentYn(int paymentYn) {
		this.paymentYn = paymentYn;
	}
	public Date getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}
	public Date getReserveDate() {
		return reserveDate;
	}
	public void setReserveDate(Date reserveDate) {
		this.reserveDate = reserveDate;
	}
	public int getReservePrice() {
		return reservePrice;
	}
	public void setReservePrice(int reservePrice) {
		this.reservePrice = reservePrice;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public int getEmpCount() {
		return empCount;
	}
	public void setEmpCount(int empCount) {
		this.empCount = empCount;
	}
	public char getSnackYn() {
		return snackYn;
	}
	public void setSnackYn(char snackYn) {
		this.snackYn = snackYn;
	}
	
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	
	public String getMgrEmpNo() {
		return mgrEmpNo;
	}
	public void setMgrEmpNo(String mgrEmpNo) {
		this.mgrEmpNo = mgrEmpNo;
	}
	
	public int getCost() {
		return cost;
	}
	public void setCost(int cost) {
		this.cost = cost;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	@Override
	public String toString() {
		return "ReserveHistoryDTO [reserveNo=" + reserveNo + ", roomNo=" + roomNo + ", reserveEmpNo=" + reserveEmpNo
				+ ", startDate=" + startDate + ", endDate=" + endDate + ", approval1Yn=" + approval1Yn
				+ ", approval1EmpNo=" + approval1EmpNo + ", approval1Date=" + approval1Date + ", approval2Yn="
				+ approval2Yn + ", approval2EmpNo=" + approval2EmpNo + ", approval2Date=" + approval2Date
				+ ", paymentYn=" + paymentYn + ", paymentDate=" + paymentDate + ", reserveDate=" + reserveDate
				+ ", reservePrice=" + reservePrice + ", purpose=" + purpose + ", category=" + category + ", priority="
				+ priority + ", empCount=" + empCount + ", snackYn=" + snackYn + ", empName=" + empName + ", deptName=" + deptName + 
				", mgrEmpNo=" + mgrEmpNo + ", cost=" + cost + ", title=" + title + "]";
	}
	
}
