package com.gsitm.meeting.room.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gsitm.meeting.room.dto.EquipmentDTO.EquipmentExpansion;
import com.gsitm.meeting.vo.Equipment;

@Repository
public class EquipmentDaoImpl implements EquipmentDao{

	@Autowired
	private SqlSession session;
	
	private String namespace = "com.gsitm.meeting.mappers.equipmentMapper";

	@Override
	public List<EquipmentExpansion> equipmentAllList() {
		return session.selectList(namespace+".equipmentAllList");
	}

	@Override
	public List<Equipment> searchEquipment(String mrId) {
		return session.selectList(namespace+".searchEquipment",mrId);
	}

	@Override
	public void equipmentInsert(Equipment equipment) {
		session.insert(namespace+".equipmentInsert",equipment);
		
	}

	@Override
	public void equipmentUpdate(Equipment equipment) {
		session.update(namespace+".equipmentUpdate",equipment);
	}

	@Override
	public int equipmentDelete(String eqId) {
		return session.delete(namespace+".equipmentDelete", eqId);
	}

	@Override
	public String getRecentSeqMike() {
		return session.selectOne(namespace+".getRecentSeqMike");
	}

	@Override
	public String getRecentSeqWhiteBoard() {
		return session.selectOne(namespace+".getRecentSeqWhiteBoard");
	}

	@Override
	public String getRecentSeqBeamProject() {
		return session.selectOne(namespace+".getRecentSeqBeamProject");
	}

	@Override
	public String getRecentSeqNoteBook() {
		return session.selectOne(namespace+".getRecentSeqNoteBook");
	}

}
