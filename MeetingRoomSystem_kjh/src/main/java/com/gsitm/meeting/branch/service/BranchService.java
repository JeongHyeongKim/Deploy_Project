package com.gsitm.meeting.branch.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.google.gson.Gson;
import com.gsitm.meeting.branch.dao.BranchDaoImpl;
import com.gsitm.meeting.vo.Branch;
import com.gsitm.meeting.vo.MeetingRoom;

@Service
public class BranchService {

	@Autowired
	private BranchDaoImpl brDao;
	
	@Autowired
	private Gson gson;
	
	public List<Branch> branchList(){
		System.out.println(brDao.branchList());
		return brDao.branchList();
	}
	 
	public String branchOnebyGSON(String branchId) {
		System.out.println(brDao.branchOne(branchId));
		return gson.toJson(brDao.branchOne(branchId));
	}
	
	public Branch branchOne(String branchId) {
		return brDao.branchOne(branchId);
	}
	
	
	
	public void branchInsert(Branch branch) {
		System.out.println("branch_insert");
		String recentId = brDao.BranchGetRecent();
		System.out.println(recentId);
		String brId = recentId.split("_")[1]; // 숫자 뒤에 있는거 자르고 쓰기
		int brIdInt = Integer.parseInt(brId)+1;
		System.out.println(brIdInt);
		String nextId=null;
		if(brIdInt>999) {
			//brIdInt=0;
			nextId="br_"+brIdInt;
			System.out.println("nextId : "+nextId);
		}else if(brIdInt>99) {
			//brIdInt=100;
			nextId="br_0"+brIdInt;
			System.out.println("nextId : "+nextId);
		}else if(brIdInt>9) {
			//brIdInt=10;
			nextId="br_00"+brIdInt;
			System.out.println("nextId : "+nextId);
		}else if(brIdInt>=0) {
			nextId="br_000"+brIdInt;
			System.out.println("nextId : "+nextId);
		}
		System.out.println(nextId);
		branch.setBrId(nextId);
		System.out.println(branch.getBrId());
		System.out.println(branch.getBrLocation());
		System.out.println(branch.getBrName());
		System.out.println(branch.getBrTel());
		System.out.println(branch.getBrImg());
		brDao.branchCreate(branch);
	}
	
	
	public void branchUpdate(Branch branch) {
		brDao.branchUpdate(branch);
	}
	
	public int branchDelete(String brId) {
		return brDao.branchDelete(brId);
	}
	
	public List<MeetingRoom> meetingRoomListInBranch(String brId){
		System.out.println("check");
		System.out.println("check"+brDao.meetingRoomListInBranch(brId));
		return brDao.meetingRoomListInBranch(brId);
	}
	
	public List<HashMap<String,String>> meetingRoomListOrderByBranch(){
		//List<HashMap<String,String>> buffer=brDao.meetingRoomListOrderByBranch();
		
		return brDao.meetingRoomListOrderByBranch();
	}
	public int branchGetRecentImgId() {
		String recentId = brDao.BranchGetRecent();
		System.out.println(recentId);
		String brId = recentId.split("_")[1]; // 숫자 뒤에 있는거 자르고 쓰기
		int brIdInt = Integer.parseInt(brId)+1;
		return brIdInt;
		
	}
		
	
}
