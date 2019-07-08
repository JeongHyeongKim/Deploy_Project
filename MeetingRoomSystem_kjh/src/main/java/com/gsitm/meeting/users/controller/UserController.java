package com.gsitm.meeting.users.controller;

import java.io.IOException;
import java.security.Principal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gsitm.meeting.users.service.EmployeeService;
import com.gsitm.meeting.vo.Employee;

@Controller
@RequestMapping(produces="application/json;charset=utf-8")  
public class UserController {
	
	@Autowired
	private EmployeeService empService;
	
	@GetMapping("/login")
	public String login(HttpServletRequest request, HttpSession session, Model model) {
		//model.addAttribute("message", request.getAttribute("message"));
		//session.removeAttribute("message");
		//empService.pwdEncoderTest();
		return "login";
	}
	
	
	@PostMapping("/users/logout")
	public String logout() {
		return "/";
	}
	
	@PostMapping("/users/getCurrentId")
	public ResponseEntity<Employee> getCurrentId(Model model, Principal principal) {
		Employee userId = empService.getCurrentId(principal.getName());
		return new ResponseEntity<>(userId, userId != null ? HttpStatus.OK : HttpStatus.BAD_REQUEST);
	}
	
	//윤영
	@PostMapping("/users/getCurrentInfo/{mrId}")
	public @ResponseBody ResponseEntity<String> CurrentInfoByMrId(@PathVariable String mrId){
		return new ResponseEntity<>(empService.CurrentInfoByMrId(mrId), HttpStatus.OK);
	}
	
	@PostMapping("/users/checkFailureCnt")
	public String checkFailureCnt(HttpServletRequest request, RedirectAttributes redirectAttributes) throws IOException, ServletException {
		
		String id = (String) request.getAttribute("id");
		String exceptionMessage = (String) request.getAttribute("exceptionMessage");
		int failureCnt = empService.getLoginFailureCnt(id);
		System.out.println("user : "+id);
		System.out.println("failureCnt"+failureCnt);
		System.out.println(exceptionMessage);
		
		
		if(exceptionMessage.equals("Bad credentials")) {
			if(failureCnt==-1) {
				request.setAttribute("message","아이디 또는 비밀번호를 다시 확인하세요.");
			}else if(failureCnt<4) {
				System.out.println("5회 미만 실패");
				failureCnt++;
				empService.addLoginFailureCnt(id, failureCnt);
				redirectAttributes.addFlashAttribute("message", failureCnt+"회 로그인에 실패하셨습니다. 5회 실패시 계정이 비활성화 됩니다.");
			}else if(failureCnt==4) {
				failureCnt++;
				empService.addLoginFailureCnt(id, failureCnt);
				empService.lockAccount(id);
				redirectAttributes.addFlashAttribute("message", "5회 인증 실패로 계정이 비활성화 됩니다. 관리자에게 문의해주세요.");
			}
		}else if(exceptionMessage.equals("User is disabled"))
			redirectAttributes.addFlashAttribute("message", "5회 인증 실패로 비활성화 된 계정입니다.\n"
					+ "관리자에게 문의해주세요.");
		return "redirect:/";
		//다른exception에 대해서도 메시지처리를 하여야 하며, 몇회 틀렸다고 띄워야함.
		
	}
	
	
	@PostMapping("/initFailCnt")
	public String initFailCnt(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		
		String id = (String) request.getAttribute("id");
		empService.initFailureCnt(id);
		return "redirect:/reservation/list/br_0001";
	}
		
		
		

	
}
