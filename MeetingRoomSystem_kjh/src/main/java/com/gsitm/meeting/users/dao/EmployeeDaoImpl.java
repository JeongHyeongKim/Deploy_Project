package com.gsitm.meeting.users.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gsitm.meeting.reservation.dto.ReservationDTO;
import com.gsitm.meeting.users.dto.EmployeeDTO;
import com.gsitm.meeting.vo.Employee;

@Repository
public class EmployeeDaoImpl implements EmployeeDao{

	@Autowired
	private SqlSession session;
	
	private String namespace = "com.gsitm.meeting.mappers.employeeMapper";

	@Override
	public String getStoredId(String id) {
		return session.selectOne(namespace + ".getStoredId", id);
	}

	@Override
	public int getLoginFailureCnt(String empId) {
		System.out.println("aproach");
		if(session.selectOne(namespace + ".getLoginFailureCnt", empId)==null)
			return -1;
		else
			return session.selectOne(namespace + ".getLoginFailureCnt", empId); 
	}

	@Override
	public void addLoginFailureCnt(String empId, Integer loginFailureCnt) {
		Map<String, Object> map = new HashMap<>();
		map.put("empId", empId);
		map.put("loginFailureCnt", loginFailureCnt);
		session.update(namespace + ".addLoginFailureCnt", map);
	}

	@Override
	public void resetLoginCnt(String id) {
		session.update(namespace + ".resetLoginCnt", id);
	}

	@Override
	public void lockAccount(String id) {
		session.update(namespace + ".lockAccount", id);
	}

	@Override
	public Employee getCurrentId(String empId) {
		return session.selectOne(namespace + ".getCurrentId", empId); 
	}

	@Override
	public int getDeptCost(String empId) {
		return session.selectOne(namespace + ".getDeptCost", empId);
	}

	@Override
	public List<EmployeeDTO.MyPageInfo> getReservationByEmpId(String empId) {
		return session.selectList(namespace + ".getReservationByEmpId", empId);
	}
	@Override
	public List<ReservationDTO.mySchedule> mySchedule(String empId) {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".mySchedule",empId);
	}
	@Override
	public List<EmployeeDTO.MyPageInfo> getReservationBySearchtype(String empId, String searchtype) {
		Map<String, String> result = new HashMap<>();
		result.put("empId", empId);
		result.put("searchtype", searchtype);
		return session.selectList(namespace + ".getReservationBySearchtype",result);
	}

	public void pwdInsert(String newPwd) {
		session.selectOne(namespace + ".insertNewPwd", newPwd);
	}
	
	//윤영
	@Override
	public List<EmployeeDTO.AvailableMeetingDate> availableMeetingDate(String availableDate, String mrId) {
		Map<String, String> result = new HashMap<>();
		result.put("availableDate", availableDate);
		result.put("mrId", mrId);
		return session.selectList(namespace + ".availableMeetingDate", result);
	}
	@Override   
	public EmployeeDTO.CurrentInfoByMrId CurrentInfoByMrId(String mrId) {
		return session.selectOne(namespace + ".CurrentInfoByMrId", mrId);
	}
	//

	@Override
	public void initFailureCnt(String empId) {
		session.update(namespace + ".initFailureCnt", empId);
	}
}
