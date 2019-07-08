package com.gsitm.meeting.util;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gsitm.meeting.branch.service.BranchService;
import com.gsitm.meeting.room.service.MeetingRoomService;
import com.gsitm.meeting.vo.Branch;
import com.gsitm.meeting.vo.MeetingRoom;



@Controller
@RequestMapping("/file")
public class FileUploadController {
	
	@Autowired
	private BranchService brService;
	@Autowired
	private FileUploadService fileUploadService;
	@Autowired
	private MeetingRoomService mrService;
	
	
	
	@PostMapping("/branchWrite")
	public String branchInsert( @RequestParam("brId") String brId, @RequestParam("brName") String brName,
			@RequestParam("brLocation") String brLocation, @RequestParam("brTel") String brTel,
			@RequestParam("brImg") MultipartFile brImg, HttpServletRequest request) {
		
		
		String url = request.getSession().getServletContext().getRealPath("/");
		String urlBefore = url.split("\\.metadata")[0];
		String urlAfter = url.split("wtpwebapps")[1];
		String realURL = urlBefore+urlAfter+"/src/main/webapp/resources/img/"; // 실제 컴퓨터 상에서의 프로젝트 경로
		System.out.println(realURL);
		
		String finalURL = fileUploadService.restore(brImg, realURL, "branch");
		finalURL = finalURL.split("webapp/")[1];
		finalURL = "/meeting/"+finalURL;
		System.out.println(finalURL);
		
		Branch branch = new Branch(brId, brName, brLocation, brTel, finalURL);
		brService.branchInsert(branch);
		return "redirect:/branch/list";
	}
	
	@PostMapping("/branchUpdate")
	public String branchUpdate(@RequestParam("brId") String brId, @RequestParam("brName") String brName,
			@RequestParam("brLocation") String brLocation, @RequestParam("brTel") String brTel,
			@RequestParam("brImg") MultipartFile brImg, HttpServletRequest request) {
		
		String buf = brService.branchOne(brId).getBrImg(); // brId받은 것을 통해 파일 경로를 그대로 가져온다 -> 상대경로임!
		
		String url = request.getSession().getServletContext().getRealPath("/");
		String urlBefore = url.split("\\.metadata")[0];
		String urlAfter = url.split("wtpwebapps")[1];
		String realURL = urlBefore+urlAfter+"/src/main/webapp/resources/img/"; // 실제 컴퓨터 상에서의 프로젝트 경로
		System.out.println(realURL);
		
		
		fileUploadService.restoreUpdate(brImg, realURL, "branch", brId); // 시스템상에 있는 branch 사진 수정
		
		Branch branch = new Branch(brId, brName, brLocation, brTel, buf); // 상대경로는 바뀌지 않으므로, 그대로 가져다 쓴다.
		brService.branchUpdate(branch);
		return "redirect:/branch/list";
	}
	
	

	@PostMapping("/meetingRoomWrite")
	public String meetingRoomInsert(@RequestParam("mrId") String mrId, @RequestParam("mrName")String mrName, @RequestParam("brId")String brId,
			@RequestParam("mrLimit") int mrLimit,@RequestParam("mrNetwork")String mrNetwork, @RequestParam("mrPrice")int mrPrice, @RequestParam("mrArea")int mrArea,
			@RequestParam("mrType") String mrType, @RequestParam("empId") String empId, @RequestParam("mrLocation")String mrLocation,
			@RequestParam("mrImg")MultipartFile  mrImg, HttpServletRequest request) {
		
		String url = request.getSession().getServletContext().getRealPath("/");
		String urlBefore = url.split("\\.metadata")[0];
		String urlAfter = url.split("wtpwebapps")[1];
		String realURL = urlBefore+urlAfter+"/src/main/webapp/resources/img/"; // 실제 컴퓨터 상에서의 프로젝트 경로
		System.out.println(realURL);
		
		String finalURL = fileUploadService.restore(mrImg, realURL, "meetingroom");
		finalURL = finalURL.split("webapp/")[1];
		finalURL = "/meeting/"+finalURL;
		System.out.println(finalURL);
		
		MeetingRoom meetingroom = new MeetingRoom( mrId,  mrName,  brId,  mrLimit,  mrPrice,  mrArea,  mrNetwork, mrType,  empId,  mrLocation,  finalURL);
		mrService.meetingRoomInsert(meetingroom);
		
		return "redirect:/meetingRoom/list";
	}
	
	@PostMapping("/meetingRoomUpdate")
	public String meetingRoomUpdate(@RequestParam("mrId") String mrId, @RequestParam("mrName")String mrName, @RequestParam("brId")String brId,
			@RequestParam("mrLimit") int mrLimit,@RequestParam("mrNetwork")String mrNetwork, @RequestParam("mrPrice")int mrPrice, @RequestParam("mrArea")int mrArea,
			@RequestParam("mrType") String mrType, @RequestParam("empId") String empId, @RequestParam("mrLocation")String mrLocation,
			@RequestParam("mrImg")MultipartFile  mrImg, HttpServletRequest request) {
		
		String buf = mrService.meetingRoomOne(mrId).getMrImg(); // brId받은 것을 통해 파일 경로를 그대로 가져온다 -> 상대경로임!
		
		String url = request.getSession().getServletContext().getRealPath("/");
		String urlBefore = url.split("\\.metadata")[0];
		String urlAfter = url.split("wtpwebapps")[1];
		String realURL = urlBefore+urlAfter+"/src/main/webapp/resources/img/"; // 실제 컴퓨터 상에서의 프로젝트 경로
		System.out.println(realURL);
		
		
		fileUploadService.restoreUpdate(mrImg, realURL, "meetingroom", brId); // 시스템상에 있는 branch 사진 수정
		
		MeetingRoom meetingroom = new MeetingRoom( mrId,  mrName,  brId,  mrLimit,  mrPrice,  mrArea,  mrNetwork, mrType,  empId,  mrLocation, buf);
		mrService.meetingRoomUpdate(meetingroom);
		return "redirect:/meetingRoom/list";
	}
	
	
}
