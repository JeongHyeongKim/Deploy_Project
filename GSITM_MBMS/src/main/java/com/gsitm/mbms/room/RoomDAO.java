package com.gsitm.mbms.room;

import java.util.List;
import java.util.Map;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 31.
 * @작성자 : 조성윤
 */
public interface RoomDAO {
	// 회의실 번호로 정보 찾기 
	public RoomDTO selectOneRoomByRoomNo(int roomNo);
	
	// 회의실 전체 검색
	public List<RoomDTO> selectAllRoom();
	
	//회의실 등록
	public void roomInsert(RoomDTO dto);

	public List<RoomDTO> selectAllWithEquipments();

	public void roomDelete(int roomNo);

	public void roomUpdate(RoomDTO dto);


	public List<Map<String, Object>> selectAllWithEquipmentsWithBuildings();

	//민기 관리자 사번으로 방 찾기
	public List<RoomDTO> selectRoomByMgrEmpNo(String empNo);
	
	public int selectGetMaxId();

}


