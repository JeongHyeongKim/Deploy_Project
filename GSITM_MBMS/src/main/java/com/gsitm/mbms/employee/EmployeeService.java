package com.gsitm.mbms.employee;

import java.util.List;
import java.util.Map;

/**
 * @주제 : 
 * @작성일 : 2019. 6. 18.
 * @작성자 : 조성윤
 */
public interface EmployeeService {
	/** 원빈: **/
	public List<Map<String,Object>> getEmployeeList();
	
	/** 성윤: 모든 직원 정보 조회 **/
	public List<EmployeeDTO> selectAllEmployee();
	
	/** 성윤: 부서 전체조회 (트리) **/
	public List<Map<String,String>> selectAllDepartmentTree();
	
	/** 성윤: 상위결재자 사원번호 조회 **/ 
	public EmployeeDTO getDeptManagerEmpNo(String empNo);

	/** 원빈 : 직원 한명 조회 **/
	public EmployeeDTO getEmployee(String empNo);
}
