package com.gsitm.meeting.reservation.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gsitm.meeting.reservation.dto.EquipmentReservationDTO;

@Repository
public class EquipmentReservationDaoImpl implements EquipmentReservationDao {

	@Autowired
	private SqlSession session;
	
	private String namespace = "com.gsitm.meeting.mappers.equipmentReservationMapper";

	@Override
	public List<EquipmentReservationDTO> equipList() {
		// TODO Auto-generated method stub
		return null;
	}

}
