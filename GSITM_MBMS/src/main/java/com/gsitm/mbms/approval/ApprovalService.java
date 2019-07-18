package com.gsitm.mbms.approval;

import java.util.List;
import java.util.Map;

import com.gsitm.mbms.employee.EmployeeDTO;
import com.gsitm.mbms.equipment.EquipmentDTO;
import com.gsitm.mbms.reserve.CompetentDepartmentDTO;
import com.gsitm.mbms.reserve.ReserveHistoryDTO;

/**
 * @주제 : 
 * @작성일 : 2019. 6. 24.
 * @작성자 : 조성윤
 */
public interface ApprovalService {
	/** 성윤: 결재 관리 상세보기 관련 **/
	public ApprovalDTO selectOneApprovalInfo(int reserveNo);
	public ReserveHistoryDTO selectOneReserveInfo(int reserveNo);
	public List<CompetentDepartmentDTO> selectCompetentDeptartmentList(int reserveNo);
	public List<EquipmentDTO> selectMeetingEquipmentList(int reserveNo);
	public List<EmployeeDTO> selectMeetingMemberList(int reserveNo);

	/** empNo 직원이 결재해야할 예약 목록 불러오기 **/
	public List<ApprovalDTO> selectApprovalListByEmpNo(String empNo);
	public void refuse(Map<String, Object> map);
	public void approval(Map<String, Object> map);
}
