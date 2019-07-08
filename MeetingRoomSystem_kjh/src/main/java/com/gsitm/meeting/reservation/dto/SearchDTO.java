package com.gsitm.meeting.reservation.dto;

public class SearchDTO {
	private String brId;
	private String mrType;
	private String mrLimit;
	private String resStartDate;
	
	public String getBrId() {
		return brId;
	}
	public void setBrId(String brId) {
		this.brId = brId;
	}
	public String getMrType() {
		return mrType;
	}
	public void setMrType(String mrType) {
		this.mrType = mrType;
	}
	public String getMrLimit() {
		return mrLimit;
	}
	public void setMrLimit(String mrLimit) {
		this.mrLimit = mrLimit;
	}
	public String getResStartDate() {
		return resStartDate;
	}
	public void setResStartDate(String resStartDate) {
		this.resStartDate = resStartDate;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("SearchDTO [brId=");
		builder.append(brId);
		builder.append(", mrType=");
		builder.append(mrType);
		builder.append(", mrLimit=");
		builder.append(mrLimit);
		builder.append(", resStartDate=");
		builder.append(resStartDate);
		builder.append("]");
		return builder.toString();
	}
	public SearchDTO(String brId, String mrType, String mrLimit, String resStartDate) {
		super();
		this.brId = brId;
		this.mrType = mrType;
		this.mrLimit = mrLimit;
		this.resStartDate = resStartDate;
	}
	public SearchDTO() {
		super();
	}
	
}
