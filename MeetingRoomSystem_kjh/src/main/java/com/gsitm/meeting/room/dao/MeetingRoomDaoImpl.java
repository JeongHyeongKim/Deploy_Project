package com.gsitm.meeting.room.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gsitm.meeting.room.dto.MeetingRoomDTO;
import com.gsitm.meeting.vo.Branch;
import com.gsitm.meeting.vo.Employee;
import com.gsitm.meeting.vo.Equipment;
import com.gsitm.meeting.vo.MeetingRoom;

@Repository
public class MeetingRoomDaoImpl implements MeetingRoomDao {

	@Autowired
	private SqlSession session;
	
	private String namespace = "com.gsitm.meeting.mappers.meetingRoomMapper";

	@Override
	public List<MeetingRoom> meetingRoomList() {
		
		return session.selectList(namespace+".meetingRoomList");
	}

	@Override
	public int meetingRoomDelete(String meetingRoomId) {
		return session.delete(namespace+".meetingRoomDelete", meetingRoomId);
		
	}

	@Override
	public MeetingRoom meetingRoomOne(String meetingRoomId) {
		return session.selectOne(namespace+".meetingRoomOne", meetingRoomId);
	}

	@Override
	public void meetingRoomUpdate(MeetingRoom meetingRoom) {
		session.update(namespace+".meetingRoomUpdate", meetingRoom);
	}

	@Override
	public void meetingRoomCreate(MeetingRoom meetingRoom) {
		session.insert(namespace+".meetingRoomInsert", meetingRoom);
	}

	@Override
	public String meetingRoomGetRecent() {
		return session.selectOne(namespace+".meetingRoomMostRecent");
	}


	@Override
	public String meetingRoomGetRecentImgId() {
		return session.selectOne(namespace+".meetingRoomImgMostRecent");
	}

	@Override
	public List<Employee> getMeetingRoomAdministrator() {
		return session.selectList(namespace+".getMeetingRoomAdministrator");
	}

	@Override
	public List<Branch> meetingRoomGetBranchLocation() {
		return session.selectList(namespace+".meetingRoomGetBranchLocation");
	}

	@Override
	public List<Equipment> meetingRoomGetEquipment() {
		return session.selectList(namespace+".meetingRoomGetEquipment");
	}

}
