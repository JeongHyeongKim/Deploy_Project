package com.gsitm.mbms.notice;

import java.util.List;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 16.
 * @작성자 : 송민기
 */
public interface NoticeDAO {

	//리스트 불러오기
	public List<NoticeDTO> selectAll() throws Exception;
	
	//쓰기
	public void insert(NoticeDTO noticeDTO) throws Exception;
	
	//읽기
	public NoticeDTO selectByNoticeNo(int noticeNo) throws Exception;
	
	//수정
	public void update(NoticeDTO noticeDTO) throws Exception;
	
	//삭제
	public void delete(int noticeNo) throws Exception;

}
