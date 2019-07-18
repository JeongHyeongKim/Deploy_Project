package com.gsitm.mbms.notice;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

/**
 * @주제 :
 * @작성일 : 2019. 5. 16.
 * @작성자 : 송민기
 */
@Service
public class NoticeServiceImpl implements NoticeService {

	@Inject
	private NoticeDAO dao;

	// 리스트 불러오기
	public List<NoticeDTO> selectAll() throws Exception {
		return dao.selectAll();

	}

	// 쓰기
	public void insert(NoticeDTO noticeDTO) throws Exception {
		dao.insert(noticeDTO);
	}

	// 읽기
	public NoticeDTO selectByNoticeNo(int noticeNo) throws Exception {
		return dao.selectByNoticeNo(noticeNo);
	}
	
	// 수정
	public void update(NoticeDTO noticeDTO) throws Exception {
		dao.update(noticeDTO);
	}
	
	// 삭제
	public void delete(int noticeNo) throws Exception {
		dao.delete(noticeNo);
	}



}
