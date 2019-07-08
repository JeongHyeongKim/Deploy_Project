package com.gsitm.meeting.room.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gsitm.meeting.room.dao.EquipmentDaoImpl;
import com.gsitm.meeting.room.dto.EquipmentDTO.EquipmentExpansion;
import com.gsitm.meeting.vo.Equipment;

@Service
public class EquipmentService {
	
	@Autowired
	private EquipmentDaoImpl eqDao;
	
	
	public List<EquipmentExpansion> equipmentAllList(){
		return eqDao.equipmentAllList();
	}
	
	
	public List<Equipment> searchEquipment(String mrId) {
		return eqDao.searchEquipment(mrId);
	}

	
	public void equipmentInsert(String mrId, String eqCode) {
		
		String seqNum=null;
		String newNum=null;
		System.out.println("mrId : "+mrId);
		System.out.println("eqCode"+eqCode);
		if(eqCode.equals("N")) {
			seqNum=eqDao.getRecentSeqNoteBook();
		}else if(eqCode.equals("V")) {
			seqNum=eqDao.getRecentSeqBeamProject();
		}else if(eqCode.equals("W")) {
			seqNum=eqDao.getRecentSeqWhiteBoard();
		}else if(eqCode.equals("M")) {
			seqNum=eqDao.getRecentSeqMike();
		}
		newNum=splitSeq(seqNum);
		Equipment equipment = new Equipment(newNum,mrId);
		System.out.println("Object eqId : "+equipment.getEqId());
		System.out.println("Object mrId : " +equipment.getMrId());
		eqDao.equipmentInsert(equipment);
	}

	
	public void equipmentUpdate(Equipment equipment) {
		eqDao.equipmentUpdate(equipment);
	}

	
	public int equipmentDelete(String eqId) {
		return eqDao.equipmentDelete(eqId);
	}
	
	
	private String splitSeq(String seq)
	{
		int eqIdInt = Integer.parseInt(seq.split("_")[1])+1;
		String nextId=null;
		if(eqIdInt>999) {
			nextId=seq.split("_")[0]+"_"+eqIdInt;
			System.out.println("nextId : "+nextId);
		}else if(eqIdInt>99) {
			nextId=seq.split("_")[0]+"_0"+eqIdInt;
			System.out.println("nextId : "+nextId);
		}else if(eqIdInt>9) {
			nextId=seq.split("_")[0]+"_00"+eqIdInt;
			System.out.println("nextId : "+nextId);
		}else if(eqIdInt>=0) {
			nextId=seq.split("_")[0]+"_000"+eqIdInt;
			System.out.println("nextId : "+nextId);
		}
		System.out.println("result : "+nextId);
		return nextId;
	}
	
	
}
