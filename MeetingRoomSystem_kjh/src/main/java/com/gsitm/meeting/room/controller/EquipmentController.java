package com.gsitm.meeting.room.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.gsitm.meeting.room.service.EquipmentService;
import com.gsitm.meeting.vo.Equipment;
import com.gsitm.meeting.vo.MeetingRoom;

@Controller
@RequestMapping("equipment")
public class EquipmentController {

	@Autowired
	private EquipmentService eqService;
	
	@Autowired
	private BranchService brService;
	
	
	
	@GetMapping("/list")
	public String equipmentAllList(Model model) {
		model.addAttribute("equipmentList", eqService.equipmentAllList());
		model.addAttribute("branchList", brService.branchList());
		return "equipment/equipmentList";
	}
	
	
	@PostMapping("/insert")
	public String equipmentInsert(String mrId, String eqCode) {
		eqService.equipmentInsert(mrId, eqCode);
		return "redirect:/equipment/list";
	}
	
	@GetMapping("read")
	public String equipmentRead(Equipment equipment) {
		return null;
	}
	
	@PostMapping("/update")
	public String equipmentUpdate(Equipment equipment) {
		eqService.equipmentUpdate(equipment);
		return "redirect:/equipment/list";
		
	}
	
	@GetMapping("/roomListInBranch/{id}")
	public ResponseEntity<Map<String, Object>> getMrListInBranch(@PathVariable String id){
		Map<String,Object> mrListInBranch = new HashMap<>();
		List<MeetingRoom> mrList = brService.meetingRoomListInBranch(id);
		System.out.println(mrList);
		mrListInBranch.put("result", mrList);
		System.out.println(mrListInBranch);
		return new ResponseEntity<Map<String, Object>>(mrListInBranch, HttpStatus.OK);
	}
	
	@PostMapping("/delete/{eqId}")
	public ResponseEntity<Void> equipmentDelete(@PathVariable String eqId) {	
		System.out.println(eqId);
		int result = eqService.equipmentDelete(eqId);
		return new ResponseEntity<>(result==1 ? HttpStatus.OK : HttpStatus.BAD_REQUEST);
	}
}
