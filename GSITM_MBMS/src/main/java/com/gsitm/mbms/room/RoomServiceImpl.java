package com.gsitm.mbms.room;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 31.
 * @작성자 : 조성윤
 */
@Service
public class RoomServiceImpl implements RoomService {
	
	@Autowired
	private RoomDAO roomDAO;

	@Override
	public RoomDTO selectOneRoomByRoomNo(int roomNo) {
		return roomDAO.selectOneRoomByRoomNo(roomNo);
	}

	@Override
	public List<RoomDTO> selectAllRoom() {
		// TODO Auto-generated method stub
		System.out.println(roomDAO.selectAllRoom().toString());
		return roomDAO.selectAllRoom();
	}

	@Override
	public void roomInsert(RoomDTO dto) {
		// TODO Auto-generated method stub
		System.out.println(dto.toString());
		roomDAO.roomInsert(dto);
		
	}
	@Override
	public List<RoomDTO> selectAllWithEquipments() {
		// TODO Auto-generated method stub
		return roomDAO.selectAllWithEquipments();
	}

	@Override
	public void roomDelete(int roomNo) {
		// TODO Auto-generated method stub
		roomDAO.roomDelete(roomNo);
		
	}

	@Override
	public void roomUpdate(RoomDTO dto) {
		// TODO Auto-generated method stub
		roomDAO.roomUpdate(dto);
	}

	@Override
	public List<Map<String, Object>> selectAllWithEquipmentsWithBuildings() {
		// TODO Auto-generated method stub
		return roomDAO.selectAllWithEquipmentsWithBuildings();
	}

	@Override
	public int selectGetMaxId() {
		return roomDAO.selectGetMaxId();
	}
}

