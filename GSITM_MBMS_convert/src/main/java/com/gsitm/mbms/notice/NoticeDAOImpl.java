package com.gsitm.mbms.notice;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

/**
 * @주제 :
 * @작성일 : 2019. 5. 16.
 * @작성자 : 송민기
 */

@Repository
public class NoticeDAOImpl implements NoticeDAO {

	@Inject
	private SqlSession sqlSession;

	private static String namespace = "noticeMapper.";

	// 리스트 불러오기
	public List<NoticeDTO> selectAll() throws Exception {
		return sqlSession.selectList(namespace + "selectAll");
	}

	// 쓰기
	public void insert(NoticeDTO noticeDTO) throws Exception {
		sqlSession.insert(namespace + "insert", noticeDTO);
	}

	// 읽기
	public NoticeDTO selectByNoticeNo(int noticeNo) throws Exception {
		return sqlSession.selectOne(namespace + "selectByNoticeNo", noticeNo);
	}

	// 수정
	public void update(NoticeDTO noticeDTO) throws Exception {
		sqlSession.update(namespace + "update", noticeDTO);
	}

	// 삭제
	public void delete(int noticeNo) throws Exception {
		sqlSession.delete(namespace + "delete", noticeNo);

	}

}
