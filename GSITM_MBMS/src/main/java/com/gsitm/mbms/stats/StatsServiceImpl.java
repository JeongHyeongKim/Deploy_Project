package com.gsitm.mbms.stats;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gsitm.mbms.employee.DepartmentDTO;

/**
 * @주제 :
 * @작성일 : 2019. 5. 16.
 * @작성자 : 송민기
 */
@Service
public class StatsServiceImpl implements StatsService {
	@Autowired
	private StatsDAO statsDAO;
	
	/**민기 : 부서 명단 뽑아오기-----------------------------*/
	@Override
	public List<DepartmentDTO> selectAllDept() {
		return statsDAO.selectAllDept();
	}
	
/*	//히스토리 전체출력
	@Override
	public List<HistoryForStatsDTO> selectAllHistory() {
		return statsDAO.selectAllHistory();
	}
	*/
	//히스토리 필터링출력
	@Override
	public List<HistoryForStatsDTO> selectFilterHistory(Map<String, String> filterMap) {
		return statsDAO.selectFilterHistory(filterMap);
	}
	//그래프에 들어갈 빈도 수치 출력
 	@Override
	public List<FrequencyDTO> selectFrequency(Map<String, String> filterMap) {
		return statsDAO.selectFrequency(filterMap);
	} 

}
