package com.gsitm.meeting.room.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.gsitm.meeting.room.dao.MeetingRoomDaoImpl;
import com.gsitm.meeting.room.dto.MeetingRoomDTO;
import com.gsitm.meeting.vo.Branch;
import com.gsitm.meeting.vo.Employee;
import com.gsitm.meeting.vo.Equipment;
import com.gsitm.meeting.vo.MeetingRoom;

@Service
public class MeetingRoomService {

	@Autowired
	private MeetingRoomDaoImpl mrDao;
	
	@Autowired
	private Gson gson;
	
	
	public List<MeetingRoom> meetingRoomList(){
		System.out.println(mrDao.meetingRoomList());
		return mrDao.meetingRoomList();
	}
	 
	public String meetingRoomOnebyGSON(String meetingRoomId) {

		return gson.toJson(mrDao.meetingRoomOne(meetingRoomId));
	}
	
	public MeetingRoom meetingRoomOne(String mrId) {
		return mrDao.meetingRoomOne(mrId);
	}
	
	
	
	public void meetingRoomInsert(MeetingRoom meetingRoom) {
		System.out.println("meetingRoom_insert");
		String recentId = mrDao.meetingRoomGetRecent();
		System.out.println(recentId);
		String mrId = recentId.split("_")[1]; // 숫자 뒤에 있는거 자르고 쓰기
		int mrIdInt = Integer.parseInt(mrId)+1;
		System.out.println(mrIdInt);
		String nextId=null;
		if(mrIdInt>999) {
			//mrIdInt=0;
			nextId="mr_"+mrIdInt;
			System.out.println("nextId : "+nextId);
		}else if(mrIdInt>99) {
			//mrIdInt=100;
			nextId="mr_0"+mrIdInt;
			System.out.println("nextId : "+nextId);
		}else if(mrIdInt>9) {
			//mrIdInt=10;
			nextId="mr_00"+mrIdInt;
			System.out.println("nextId : "+nextId);
		}else if(mrIdInt>=0) {
			nextId="mr_000"+mrIdInt;
			System.out.println("nextId : "+nextId);
		}
		System.out.println(nextId);
		meetingRoom.setMrId(nextId);
		mrDao.meetingRoomCreate(meetingRoom);
	}
	
	
	public void meetingRoomUpdate(MeetingRoom meetingRoom) {
		mrDao.meetingRoomUpdate(meetingRoom);
	}
	
	public int meetingRoomDelete(String mrId) {
		return mrDao.meetingRoomDelete(mrId);
	}
	

	public int meetingRoomGetRecentImgId() {
		String recentId = mrDao.meetingRoomGetRecent();
		
		String mrId = recentId.split("_")[1]; // 숫자 뒤에 있는거 자르고 쓰기
		int mrIdInt = Integer.parseInt(mrId)+1;
		System.out.println("새로운 이미지 넘버 : "+mrIdInt);
		

		return mrIdInt;
	
	}
	
	
	public List<Employee> getMeetingRoomAdministrator(){
		return mrDao.getMeetingRoomAdministrator();
	}
	
	public List<Branch> meetingRoomGetBranchLocation(){
		return mrDao.meetingRoomGetBranchLocation();
	}
	
	public List<Equipment> meetingRoomGetEquipment(){
		return mrDao.meetingRoomGetEquipment();
	}
}
