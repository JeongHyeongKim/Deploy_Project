package com.gsitm.meeting.notice.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.gsitm.meeting.notice.dao.NoticeDaoImpl;
import com.gsitm.meeting.util.Pagination;
import com.gsitm.meeting.util.PagingUtil;
import com.gsitm.meeting.vo.Notice;

@Service
public class NoticeService {
	
	@Autowired
	private PagingUtil pUtil;
	@Autowired
	private NoticeDaoImpl noticeDao;
	
	@Autowired
	private Gson gson;
	
	public String noticeList(int pageNo){
		Integer count = noticeDao.noticeCount();
		
		Pagination p = pUtil.getPagination(count, pageNo);
		Map<String, Integer> map = new HashMap<>();
		map.put("minRow", p.getEndRowNum());
		map.put("maxRow", p.getStartRowNum());

		Map<String, Object> result = new HashMap<>();
		result.put("pagination", p);
		result.put("list", noticeDao.noticeList(map));
		return gson.toJson(result);
	}
	
	public String noticeRead(int noticeNum) {
		return gson.toJson(noticeDao.noticeRead(noticeNum));
	}
	
	public void noticeInsert(Notice notice) {
		noticeDao.noticeInsert(notice);
	}
	
	public int noticeDelete(int noticeId) {
		return noticeDao.noticeDelete(noticeId);
	}

	public void noticeUpdate(Notice notice) {
		noticeDao.noticeUpdate(notice);
	}
	
	//noticeDTO사용예제
	public String noticeTest() {
		return gson.toJson(noticeDao.noticeTest());
	}
	
}
