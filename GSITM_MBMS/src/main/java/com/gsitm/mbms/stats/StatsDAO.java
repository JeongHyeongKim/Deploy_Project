package com.gsitm.mbms.stats;

import java.util.List;
import java.util.Map;

import com.gsitm.mbms.employee.DepartmentDTO;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 3.
 * @작성자 : 송민기
 */
public interface StatsDAO {
	
	//부서 전체출력
	public List<DepartmentDTO> selectAllDept();
/*
	//히스토리 전체출력
	public List<HistoryForStatsDTO> selectAllHistory();
*/
	//히스토리 필터링 출력
	public List<HistoryForStatsDTO> selectFilterHistory(Map<String, String> filterMap);
	
	//그래프에 들어갈 빈도 수치 출력
	public List<FrequencyDTO> selectFrequency(Map<String, String> filterMap);
	
}
