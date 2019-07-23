package com.gsitm.mbms.employee;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gsitm.mbms.reserve.ReserveDAO;
import com.gsitm.mbms.reserve.ReserveHistoryDTO;
import com.gsitm.mbms.room.RoomDAO;
import com.gsitm.mbms.room.RoomDTO;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 7.
 * @작성자 : 조성윤
 */
@Service
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	private EmployeeDAO employeeDAO;
	
	@Autowired
	private ReserveDAO reserveDAO;
	
	@Autowired
	private RoomDAO roomDAO;
	
	@Override
	public EmployeeDTO login(Map<String,String> map) {
		return employeeDAO.login(map);
	}
 
	@Override
	public EmployeeDTO getEmployee(String emp_no) {
		return employeeDAO.getEmployee(emp_no);
	}
	
	
	/**민기 : 회의실 관리자 명단 뽑아오기-----------------------------*/
	@Override
	public List<EmployeeDTO> selectAllAdmin(){
		return employeeDAO.selectAllAdmin();

	}
	
	/**민기 : 해당 사용자가 관리자인지 판별-----------------------------*/
	@Override
	public boolean isAdmin(String empNo) {
		
		//회의실 관리자 명단 뽑기
		List<RoomDTO> roomList = roomDAO.selectRoomByMgrEmpNo(empNo);

		//관리자인가
		boolean isAdmin = false;
		if(roomList.size()!=0) {isAdmin = true;}
		
		return isAdmin; //운영자면 true 리턴
	}
	
	/**민기 : 해당 사용자가 결재자인지 판별-----------------------------*/
	//현재 부서장이거나, 예전 결재한적이 있으면 결재자로 취급
	@Override
	public boolean isApprover(String empNo) {
		
		//이 사람이 결재자인 예약내역리스트과, 이 사람이 부서장인 부서 리스트 뽑기
		List<ReserveHistoryDTO> ReserveList = reserveDAO.selectReserveByApproverNo(empNo);
		List<DepartmentDTO> DeptList =  employeeDAO.selectDeptByBossNo(empNo);
		
		//결재자인가
		boolean isApprover = false;
		if(ReserveList.size()!=0) {isApprover = true;}
		
		//부서장인가
		boolean isDeptBoss = false;
		if(DeptList.size()!=0) {isDeptBoss = true;}
		
		

		return isApprover | isDeptBoss; //한개라도 맞으면 true 리턴

	}
	 

}
