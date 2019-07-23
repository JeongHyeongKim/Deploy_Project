package com.gsitm.mbms.employee;

import java.util.List;
import java.util.Map;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 3.
 * @작성자 : 조성윤
 */
public interface EmployeeDAO {
	
	public EmployeeDTO getEmployee(String emp_no);

	public EmployeeDTO login(Map<String, String> map);

	public List<EmployeeDTO> selectAllAdmin();
	
	public List<Map<String, Object>> getEmployeeList();

	/** 성윤: 모든 직원 정보 조회 **/
	public List<EmployeeDTO> selectAllEmployee();
	
	/** 성윤 : 부서 전체조회 (트리) **/
	
	public List<Map<String,String>> selectAllDepartmentTree();

	/** 성윤: 상위결재자 사원번호 조회 **/
	public EmployeeDTO getDeptManagerEmpNo(String empNo);
	
	/** 민기: 해당 사용자가 보스인 부서를 조회 **/
	public List<DepartmentDTO> selectDeptByBossNo(String empNo);
}
