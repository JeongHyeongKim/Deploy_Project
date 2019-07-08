package com.gsitm.meeting.room.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gsitm.meeting.branch.service.BranchService;
import com.gsitm.meeting.room.service.MeetingRoomService;


@Controller
@RequestMapping("/meetingRoom")
public class MeetingRoomController {

	@Autowired
	private MeetingRoomService mrService;
	
	@Autowired
	private BranchService brService;
	
	
	@GetMapping("/list")
	public String meetingRoomList(Model model, HttpServletRequest request) {
		model.addAttribute("meetingRoomList", mrService.meetingRoomList());
		model.addAttribute("branchLocationList", mrService.meetingRoomGetBranchLocation());
		model.addAttribute("equipmentList", mrService.meetingRoomGetEquipment());
		model.addAttribute("admin", mrService.getMeetingRoomAdministrator());
		return "meetingRoom/meetingRoomList";
	}
	
	@GetMapping("/read/{mrId}")
	public String branchOne(Model model, @PathVariable String mrId) {
		model.addAttribute("meetingRoom", mrService.meetingRoomOnebyGSON(mrId));
		model.addAttribute("branchList", brService.branchList());
		model.addAttribute("administrator", mrService.getMeetingRoomAdministrator());
		return "meetingRoom/meetingRoomRead"; // 리다이렉트 없이 바로 전달하면 경로로 설정
	}
	

	
	/*@PostMapping("/delete")
	public String meetingRoomDelete(String mrId) {
		System.out.println(mrId);
		mrService.meetingRoomDelete(mrId);
		return "redirect:/meetingRoom/list";
	}*/
	
	@PostMapping("/delete/{mrId}")
	public ResponseEntity<Void> meetingRoomDelete(@PathVariable String mrId) {	
		System.out.println(mrId);
		int result = mrService.meetingRoomDelete(mrId);
		return new ResponseEntity<>(result==1 ? HttpStatus.OK :  HttpStatus.BAD_REQUEST);
	}
	

	
	
	@GetMapping("/create")
	public String branchCreate(Model model) { // 글 입력폼만 있는 페이지로 이동함.
		model.addAttribute("branchList", brService.branchList());
		model.addAttribute("administrator", mrService.getMeetingRoomAdministrator());
		System.out.println("admin");
		System.out.println(mrService.getMeetingRoomAdministrator());

		return "meetingRoom/meetingRoomCreate";
	}
}
