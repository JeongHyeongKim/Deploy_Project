package com.gsitm.meeting.users.controller;

import java.security.Principal;
import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gsitm.meeting.reservation.service.ReservationService;
import com.gsitm.meeting.users.dto.EmployeeDTO;
import com.gsitm.meeting.users.service.EmployeeService;

@Controller
@RequestMapping(produces="text/plain; charset=UTF-8")
public class EmployeeController {

	@Autowired
	private EmployeeService empService;
	@Autowired
	private ReservationService resService;
	
	@GetMapping("/user/test")
	public String test(String id) {
		id="it0003";
		empService.lockAccount(id);
		return null;
	}
	
	/////////////////////
	@GetMapping("/user/deptCost")
	public String getDeptCost(String empId) {
		return empService.getDeptCost(empId);
	}
	
	@GetMapping("/users/mypage")
	public  String myReservation(Model model, Principal principal) {
		model.addAttribute("myCost",empService.getDeptCost(principal.getName()));
		model.addAttribute("myInfo",empService.getReservationByEmpId(principal.getName()));
		model.addAttribute("mySchedule",empService.mySchedule(principal.getName()));
		return "users/mypage";
	}
	
	@PostMapping("/users/search/{searchtype}")
	public ResponseEntity<String> myReservationBySearch(Principal principal,@PathVariable String searchtype){
		return new ResponseEntity<>(empService.getReservationBySearchtype(principal.getName(), searchtype),HttpStatus.OK);
	}
	
	@PostMapping("/reservation/available/{mrId}/{availableDate}")
	public ResponseEntity<String> availableMeetingDate(@PathVariable String mrId, @PathVariable String availableDate) throws ParseException{
		System.out.println(availableDate);
		return new ResponseEntity<>(empService.availableMeetingDate(availableDate, mrId),HttpStatus.OK);
	}
}
