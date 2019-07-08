package com.gsitm.meeting.branch.dao;

import java.util.List;

import com.gsitm.meeting.vo.DepartmentHead;



public interface DepartmentHeadDao {
	
	public void departmentHeadCreate(DepartmentHead departmentHead);
	
	public List<DepartmentHead> departmentHeadList();
	
	public DepartmentHead departmentHeadOneByEmpId(String empId);
	
	public DepartmentHead departmentHeadOneByDeptId(String deptId);
	
	public void departmentHeadUpdate(DepartmentHead departmentHead);
	
	public void departmentHeadDelete(String empId);
	

}
