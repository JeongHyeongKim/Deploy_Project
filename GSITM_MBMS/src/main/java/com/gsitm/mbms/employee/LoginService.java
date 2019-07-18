package com.gsitm.mbms.employee;

import java.util.List;
import java.util.Map;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 3.
 * @작성자 : 조성윤
 */
public interface LoginService {
	public EmployeeDTO login(Map<String, String> map);
	 
	public EmployeeDTO getEmployee(String emp_no);

	/**민기 : 회의실 관리자 명단 뽑아오기-----------------------------*/
	public List<EmployeeDTO> selectAllAdmin();

	/**민기 : 해당 사용자가 관리자인지 판별-----------------------------*/
	public boolean isAdmin(String empNo);
	
	/**민기 : 해당 사용자가 관리자인지 판별-----------------------------*/
	public boolean isApprover(String empNo);
}
