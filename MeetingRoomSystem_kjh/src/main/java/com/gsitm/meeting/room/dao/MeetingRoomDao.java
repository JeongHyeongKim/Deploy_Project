package com.gsitm.meeting.room.dao;

import java.util.List;

import com.gsitm.meeting.room.dto.MeetingRoomDTO;
import com.gsitm.meeting.vo.Branch;
import com.gsitm.meeting.vo.Employee;
import com.gsitm.meeting.vo.Equipment;
import com.gsitm.meeting.vo.MeetingRoom;

public interface MeetingRoomDao {
	
	public List<MeetingRoom> meetingRoomList();
	
	public int meetingRoomDelete(String meetingRoomId);
	
	public MeetingRoom meetingRoomOne(String meetingRoomId);
	
	public void meetingRoomUpdate(MeetingRoom meetingRoom);
	
	public void meetingRoomCreate(MeetingRoom meetingRoom);
	
	public String meetingRoomGetRecent();
	
	public String meetingRoomGetRecentImgId();
	
	public List<Employee> getMeetingRoomAdministrator();
	
	public List<Branch> meetingRoomGetBranchLocation();
	
	public List<Equipment> meetingRoomGetEquipment();

}
