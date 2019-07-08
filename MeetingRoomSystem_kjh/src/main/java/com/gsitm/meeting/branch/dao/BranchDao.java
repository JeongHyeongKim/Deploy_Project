package com.gsitm.meeting.branch.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.gsitm.meeting.vo.Branch;
import com.gsitm.meeting.vo.MeetingRoom;


public interface BranchDao {
	

	public List<Branch> branchList();
	
	public int branchDelete(String branchId);
	
	public Branch branchOne(String branchId);
	
	public void branchUpdate(Branch branch);
	
	public void branchCreate(Branch branch);
	
	public String BranchGetRecent();
	
	public List<MeetingRoom> meetingRoomListInBranch(String branchId);
	
	public List<HashMap<String,String>> meetingRoomListOrderByBranch();
	
	public String branchGetRecentImgId();

}
	