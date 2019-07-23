package com.gsitm.mbms.room;

import java.util.List;

import com.gsitm.mbms.building.BuildingDTO;
import com.gsitm.mbms.equipment.EquipmentDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 29.
 * @작성자 : 조성윤
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class RoomDTO {
	private int roomNo;
	private int buildNo;
	private String roomName;
	private int roomSpace;
	private int roomNumEmp;
	private String mgrEmpNo;
	private String roomImg;
	private int roomPrice;
	private char networkYn;
	private int roomFloor;
	private String roomType;
	private List<EquipmentDTO> equipments;
	private BuildingDTO buildingDTO;
}
