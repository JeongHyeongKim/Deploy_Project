package com.gsitm.meeting.branch.dao;

import java.util.List;

import com.gsitm.meeting.vo.Department;



public interface DepartmentDao {
	
	public void  departmentCreate(Department department);
	public List<Department>  departmentList();
	public Department departmentOne(String deptId);
	public void departmentUpdate(Department department);
	public void departmentDelete(String deptId);

}
