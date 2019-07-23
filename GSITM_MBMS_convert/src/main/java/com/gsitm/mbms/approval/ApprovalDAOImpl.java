package com.gsitm.mbms.approval;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gsitm.mbms.employee.EmployeeDTO;
import com.gsitm.mbms.equipment.EquipmentDTO;
import com.gsitm.mbms.reserve.CompetentDepartmentDTO;
import com.gsitm.mbms.reserve.ReserveHistoryDTO;

/**
 * @주제 : 
 * @작성일 : 2019. 6. 24.
 * @작성자 : 조성윤
 */
@Repository
public class ApprovalDAOImpl implements ApprovalDAO {
	@Autowired
	SqlSession session;
	
	/** 성윤: 결재 관리 상세보기 관련 **/
	@Override
	public ApprovalDTO selectOneApprovalInfo(int reserveNo) {
		return session.selectOne("approvalMapper.selectOneReserveInfo", reserveNo);
	}
	@Override
	public ReserveHistoryDTO selectOneReserveInfo(int reserveNo) {
		return session.selectOne("reserveHistoryMapper.selectOneReserveInfo", reserveNo);
	}
	@Override
	public List<CompetentDepartmentDTO> selectCompetentDeptartmentList(int reserveNo) {
		return session.selectList("approvalMapper.selectCompetentDeptartmentList", reserveNo);
	}
	@Override
	public List<EquipmentDTO> selectMeetingEquipmentList(int reserveNo) {
		return session.selectList("approvalMapper.selectMeetingEquipmentList", reserveNo);
	}
	@Override
	public List<EmployeeDTO> selectMeetingMemberList(int reserveNo) {
		return session.selectList("approvalMapper.selectMeetingMemberList", reserveNo);
	}
	
	/** empNo 직원이 결재해야할 예약 목록 불러오기 **/
	@Override
	public List<ApprovalDTO> selectApprovalListByEmpNo(String empNo) {
		return session.selectList("approvalMapper.selectApprovalListByEmpNo", empNo);
	}
	@Override
	public void refuse(Map<String, Object> map) {
		session.update("approvalMapper.refuse", map);
	}
	@Override
	public void approval(Map<String, Object> map) {
		session.update("approvalMapper.approval", map);
	}

	/** 30분 후 시작하는 예약 알람 **/
	@Override
	public List<ApprovalDTO> selectImminentReserveList(String nowTime) {
		return session.selectList("approvalMapper.selectImminentReserveList", nowTime);
	}
	@Override
	public List<Integer> selectImminentReserveList2(String nowTime) {
		return session.selectList("approvalMapper.selectImminentReserveList2", nowTime);
	}

}
