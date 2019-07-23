package com.gsitm.mbms.mypage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * @작성일 : 2019. 5. 28.
 * @작성자 : 이주현
 */

@Service
public class MypageServiceImpl implements MypageService{

	@Autowired
	private MypageDAO mypageDAO;
		
	public List<MypageDTO> selectAllHistory(String empNo) {
		return mypageDAO.selectAllHistory(empNo);
	}
		
	public List<MypageDTO> selectAllStatus(String empNo) {
		return mypageDAO.selectAllStatus(empNo);
	}
	
	public void delete(int reserveNo) throws Exception{
		mypageDAO.delete(reserveNo);
	}

	@Override
	public List<MypageDTO> selectStatusFiltering(Map<String, String> filtermap) {
		return mypageDAO.selectStatusFiltering(filtermap);
	}
	
	@Override
	public List<MypageDTO> selectHistoryFiltering(Map<String, String> historyFilterMap) {
		return mypageDAO.selectHistoryFiltering(historyFilterMap);
	}
	
	
}
