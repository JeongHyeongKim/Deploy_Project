package com.gsitm.mbms.reserve;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.gsitm.mbms.room.RoomDTO;
import com.gsitm.mbms.util.ReserveTypeVO;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 29.
 * @작성자 : 조성윤
 */
public interface ReserveService {
	/** 전체회의실 출력 */
	public List<RoomDTO> selectAllRoom();
	
	/** 조건에 의한 회의실 검색 **/
	public List<RoomDTO> selectRoomBySearch(Map<String, String> map);

	/** 회의실번호로 예약내역 조회 **/
	public List<ReserveHistoryDTO> getReservationListByRoomNo(int roomNo);

	/** 회의실 예약 : 지사, 회의실구분별 예약목록 조회 **/
	public List<ReserveHistoryDTO> getReservationList(Map<String, Object> map);

	/** 회의실 검색 : 조건에 해당하는 이용가능한 회의실 목록 조회 **/
	public List<RoomDTO> selectAvailableRoom(Map<String,Object> map);

	/** 예약날짜의 예약시간목록 조회 **/
	public List<Map<String, String>> getTimeByDate(Map<String, String> map);

	/** 다음 예약시간 정보를 반환 **/
	public Map<String, String> getNextReservation(Map<String, Object> map);
	
	/** 성윤: 회의실 예약 **/
	public int doReserve(ReserveHistoryDTO reserveHistory);
	
	/** 성윤: 예약 시간 계산 **/
	public ReserveTypeVO calcDate(Date startDate, Date endDate);
}
