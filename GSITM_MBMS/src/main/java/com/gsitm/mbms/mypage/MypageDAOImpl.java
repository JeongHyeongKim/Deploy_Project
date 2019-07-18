package com.gsitm.mbms.mypage;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;


/**
 * @작성일 : 2019. 5. 28.
 * @작성자 : 이주현
 */
@Repository
public class MypageDAOImpl implements MypageDAO{

	@Inject
	private SqlSession session;
	
	private static String namespace = "mypageMapper.";

	
	@Override
	public List<MypageDTO> selectAllHistory(String empNo) {
		return session.selectList("mypageMapper.selectAllHistory", empNo);
	}
	
	@Override
	public List<MypageDTO> selectAllStatus(String empNo){
		return session.selectList("mypageMapper.selectAllStatus", empNo);
	}
	
	@Override
	public List<MypageDTO> selectStatusFiltering(Map<String, String> filtermap) {
		return session.selectList("mypageMapper.selectStatusFiltering", filtermap);
	}
	
	@Override
	public List<MypageDTO> selectHistoryFiltering(Map<String, String> historyFilterMap) {
		return session.selectList("mypageMapper.selectHistoryFiltering", historyFilterMap);
	}
	
	//삭제
	public void delete(int reserveNo) throws Exception {
		session.delete(namespace + "delete", reserveNo);
	}
	
}
