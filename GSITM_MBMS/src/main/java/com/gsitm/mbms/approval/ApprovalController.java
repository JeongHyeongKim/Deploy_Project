package com.gsitm.mbms.approval;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gsitm.mbms.building.BuildingDTO;
import com.gsitm.mbms.building.BuildingService;
import com.gsitm.mbms.employee.EmployeeDTO;
import com.gsitm.mbms.employee.LoginService;
import com.gsitm.mbms.equipment.EquipmentDTO;
import com.gsitm.mbms.reserve.CompetentDepartmentDTO;

/**
 * @주제 : 
 * @작성일 : 2019. 6. 17.
 * @작성자 : 조성윤
 */
@Controller
@RequestMapping("/approval")
public class ApprovalController {
	@Autowired
	private ApprovalService approvalService;
	@Autowired
	private BuildingService buildingService;
	@Autowired
	private LoginService loginService;
	
	@GetMapping("/approvalDetail/{reserveNo}")
	public String approvalDetail(@PathVariable int reserveNo, Model model) {
		ApprovalDTO approvalDTO = approvalService.selectOneApprovalInfo(reserveNo);
		List<CompetentDepartmentDTO> competentDepartments = approvalService.selectCompetentDeptartmentList(reserveNo);
		List<EmployeeDTO> meetingMembers = approvalService.selectMeetingMemberList(reserveNo);
		List<EquipmentDTO> meetingEquipments = approvalService.selectMeetingEquipmentList(reserveNo);
		EmployeeDTO approval1Emp = loginService.getEmployee(approvalDTO.getApproval1EmpNo());
		EmployeeDTO approval2Emp = loginService.getEmployee(approvalDTO.getApproval2EmpNo());
		
		System.out.println(meetingMembers);
		
		model.addAttribute("approvalDTO", approvalDTO);
		model.addAttribute("competentDepartments", competentDepartments);
		model.addAttribute("meetingMembers", meetingMembers);
		model.addAttribute("meetingEquipments", meetingEquipments);
		model.addAttribute("approval1Emp", approval1Emp);
		model.addAttribute("approval2Emp", approval2Emp);
		
		return "approval/approvalDetail";
	}
	
	@GetMapping("/approvalList")
	public String approvalList(HttpSession session, Model model) {
		EmployeeDTO employeeDTO = (EmployeeDTO)session.getAttribute("login");
		List<ApprovalDTO> approvalList = approvalService.selectApprovalListByEmpNo(employeeDTO.getEmpNo());
		List<BuildingDTO> buildings = buildingService.selectAllWithRooms();
		
		System.out.println(approvalList);
		
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("buildings", buildings);
		
		return "approval/approvalList";
	}
	
	@PostMapping("/refuse")
	public ModelAndView refuse(@RequestParam Map<String, Object> map, HttpSession session) {
		approvalService.refuse(map);
		
		ModelAndView mav = new ModelAndView("jsonView");
		return mav;
	}
	
	@PostMapping("/approval")
	public ModelAndView approval(@RequestParam Map<String, Object> map, HttpSession session) {
		
		approvalService.approval(map);
		
		ModelAndView mav = new ModelAndView("jsonView");
		return mav;
	}
}
