package com.gsitm.mbms.stats;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gsitm.mbms.employee.DepartmentDTO;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 7.
 * @작성자 : 송민기
 */
@Repository
public class StatsDAOImpl implements StatsDAO {
	@Inject
	private SqlSession sqlSession;

	
	/**민기 : 부서 명단 뽑아오기-----------------------------*/
	@Override
	public List<DepartmentDTO> selectAllDept() {
		return sqlSession.selectList("departmentMapper.selectAllDept");
	}

/*	//히스토리 전체출력
	@Override
	public List<HistoryForStatsDTO> selectAllHistory() {
		return sqlSession.selectList("statsMapper.selectAllHistory");
	}*/
	
	//히스토리 필터링 출력
	@Override
	public List<HistoryForStatsDTO> selectFilterHistory(Map<String, String> filterMap) {
		return sqlSession.selectList("statsMapper.selectFilterHistory", filterMap);
	}
	
	//그래프에 들어갈 빈도 수치 출력
	@Override
	public List<FrequencyDTO> selectFrequency(Map<String, String> filterMap) {
		return sqlSession.selectList("statsMapper.selectFrequency", filterMap);
	}

	
	
}
