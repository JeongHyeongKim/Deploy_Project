package com.gsitm.meeting.branch.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import com.gsitm.meeting.branch.service.DepartmentService;
import com.gsitm.meeting.vo.Department;

@Controller
@RequestMapping("/department")
public class DepartmentController {

	@Autowired
	private DepartmentService deptService;
	
	@GetMapping("/list")
	public String departmentList(Model model){
		model.addAttribute("departmentList", deptService.departmentList());
		return "department/departmentList";
	}
	
	@GetMapping("/read/{deptId}")
	public String departmentOne(Model model, @PathVariable String deptId) {
		
		model.addAttribute("department", deptService.departmentOne(deptId));
		return "department/departmentRead";
		
	}
	
	@PostMapping("/write")
	public String departmentInsert(Department department) { //실제로 데이터가 입력되는 매서드
		deptService.departmentCreate(department);
		return "redirect:/department/list";
	}
	
	@PostMapping("/update")
	public String departmentUpdate(Department department) {
		deptService.departmentUpdate(department);
		return "redirect:/department/list";
	}
	
	@PostMapping("/delete")
	public String departmentDelete(String deptId) {
		deptService.departmentDelete(deptId);
		return  "redirect:/department/list";
	}
	
	@GetMapping("/create")
	public String departmentCreate() { // 데이터를 입력받는 새 페이지로 유도해주는 매서드
		return "department/departmentCreate";
	}
	

	
	
}
