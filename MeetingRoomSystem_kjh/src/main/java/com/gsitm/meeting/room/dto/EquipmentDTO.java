package com.gsitm.meeting.room.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

public class EquipmentDTO {
	
	private String eqId;
	private String mrId;
	
	public EquipmentDTO() {
		super();
	}

	public String getEqId() {
		return eqId;
	}

	public void setEqId(String eqId) {
		this.eqId = eqId;
	}

	public String getMrId() {
		return mrId;
	}

	public void setMrId(String mrId) {
		this.mrId = mrId;
	}
	
	
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class EquipmentExpansion{
		private String eqId;
		private String mrId;
		private String mrName;
		private String brName;
	}
	
	

}
