package com.gsitm.meeting.branch.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gsitm.meeting.vo.Department;



@Repository
public class DepartmentDaoImpl implements DepartmentDao{
	
	@Autowired
	private SqlSession session;
	
	private String namespace = "com.gsitm.meeting.mappers.departmentMapper";



	@Override
	public List<Department> departmentList() {
		return session.selectList(namespace+".departmentList");
	}

	@Override
	public Department departmentOne(String deptId) {
		return session.selectOne(namespace+".departmentOne", deptId);
	}

	@Override
	public void departmentCreate(Department department) {
		session.insert(namespace+".departmentInsert", department);
		
	}

	@Override
	public void departmentUpdate(Department department) {
		session.update(namespace+".departmentUpdate", department);
	}

	@Override
	public void departmentDelete(String deptId) {
		session.delete(namespace+".departmentDelete", deptId);
		
	}

	




}
