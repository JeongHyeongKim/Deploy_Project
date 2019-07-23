package com.gsitm.mbms.reserve;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gsitm.mbms.room.RoomDTO;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 29.
 * @작성자 : 조성윤
 */
@Repository
public class ReserveDAOImpl implements ReserveDAO {

	@Autowired
	private SqlSession session;
	
	@Override
	public List<RoomDTO> selectAllRoom() {
		return session.selectList("roomMapper.selectAllRoom");
	}

	@Override
	public List<RoomDTO> selectRoomBySearch(Map<String, String> map) {
		return session.selectList("roomMapper.selectRoomBySearch", map);
	}

	@Override
	public List<ReserveHistoryDTO> getReservationListByRoomNo(int roomNo) {
		return session.selectList("reserveHistoryMapper.getReservationListByRoomNo", roomNo);
	}

	@Override
	public List<ReserveHistoryDTO> getReservationList(Map<String, Object> map) {
		return session.selectList("reserveHistoryMapper.getReservationList", map);
	}

	@Override
	public List<RoomDTO> selectAvailableRoom(Map<String, Object> map) {
		return session.selectList("roomMapper.selectAvailableRoom", map);
	}

	@Override
	public List<Map<String, String>> getTimeByDate(Map<String, String> map) {
		return session.selectList("reserveHistoryMapper.getTimeByDate", map);
	}

	@Override
	public Map<String, String> getNextReservation(Map<String, Object> map) {
		return session.selectOne("reserveHistoryMapper.getNextReservation", map);
	}

	@Override
	public int getNowReserveNo() {
		return session.selectOne("reserveHistoryMapper.getNowReserveNo");
	}
	
	@Override
	public int insertReserveHistory(ReserveHistoryDTO reserveHistory) {
		return session.insert("reserveHistoryMapper.insertReserveHistory", reserveHistory);
	}

	/**
	@Override
	public int insertMeetingMemberList(List<MeetingMemberDTO> meetingMemberList) {
		return session.insert("reserveHistoryMapper.insertMeetingMemberList", meetingMemberList);
	}
	*/
	
	
	@Override
	public int insertMeetingEquipmentList(List<MeetingEquipmentDTO> meetingEquipmentList) {
		return session.insert("reserveHistoryMapper.insertMeetingEquipmentList", meetingEquipmentList);
	}
	

	
	@Override
	public int insertCompetentDepartmentList(List<CompetentDepartmentDTO> competentDepartmentList) {
		return session.insert("reserveHistoryMapper.insertCompetentDepartmentList", competentDepartmentList);
	}
	
	
	/**민기 : 해당 사용자가 결재자인지 판별-----------------------------*/
	@Override
	public List<ReserveHistoryDTO> getAllReservationList() {
		return session.selectList("reserveHistoryMapper.getAllReservationList");
	}

	@Override
	public ReserveHistoryDTO getReservationByReserveNo(int reserveNo) {
		return session.selectOne("reserveHistoryMapper.getReservationByReserveNo", reserveNo);
	}

	/** 민기: 해당 사람이 승인자인 예약 조회 **/
	@Override
	public List<ReserveHistoryDTO> selectReserveByApproverNo(String empNo) {
		return session.selectList("reserveHistoryMapper.selectReserveByApproverNo", empNo);
	}


}
