package com.gsitm.meeting.vo;

public class Branch {
	
	private String brId;
	private String brName;
	private String brLocation;
	private String brTel;
	private String brImg;
	
	public Branch() {
		super();
	}
	
	public Branch(String brId, String brName, String brLocation, String brTel, String brImg) {
		this.brId = brId;
		this.brName = brName;
		this.brLocation = brLocation;
		this.brTel = brTel;
		this.brImg = brImg;
	}

	public String getBrId() {
		return brId;
	}

	public void setBrId(String brId) {
		this.brId = brId;
	}

	public String getBrName() {
		return brName;
	}

	public void setBrName(String brName) {
		this.brName = brName;
	}

	public String getBrLocation() {
		return brLocation;
	}

	public void setBrLocation(String brLocation) {
		this.brLocation = brLocation;
	}

	public String getBrTel() {
		return brTel;
	}

	public void setBrTel(String brTel) {
		this.brTel = brTel;
	}

	public String getBrImg() {
		return brImg;
	}

	public void setBrImg(String brImg) {
		this.brImg = brImg;
	}
	
	

}
