package com.gsitm.meeting.room.dao;

import java.util.List;

import com.gsitm.meeting.room.dto.EquipmentDTO.EquipmentExpansion;
import com.gsitm.meeting.vo.Equipment;

public interface EquipmentDao {
	
	public List<EquipmentExpansion>equipmentAllList();
	
	public List<Equipment>searchEquipment(String mrId);
	
	public void equipmentInsert(Equipment equipment);
	
	public void equipmentUpdate(Equipment equipment);
	
	public int equipmentDelete(String eqId);
	
	public String getRecentSeqMike();
	
	public String getRecentSeqWhiteBoard();
	
	public String getRecentSeqBeamProject();
	
	public String getRecentSeqNoteBook();

}
