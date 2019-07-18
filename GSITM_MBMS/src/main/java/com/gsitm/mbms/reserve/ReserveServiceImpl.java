package com.gsitm.mbms.reserve;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gsitm.mbms.approval.ApprovalDAO;
import com.gsitm.mbms.approval.ApprovalDTO;
import com.gsitm.mbms.employee.EmployeeDAO;
import com.gsitm.mbms.employee.EmployeeDTO;
import com.gsitm.mbms.room.RoomDAO;
import com.gsitm.mbms.room.RoomDTO;
import com.gsitm.mbms.util.MailService;
import com.gsitm.mbms.util.ReserveTypeVO;

/**
 * @주제 : 
 * @작성일 : 2019. 5. 29.
 * @작성자 : 조성윤
 */
@Service
public class ReserveServiceImpl implements ReserveService {
	
	@Autowired
	private ReserveDAO reserveDAO;
	@Autowired
	private RoomDAO roomDAO;
	@Autowired
	private EmployeeDAO employeeDAO;
	@Autowired
	private MailService mailService;
	@Autowired
	private ApprovalDAO approvalDAO;
	
	@Override
	public List<RoomDTO> selectAllRoom() {
		return reserveDAO.selectAllRoom();
	}

	@Override
	public List<RoomDTO> selectRoomBySearch(Map<String, String> map) {
		return reserveDAO.selectRoomBySearch(map);
	}

	@Override
	public List<ReserveHistoryDTO> getReservationListByRoomNo(int roomNo) {
		return reserveDAO.getReservationListByRoomNo(roomNo);
	}

	@Override
	public List<ReserveHistoryDTO> getReservationList(Map<String, Object> map) {
		return reserveDAO.getReservationList(map);
	}

	@Override
	public List<RoomDTO> selectAvailableRoom(Map<String, Object> map) {
		return reserveDAO.selectAvailableRoom(map);
	}

	@Override
	public List<Map<String, String>> getTimeByDate(Map<String, String> map) {
		return reserveDAO.getTimeByDate(map);
	}

	@Override
	public Map<String, String> getNextReservation(Map<String, Object> map) {
		return reserveDAO.getNextReservation(map);
	}

	@Override
	@Transactional
	public int doReserve(ReserveHistoryDTO reserveHistory) {
		// 단기/장기 구분, 회의실 총 이용시간 산출
		Date startDate = reserveHistory.getStartDate();
		Date endDate = reserveHistory.getEndDate();
		ReserveTypeVO reserveType = calcDate(startDate, endDate);
		
		// 예약할 회의실 정보 가져오기
		RoomDTO roomDTO = roomDAO.selectOneRoomByRoomNo(reserveHistory.getRoomNo());
		// 회의실 총 비용 설정
		int reservePrice = (int) (roomDTO.getRoomPrice()*reserveType.getReserveHours());
		reserveHistory.setReservePrice(reservePrice);
		
		//예약자 정보
		String reserveEmpNo = reserveHistory.getReserveEmpNo();
		EmployeeDTO reserveEmp = employeeDAO.getEmployee(reserveEmpNo);
		EmployeeDTO approval1Emp = employeeDAO.getDeptManagerEmpNo(reserveEmpNo);
		
		if(reserveType.isLongTerm()) {
			// 장기 예약
			reserveHistory.setApproval1Yn(0);
			reserveHistory.setApproval1EmpNo(approval1Emp.getEmpNo());
			reserveHistory.setApproval2Yn(0);
			reserveHistory.setApproval2EmpNo(roomDTO.getMgrEmpNo());
		} else {
			// 단기 예약
			reserveHistory.setApproval1Yn(1);
			reserveHistory.setApproval1EmpNo(null);
			reserveHistory.setApproval2Yn(1);
			reserveHistory.setApproval2EmpNo(null);
		}
		reserveDAO.insertReserveHistory(reserveHistory);
		//if(reserveHistory.getMeetingMemberList()!=null && reserveHistory.getMeetingMemberList().size() > 0)
			//reserveDAO.insertMeetingMemberList(reserveHistory.getMeetingMemberList());
		//if(reserveHistory.getMeetingEquipmentList()!=null && reserveHistory.getMeetingEquipmentList().size() > 0)
			//reserveDAO.insertMeetingEquipmentList(reserveHistory.getMeetingEquipmentList());
		//if(reserveHistory.getCompetentDepartmentList()!=null && reserveHistory.getCompetentDepartmentList().size() > 0)
			//reserveDAO.insertCompetentDepartmentList(reserveHistory.getCompetentDepartmentList());
		
		int reserveNo = reserveDAO.getNowReserveNo();
		reserveHistory.setReserveNo(reserveNo);
		
		// 메일 전송
		if(reserveType.isLongTerm()) {
			mailService.send("회의실 예약 승인 요청", approval1Emp.getEmpEmail(), reserveHistory, roomDTO, "위 회의실 예약건에 대한 승인을 요청합니다.");
		} else {
			String to = approval1Emp.getEmpEmail()+","+reserveEmp.getEmpEmail();
			List<EmployeeDTO> members = approvalDAO.selectMeetingMemberList(reserveNo);
			for(EmployeeDTO member : members) {
				to += ","+member.getEmpEmail();
			}
			mailService.send("회의실 예약 완료", to, reserveHistory, roomDTO, "회의실 예약이 완료되었습니다.");
		}
		return reserveNo;
	}
	
	// 예약시간 계산
	public ReserveTypeVO calcDate(Date startDate, Date endDate) {
		ReserveTypeVO reserveType = new ReserveTypeVO();
		
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(endDate);
		int endYear = calendar.get(Calendar.YEAR);
		int endMonth = calendar.get(Calendar.MONTH)+1;
		int endDayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);
		int endHour = calendar.get(Calendar.HOUR_OF_DAY);
		int endMinute = calendar.get(Calendar.MINUTE);
		
		calendar.setTime(startDate);
		int startYear = calendar.get(Calendar.YEAR);
		int startMonth = calendar.get(Calendar.MONTH)+1;
		int startDayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);
		int startHour = calendar.get(Calendar.HOUR_OF_DAY);
		int startMinute = calendar.get(Calendar.MINUTE);
		
		
		double reserveHours = 0.0; // 예약 시간
		
		if(startDayOfMonth==endDayOfMonth && startMonth==endMonth && startYear==endYear) {
			// 단기 예약
			reserveType.setLongTerm(false);
			reserveHours = (endHour-startHour) + (endMinute-startMinute)/60.0;
			if(startHour<12 && endHour>12) reserveHours -= 1;
		} else {
			// 장기 예약
			reserveType.setLongTerm(true);
			for(Calendar cal = calendar; 
				cal.get(Calendar.YEAR) <= endYear && cal.get(Calendar.MONTH) <= endMonth && cal.get(Calendar.DAY_OF_MONTH) <= endDayOfMonth;
				cal.add(Calendar.DAY_OF_MONTH, 1)) {
				// 평일만 계산
				switch (cal.get(Calendar.DAY_OF_WEEK)) {
					case 2: case 3: case 4: case 5: case 6:
					{
						int year = calendar.get(Calendar.YEAR);
						int month = calendar.get(Calendar.MONTH)+1;
						int dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);
						int hour = calendar.get(Calendar.HOUR_OF_DAY);
						int minute = calendar.get(Calendar.MINUTE);
						
						if(dayOfMonth==startDayOfMonth && month==startMonth && year==startYear) { //첫날 계산
							reserveHours += (18-hour) + (0-minute)/60.0;
							if(hour < 12) {
								reserveHours -= 1;
							}
						} else if(dayOfMonth==endDayOfMonth && month==endMonth && year==endYear) { // 마지막날 계산
							reserveHours += (endHour-9) + (endMinute-0)/60.0;
							if(endHour > 12) {
								reserveHours -= 1;
							}
						} else { // 중간날 게산
							reserveHours += 8;
						}
					}
					break;
				}
			}
		}
		reserveType.setReserveHours(reserveHours);
		return reserveType;
	}
	
	
}
