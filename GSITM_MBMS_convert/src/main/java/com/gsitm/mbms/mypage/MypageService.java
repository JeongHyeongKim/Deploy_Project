package com.gsitm.mbms.mypage;

import java.util.List;
import java.util.Map;


/**
 * @작성일 : 2019. 5. 28.
 * @작성자 : 이주현
 */

public interface MypageService {

	/** 사용자 예약현황에서 전체 조회 */
	public List<MypageDTO> selectAllStatus(String empNo) throws Exception;
	
	/** 사용자 예약이력에서 전체 조회 */
	public List<MypageDTO> selectAllHistory(String empNo) throws Exception;
	 
	/** 사용자 예약현황에서 예약 삭제 */
	public void delete(int reserveNo) throws Exception;
	 
	/** 사용자 예약현황에서 날짜 조건 검색 */
	public List<MypageDTO> selectStatusFiltering(Map<String, String> filtermap);
	
	/** 사용자 예약이력에서 날짜 조건 검색 */
	public List<MypageDTO> selectHistoryFiltering(Map<String, String> historyFilterMap);

}
