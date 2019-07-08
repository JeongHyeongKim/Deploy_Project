package com.gsitm.meeting.reservation.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gsitm.meeting.reservation.dto.AttendeeDTO;
import com.gsitm.meeting.reservation.service.RecognitionService;

@Controller
@RequestMapping(value ="/recognition", produces="text/plain; charset=UTF-8")
public class RecognitionController {

	@Autowired
	private RecognitionService recService;
	
	@GetMapping("/waitForRecognition")
	public String waitForRecognition(Model model) {
		model.addAttribute("branchList",recService.branchList());
		model.addAttribute("resList",recService.resList());
		model.addAttribute("equipList",recService.allEquipList());
		model.addAttribute("recogList",recService.RecognitionInfo());
		System.out.println(recService.RecognitionInfo());
		return "admin/waitForRecognition";
	}
	@GetMapping("/paymentManagement") 
	public String paymentManagement(Model model) {
		model.addAttribute("allPayment",recService.allPayment());
		model.addAttribute("allDeptPayment",recService.allDeptPayment());
		return "admin/paymentManagement";
	}
	@PostMapping("/search/{searchtype}")
	public ResponseEntity<String> myPaymentBySearch(@PathVariable String searchtype){
		return new ResponseEntity<>(recService.myPaymentBySearch(searchtype),HttpStatus.OK);
	}
	@GetMapping("/exchangeAdmin")
	public String exchangeAdmin(Model model){
		model.addAttribute("empAuthorityJson", recService.empAuthorityGson());
		model.addAttribute("empAuthority",recService.empAuthority());
		return "admin/exchangeAdmin";
	}
	
	@PostMapping("/changeAuth")
	public String changeAuth(String resultArray) {
		recService.updateAuthority(resultArray);
		return "redirect:/recognition/exchangeAdmin";
	}
	@PostMapping("/approval/{resId}")
	public ResponseEntity<Void> approval(@PathVariable String resId,@RequestParam String str,@RequestParam String email,@RequestParam String deptId,@RequestParam String resCost,@RequestParam String headEmail,@RequestParam String adminId) {
		List<AttendeeDTO.forUpdateCost> list = recService.getDeptIdDeptCostForUpdateDeptCost(resId);
		System.out.println(list);
		for(int i=0;i<list.size();i++ ){
            recService.updateDeptCost(list.get(i));
        }
		//승인테이블 갱신
		recService.updateFinalRecognition(resId,adminId);
		recService.sendApprovalMailToHead(headEmail,str);
		recService.sendApprovalMail(email,str);
		int result = recService.approval(resId);
		return new ResponseEntity<>(result == 1 ? HttpStatus.OK : HttpStatus.BAD_REQUEST);
	}
	@PostMapping("/back/{resId}")
	public ResponseEntity<Void> back(@PathVariable String resId,@RequestParam String str,@RequestParam String email,@RequestParam String adminId,@RequestParam String inputValue) {
		recService.sendMail(email,str);
		//승인테이블 (반려) 갱신
		recService.updateFinalNotRecognition(resId,adminId,inputValue);
		int result = recService.back(resId);
		return new ResponseEntity<>(result == 1 ? HttpStatus.OK : HttpStatus.BAD_REQUEST);
	}
	
	@PostMapping("/searchByPeriod/searchtype={searchtype}&searchtypeByBranch={brId}")
	public  @ResponseBody ResponseEntity<String> getReservationBySearchtype(Principal principal,@PathVariable String searchtype,@PathVariable String brId) {
		return new ResponseEntity<>(recService.getReservationBySearchtype(principal.getName(), searchtype,brId),HttpStatus.OK);
	}
	//상위관리자 승인 대기 페이지
	@GetMapping("/waitForRecognitionByHead")
	public String waitForRecognitionByHead(Model model) {
		model.addAttribute("resListForHead",recService.waitForRecognitionByHead());
		return "admin/waitForRecognitionByHead";
	}
	@PostMapping("/approvalByHead/{resId}")
	public ResponseEntity<Void> approvalByHead(@PathVariable String resId,@RequestParam String str,@RequestParam String email,@RequestParam String adminId) {
		recService.updateByHeadRecognition(resId,adminId);
		recService.sendApprovalMailByHead(email,str);
		
		int result = recService.approvalByHead(resId);
		return new ResponseEntity<>(result == 1 ? HttpStatus.OK : HttpStatus.BAD_REQUEST);
	}
	@PostMapping("/backByHead/{resId}")
	public ResponseEntity<Void> backByHead(@PathVariable String resId,@RequestParam String str,@RequestParam String email,@RequestParam String adminId,@RequestParam String inputValue) {
		recService.updateByHeadNotRecognition(resId,adminId,inputValue);
		recService.sendBackMailByHead(email,str);
		int result = recService.backByHead(resId);
		return new ResponseEntity<>(result == 1 ? HttpStatus.OK : HttpStatus.BAD_REQUEST);
	}
	
	@GetMapping("/success")
	public String randomVarCollect(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("message", "관리자로 권한이 상승하셨습니다. 로그인해주세요.");
		return "redirect:/";
	}
	
	@GetMapping("/fail")
	public String ramdomVarNotCollect(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("message", "인증에 실패하셨습니다. 인증번호를 확인해주세요");
		return "redirect:/";
	}
	

	
	@GetMapping ("/isCorrect")
	public String isCorrect(String empId, String randomVar) {
		int result = recService.infoContrast(empId, randomVar);
		if(result==1) {
			return "redirect:/recognition/success";
		}else {
			return "redirect:/recognition/fail";
		}
	}
}