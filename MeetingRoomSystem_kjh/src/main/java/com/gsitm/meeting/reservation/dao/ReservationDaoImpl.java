package com.gsitm.meeting.reservation.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gsitm.meeting.branch.dto.BranchDTO;
import com.gsitm.meeting.reservation.dto.ReservationDTO;
import com.gsitm.meeting.reservation.dto.SearchDTO;
import com.gsitm.meeting.room.dto.MeetingRoomDTO;
import com.gsitm.meeting.users.dto.EmployeeDTO;
import com.gsitm.meeting.vo.Attendee;
import com.gsitm.meeting.vo.Equipment;
import com.gsitm.meeting.vo.EquipmentReservation;
import com.gsitm.meeting.vo.MeetingRoom;
import com.gsitm.meeting.vo.Recognition;
import com.gsitm.meeting.vo.Reservation;

@Repository
public class ReservationDaoImpl implements ReservationDao {

	@Autowired
	private SqlSession session;
	
	private String namespace = "com.gsitm.meeting.mappers.reservationMapper";
	
	/*@Override
	public List<Reservation> resList(String mrName) {
		return session.selectList(namespace + ".resList");
	}*/

	@Override
	public List<MeetingRoomDTO> meetingRoomList(String brId) {
		return session.selectList(namespace + ".meetingRoomList", brId);
	}

	@Override
	public List<EmployeeDTO> meetingPeopleList() {
		return session.selectList(namespace + ".meetingPeopleList");
	}
	@Override
	public List<ReservationDTO> resList(String brId) {
		return session.selectList(namespace + ".resList" ,brId);
	}
	@Override
	public List<BranchDTO> branchList() {
		return session.selectList(namespace+".branchList");
	}

	@Override
	public void writeReservation(ReservationDTO reservation) {
		session.insert(namespace+".writeReservation", reservation);
	}

	@Override
	public List<MeetingRoomDTO> mrTypeList() {
		return session.selectList(namespace+".mrTypeList");
	}

	public List<MeetingRoomDTO> mrLimitList() {
		return session.selectList(namespace+".mrLimitList");
	}

	@Override
	public List<ReservationDTO> mrReservationList(String mrId) {
		return session.selectList(namespace+".mrReservationList",mrId);
	}

	@Override
	public List<Equipment> equipList(String mrId) {
		return session.selectList(namespace+".equipList",mrId);
	}

	public List<MeetingRoomDTO> search(SearchDTO search) {
		return session.selectList(namespace+".search",search);
	}

	public int cancelRes(String resId) {
		return session.delete(namespace+".cancelRes",resId);
	}

	public List<ReservationDTO.mySchedule> mySchedule(String empId) {
		return session.selectList(namespace+".mySchedule",empId);
	}

	@Override
	public List<EmployeeDTO> empList() {
		return session.selectList(namespace+".empList");
	}

	public List<ReservationDTO> myListPeriod(String resStartDate) {
		return session.selectList(namespace+".myListPeriod");
	}

	@Override
	public String resMostRecent() {
		return session.selectOne(namespace+".resMostRecent");
	}
	public String recMostRecent() {
		return session.selectOne(namespace +".recMostRecent");
	}

	@Override
	public List<Reservation> getPastReservation(String empId) {
		return session.selectList(namespace + ".getPastReservation", empId);
	}

	@Override
	public List<Equipment> getResEquip(String mrId) {
		return session.selectList(namespace + ".getResEquip", mrId);
	}

	@Override
	public String getDeptIdByEmpId(String empId) {
		return session.selectOne(namespace + ".getDeptIdByEmpId", empId);
	}

	@Override
	public int getCostByErId(String mrId) {
		return session.selectOne(namespace + ".getCostByErId", mrId);
	}

	@Override
	public String getDeptIdByDeptName(String deptName) {
		return session.selectOne(namespace + ".getDeptIdByDeptName", deptName);
	}

	@Override
	public void insertReservation(Reservation reservation) {
		session.insert(namespace+".insertReservation", reservation);
	}

	@Override
	public void insertRecognition(Recognition recognition) {
		session.insert(namespace + ".insertRecognition", recognition);
	}

	@Override
	public void insertAttendee(Attendee attendee) {
		session.insert(namespace + ".insertAttendee", attendee);
		
	}

	@Override
	public void insertResEquipment(EquipmentReservation equipmentRes) {
		session.insert(namespace + ".insertResEquipment", equipmentRes);
		
	}

	@Override
	public List<String> getPastAttendee(String empId) {
		return session.selectList(namespace + ".getPastAttendee", empId);
	}
	
	public List<String> getPastEquip(String resId){
		return session.selectList(namespace +".getPastEquip", resId);
	}

	public List<MeetingRoom> mrList(String brId) {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".mrList" ,brId);
	}

	public void minusResCost(String deptId, int deptCost) {
		Map<String, Object> result = new HashMap<>();
		result.put("deptId", deptId);
		result.put("deptCost", deptCost);
		session.update(namespace + ".minusResCost" ,result);
	}
	public List<Attendee> getCostDept(String resId){
		return session.selectList(namespace +".getCostDeptId", resId);
	}
}
