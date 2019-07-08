package com.gsitm.meeting.branch.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gsitm.meeting.branch.dao.DepartmentHeadDaoImpl;
import com.gsitm.meeting.vo.DepartmentHead;


@Service
public class DepartmentHeadService {

	@Autowired
	private DepartmentHeadDaoImpl deptHeadDao;
	
	public List<DepartmentHead> departmentHeadList(){
		return deptHeadDao.departmentHeadList();
	}
	
	public DepartmentHead departmentHeadOneByEmpId(String empId) {
		return deptHeadDao.departmentHeadOneByEmpId(empId);
	}
	
	public DepartmentHead departmentHeadOneByDeptId(String deptId) {
		return deptHeadDao.departmentHeadOneByDeptId(deptId);
	}
	
	public void departmentHeadCreate(DepartmentHead departmentHead){
		deptHeadDao.departmentHeadCreate(departmentHead);
	}
	
	public void departmentHeadUpdate(DepartmentHead departmentHead) {
		deptHeadDao.departmentHeadUpdate(departmentHead);
	}
	
	public void departmentHeadDelete(String empId) {
		deptHeadDao.departmentHeadDelete(empId);
	}
}
