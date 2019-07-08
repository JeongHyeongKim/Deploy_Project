package com.gsitm.meeting.room.dto;

public class MeetingRoomDTO {
	public static class MeetingRoomTest{
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
		//관리자 이름
		private String empName;
		//회의실 위치
		private String brLocation;
		//기자재 목록
		private String eqId;
		//회의실별 지사 이름
		private String brName;
		
		public String getBrName() {
			return brName;
		}


		public void setBrName(String brName) {
			this.brName = brName;
		}


		public String getEqId() {
			return eqId;
		}


		public void setEqId(String eqId) {
			this.eqId = eqId;
		}


		public String getBrLocation() {
			return brLocation;
		}
	
	
		public void setBrLocation(String brLocation) {
			this.brLocation = brLocation;
		}
	
	
		public String getEmpName() {
			return empName;
		}
	
	
		public void setEmpName(String empName) {
			this.empName = empName;
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


		public MeetingRoomTest() {
			super();
		}


		public MeetingRoomTest(String mrId, String mrName, String brId, int mrLimit, int mrPrice, int mrArea,
				String mrNetwork, String mrType, String empId, String mrLocation, String mrImg, String empName,
				String brLocation,String eqId,String brName) {
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
			this.empName = empName;
			this.brLocation = brLocation;
			this.eqId = eqId;
			this.brName = brName;
		}


		@Override
		public String toString() {
			StringBuilder builder = new StringBuilder();
			builder.append("MeetingRoomTest [mrId=");
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
			builder.append(", empName=");
			builder.append(empName);
			builder.append(", brLocation=");
			builder.append(brLocation);
			builder.append(", eqId=");
			builder.append(eqId);
			builder.append(", brName=");
			builder.append(brName);
			builder.append("]");
			return builder.toString();
		}
		
	}
}
