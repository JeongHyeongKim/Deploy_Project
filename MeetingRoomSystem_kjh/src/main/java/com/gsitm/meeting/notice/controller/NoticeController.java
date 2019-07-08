package com.gsitm.meeting.notice.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gsitm.meeting.notice.service.NoticeService;
import com.gsitm.meeting.vo.Notice;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@GetMapping("/list/{pageNo}")
	public String noticeList(Model model, @PathVariable int pageNo) {
		
		model.addAttribute("result", noticeService.noticeList(pageNo));
		return "notice/noticeList";
	}
	
	@GetMapping("/read/{noticeNum}")
	public String noticeRead(Model model, @PathVariable int noticeNum) {
		model.addAttribute("notice", noticeService.noticeRead(noticeNum));
		return "notice/noticeRead";
	}
	@GetMapping("/writePage")
	public String noticeWritePage(Model model) {
		return "notice/noticeWrite";
	}
	
	@PostMapping("/write")
	public String noticeInsert(Notice notice) {
		noticeService.noticeInsert(notice);
		return "redirect:/notice/list/1";
	}
	
	@PostMapping("/delete/{noticeId}")
	public ResponseEntity<Void> noticeDelete(@PathVariable int noticeId) {
		int result = noticeService.noticeDelete(noticeId);
		return new ResponseEntity<>(result == 1 ? HttpStatus.OK : HttpStatus.BAD_REQUEST);
	}
	
	@GetMapping("/update/{noticeId}")
	public String noticeUpdate(Model model,@PathVariable int noticeId) {
		model.addAttribute("list",noticeService.noticeRead(noticeId));
		return "notice/noticeUpdate";
	}
	@PostMapping("/update")
	public String noticeUpdate(Notice notice) {
		noticeService.noticeUpdate(notice);
		return "redirect:/notice/list/1";
	}

	//noticeDTO사용예제
	@GetMapping("/test")
	public String noticeTest(Model model) {
		model.addAttribute("test",noticeService.noticeTest());
		return "notice/noticeTestPage";
	}
}
