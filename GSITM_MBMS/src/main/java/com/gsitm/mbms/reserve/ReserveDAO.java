package com.gsitm.mbms.reserve;

import java.util.List;
import java.util.Map;

import com.gsitm.mbms.room.RoomDTO;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 29.
 * @작성자 : 조성윤
 */
public interface ReserveDAO {
	/** 전체 회의실 검색 */
	public List<RoomDTO> selectAllRoom();
	
	/** 조건에 의한 회의실 검색 **/
	public List<RoomDTO> selectRoomBySearch(Map<String, String> map);

	/** 회의실번호로 예약내역 조회 **/
	public List<ReserveHistoryDTO> getReservationListByRoomNo(int roomNo);

	/** 회의실 예약 : 지사, 회의실구분별 예약목록 조회 **/
	public List<ReserveHistoryDTO> getReservationList(Map<String, Object> map);

	/** 회의실 검색 : 조건에 해당하는 이용가능한 회의실 목록 조회 **/
	public List<RoomDTO> selectAvailableRoom(Map<String, Object> map);

	/** 예약날짜의 예약시간목록 조회 **/
	public List<Map<String, String>> getTimeByDate(Map<String, String> map);

	/** 다음 예약시간 정보를 반환 **/
	public Map<String, String> getNextReservation(Map<String, Object> map);

	/** 성윤: 회의실 예약 **/
	public int getNowReserveNo();
	public int insertReserveHistory(ReserveHistoryDTO reserveHistory);
	//public int insertMeetingMemberList(List<MeetingMemberDTO> meetingMemberList);
	public int insertMeetingEquipmentList(List<MeetingEquipmentDTO> meetingEquipmentList);
	public int insertCompetentDepartmentList(List<CompetentDepartmentDTO> competentDepartmentList);
	// 회의실 예약 끝
	
	/** 민기: 모든 예약 내역 **/
	public List<ReserveHistoryDTO> getAllReservationList();
	
	/** 성윤: 예약번호로 예약내역 조회 **/
	public ReserveHistoryDTO getReservationByReserveNo(int reserveNo);

	/** 민기: 해당 사람이 승인자인 예약 조회 **/
	public List<ReserveHistoryDTO> selectReserveByApproverNo(String empNo);

}
