package com.gsitm.meeting.branch.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import com.gsitm.meeting.branch.service.DepartmentHeadService;
import com.gsitm.meeting.vo.DepartmentHead;

@Controller
@RequestMapping("/departmentHead")
public class DepartmentHeadController {
	
	@Autowired
	private DepartmentHeadService deptHeadService;
	
	@GetMapping("/list")
	public String departmentHeadList(Model model) {
		model.addAttribute("departmentHeadList", deptHeadService.departmentHeadList());
		return "departmentHead/departmentHeadList";
	}
	
	@GetMapping("/read/{empId}")
	public String departmentHeadOneByEmpId(Model model, @PathVariable String empId) {
		model.addAttribute("departmentHead", deptHeadService.departmentHeadOneByEmpId(empId));
		return "departmentHead/departmentHeadList";
	}
	
	@PostMapping("/write")
	public String departmentHeadInsert(DepartmentHead departmentHead) {
		deptHeadService.departmentHeadCreate(departmentHead);
		return "redirect/departmentHead/list";
	}
	
	@GetMapping("/create")
	public String departmentHeadCreate() {
		return "departmentHead/departmentCreate";
	}
	
	@GetMapping("/read/{deptId}")
	public String departmentHeadOneByDeptId(Model model, @PathVariable String deptId) {
		model.addAttribute("departmentHead", deptHeadService.departmentHeadOneByDeptId(deptId));
		return "departmentHead/departmentRead";
	}
	
	@PostMapping("/update")
	public String departmentHeadUpdate(DepartmentHead departmentHead) {
		deptHeadService.departmentHeadUpdate(departmentHead);
		return "redirect:/departmentHead/list";
	}
	@PostMapping("/delete")
	public String departmentHeadDelete(String empId) {
		deptHeadService.departmentHeadDelete(empId);
		return "redirect/departmentHead/list";
	}
}
