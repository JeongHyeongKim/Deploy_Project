package com.gsitm.meeting.reservation.dao;

import java.util.List;
import java.util.Map;

import com.gsitm.meeting.branch.dto.DepartmentDTO;
import com.gsitm.meeting.reservation.dto.AttendeeDTO;
import com.gsitm.meeting.reservation.dto.RecognitionDTO.EmpAuthority;
import com.gsitm.meeting.users.dto.EmployeeDTO;
import com.gsitm.meeting.vo.Attendee;
import com.gsitm.meeting.vo.Branch;
import com.gsitm.meeting.vo.Department;
import com.gsitm.meeting.vo.Equipment;
import com.gsitm.meeting.vo.EquipmentReservation;
import com.gsitm.meeting.vo.Reservation;

public interface RecognitionDao {
	public List<Reservation> resList();
	public List<Branch> branchList();
	public int allPayment();
	public List<DepartmentDTO.DepartmentTest> allDeptPayment();
	public List<DepartmentDTO.DepartmentTest> myPaymentBySearch(String searchtype);
	public int approval(String resId);
	public int back(String resId);
	/*public void updateDeptCost(String deptId, int resCost);*/
	public List<EmployeeDTO.MyPageInfo> getReservationBySearchtype(String empId, String searchtype,String searchtypeByBranch);
	/*public void updateResState(String resId);
	public String selectNewResList(String resId) ;*/
	public List<Reservation> resListForHead();
	public int approvalByHead(String resId);
	public int backByHead(String resId);
	
	public List<EquipmentReservation> allEquipList();
	public List<EmpAuthority> empAuthority();
	public void updateAuthorityAdminToUser(String empId);
	
	public void updateAuthorityUserToAdmin(String empId);
	
	List<AttendeeDTO.forUpdateCost> getDeptIdDeptCostForUpdateDeptCost(String resId);
	public void updateDeptCost(AttendeeDTO.forUpdateCost list);
	public void updateFinalRecognition(String resId, String adminId);
	public void insertCertification(String empId, String randomVal);
	public String getUserPhoneNumber(String empId);
	public String getUserEmail(String empId);
	public String infoContrast(String empId, String randomVar);
	public void deleteCertification(String empId);
}
