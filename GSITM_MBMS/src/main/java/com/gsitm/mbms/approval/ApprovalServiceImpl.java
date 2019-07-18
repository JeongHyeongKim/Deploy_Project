package com.gsitm.mbms.approval;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gsitm.mbms.employee.EmployeeDAO;
import com.gsitm.mbms.employee.EmployeeDTO;
import com.gsitm.mbms.equipment.EquipmentDTO;
import com.gsitm.mbms.reserve.CompetentDepartmentDTO;
import com.gsitm.mbms.reserve.ReserveHistoryDTO;
import com.gsitm.mbms.util.MailService;

/**
 * @주제 : 
 * @작성일 : 2019. 6. 24.
 * @작성자 : 조성윤
 */
@Service
public class ApprovalServiceImpl implements ApprovalService {
	@Autowired
	private ApprovalDAO approvalDAO;
	@Autowired
	private MailService mailService;
	@Autowired
	private EmployeeDAO employeeDAO;

	@Override
	public ReserveHistoryDTO selectOneReserveInfo(int reserveNo) {
		return approvalDAO.selectOneReserveInfo(reserveNo);
	}

	@Override
	public List<CompetentDepartmentDTO> selectCompetentDeptartmentList(int reserveNo) {
		return approvalDAO.selectCompetentDeptartmentList(reserveNo);
	}

	@Override
	public List<EquipmentDTO> selectMeetingEquipmentList(int reserveNo) {
		return approvalDAO.selectMeetingEquipmentList(reserveNo);
	}

	@Override
	public List<EmployeeDTO> selectMeetingMemberList(int reserveNo) {
		return approvalDAO.selectMeetingMemberList(reserveNo);
	}

	/** empNo 직원이 결재해야할 예약 목록 불러오기 **/
	@Override
	public List<ApprovalDTO> selectApprovalListByEmpNo(String empNo) {
		return approvalDAO.selectApprovalListByEmpNo(empNo);
	}

	@Override
	public ApprovalDTO selectOneApprovalInfo(int reserveNo) {
		return approvalDAO.selectOneApprovalInfo(reserveNo);
	}

	@Transactional
	@Override
	public void refuse(Map<String, Object> map) {
		approvalDAO.refuse(map);
		
		int reserveNo = Integer.parseInt(map.get("reserveNo").toString());
		ApprovalDTO reserveHistory = approvalDAO.selectOneApprovalInfo(reserveNo);
		EmployeeDTO reserveEmp = employeeDAO.getEmployee(reserveHistory.getReserveEmpNo());
		String email = reserveEmp.getEmpEmail();
		
		mailService.send("회의실 예약 반려 처리 안내", email, reserveHistory, "예약이 아래의 사유로 반려되었습니다");
	}
	
	@Transactional
	@Override
	public void approval(Map<String, Object> map) {
		approvalDAO.approval(map);

		String colName = (String)map.get("colName");
		int reserveNo = Integer.parseInt(map.get("reserveNo").toString());
		ApprovalDTO reserveHistory = approvalDAO.selectOneApprovalInfo(reserveNo);
		EmployeeDTO reserveEmp = employeeDAO.getEmployee(reserveHistory.getReserveEmpNo());
		String email = "";
		
		if(colName.equals("approval2")) {
			List<EmployeeDTO> employees = approvalDAO.selectMeetingMemberList(reserveNo);
			for(EmployeeDTO emp : employees) {
				email += emp.getEmpEmail()+",";
			}
			email += reserveEmp.getEmpEmail();
			
			mailService.send("회의실 예약 완료 안내", email, reserveHistory, "예약이 완료되었습니다");
		} else if (colName.equals("approval1")) {
			EmployeeDTO nextApprovalEmp = employeeDAO.getEmployee(reserveHistory.getApproval2EmpNo());
			
			email = reserveEmp.getEmpEmail()+","+nextApprovalEmp.getEmpEmail();
			
			mailService.send("회의실 예약 1차 승인 완료 안내", email, reserveHistory, "예약이 1차 승인되었습니다");
		}
	}
}
