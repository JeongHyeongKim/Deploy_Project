package com.gsitm.meeting.vo;

public class MeetingRoom {
	
	private String mrId;
	private String mrName;
	private String brId;
	private int mrLimit;
	private int mrPrice;
	private int mrArea;
	private String mrNetwork;
	private String mrType;
	private String empId;
	private String mrLocation;
	private String mrImg;

	public MeetingRoom() {
		super();
	}
	

	public MeetingRoom(String mrId, String mrName, String brId, int mrLimit, int mrPrice, int mrArea, String mrNetwork,
			String mrType, String empId, String mrLocation, String mrImg) {
		super();
		this.mrId = mrId;
		this.mrName = mrName;
		this.brId = brId;
		this.mrLimit = mrLimit;
		this.mrPrice = mrPrice;
		this.mrArea = mrArea;
		this.mrNetwork = mrNetwork;
		this.mrType = mrType;
		this.empId = empId;
		this.mrLocation = mrLocation;
		this.mrImg = mrImg;
	}


	public String getMrId() {
		return mrId;
	}


	public void setMrId(String mrId) {
		this.mrId = mrId;
	}


	public String getMrName() {
		return mrName;
	}


	public void setMrName(String mrName) {
		this.mrName = mrName;
	}


	public String getBrId() {
		return brId;
	}


	public void setBrId(String brId) {
		this.brId = brId;
	}


	public int getMrLimit() {
		return mrLimit;
	}


	public void setMrLimit(int mrLimit) {
		this.mrLimit = mrLimit;
	}


	public int getMrPrice() {
		return mrPrice;
	}


	public void setMrPrice(int mrPrice) {
		this.mrPrice = mrPrice;
	}


	public int getMrArea() {
		return mrArea;
	}


	public void setMrArea(int mrArea) {
		this.mrArea = mrArea;
	}


	public String getMrNetwork() {
		return mrNetwork;
	}


	public void setMrNetwork(String mrNetwork) {
		this.mrNetwork = mrNetwork;
	}


	public String getMrType() {
		return mrType;
	}


	public void setMrType(String mrType) {
		this.mrType = mrType;
	}


	public String getEmpId() {
		return empId;
	}


	public void setEmpId(String empId) {
		this.empId = empId;
	}


	public String getMrLocation() {
		return mrLocation;
	}


	public void setMrLocation(String mrLocation) {
		this.mrLocation = mrLocation;
	}


	public String getMrImg() {
		return mrImg;
	}


	public void setMrImg(String mrImg) {
		this.mrImg = mrImg;
	}


	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("MeetingRoom [mrId=");
		builder.append(mrId);
		builder.append(", mrName=");
		builder.append(mrName);
		builder.append(", brId=");
		builder.append(brId);
		builder.append(", mrLimit=");
		builder.append(mrLimit);
		builder.append(", mrPrice=");
		builder.append(mrPrice);
		builder.append(", mrArea=");
		builder.append(mrArea);
		builder.append(", mrNetwork=");
		builder.append(mrNetwork);
		builder.append(", mrType=");
		builder.append(mrType);
		builder.append(", empId=");
		builder.append(empId);
		builder.append(", mrLocation=");
		builder.append(mrLocation);
		builder.append(", mrImg=");
		builder.append(mrImg);
		builder.append("]");
		return builder.toString();
	}
	
	

}
