package com.gsitm.mbms.mypage;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gsitm.mbms.employee.EmployeeDTO;

/**
 * @작성일 : 2019. 5. 28.
 * @작성자 : 이주현
 */

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@Inject
	private MypageService mypageService;
	

	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	/** 사용자 예약현황 전체 목록 */
	@RequestMapping(value = "/mypageStatusList", method = RequestMethod.GET)
	public String mypageStatusList(Model model, HttpSession session) throws Exception {
		logger.info("mypageStatus ListPage!");

		EmployeeDTO employeeDTO = (EmployeeDTO)session.getAttribute("login");
		
		List<MypageDTO> mypageStatusList = mypageService.selectAllStatus(employeeDTO.getEmpNo());
		model.addAttribute("mypageStatusList", mypageStatusList);
		
		return "/mypage/mypageStatusList";
	}
	
	
	/** 사용자 예약이력 전체 목록 */
	@RequestMapping(value = "/mypageHistoryList", method = RequestMethod.GET)
	public String selectAllMypageHistory(Model model, HttpSession session) throws Exception {
		logger.info("mypageHistory ListPage!");

		EmployeeDTO employeeDTO = (EmployeeDTO)session.getAttribute("login");

		List<MypageDTO> mypageHistoryList = mypageService.selectAllHistory(employeeDTO.getEmpNo());
		model.addAttribute("mypageHistoryList", mypageHistoryList);

		return "/mypage/mypageHistoryList";
	}
	
	/** 사용자 예약현황에서 예약 삭제 */
	@RequestMapping(value = "/mypageDelete", method = RequestMethod.POST)
	public String mypageDelete(@RequestParam("reserveNo") int reserveNo, Model model) throws Exception {
		
		mypageService.delete(reserveNo);
		return "redirect:/mypage/mypageStatusList";
	}

	/** 사용자 예약현황에서 날짜 검색 */
	@RequestMapping(value = "/mypageStatusDetail", method = RequestMethod.GET)
	public String availableStatusList(HttpSession session, String timeSelect, Model model) throws Exception {
		System.out.println(timeSelect+"--------------------------------");

		//필터링할 정보 모으기
		Map<String, String> filterMap = new HashMap<String, String>();
		timeSelect = timeSelect.replace(" ", "");
		String timeSelectStart = timeSelect.split("-")[0];
		String timeSelectEnd = timeSelect.split("-")[1];
		filterMap.put("timeSelectStart", timeSelectStart);
		filterMap.put("timeSelectEnd", timeSelectEnd);
		
		EmployeeDTO employeeDTO = (EmployeeDTO)session.getAttribute("login");
		
		filterMap.put("empNo", employeeDTO.getEmpNo());
		
		//날짜 조건에 해당되는 사용자 예약 현황 가져오기
		List<MypageDTO> statusFilteringList = mypageService.selectStatusFiltering(filterMap);
		model.addAttribute("statusFilteringList", statusFilteringList);

		return "mypage/mypageStatusDetail";
	}
	
	/** 사용자 예약이력에서 날짜 검색 */
	@RequestMapping(value = "/mypageHistoryDetail", method = RequestMethod.GET)
	public String availableHistoryList(HttpSession session, String timeSelect, Model model) throws Exception {
		System.out.println(timeSelect+"--------------------------------");

		//필터링할 정보 모으기
		Map<String, String> historyFilterMap = new HashMap<String, String>();
		timeSelect = timeSelect.replace(" ", "");
		String timeSelectStart = timeSelect.split("-")[0];
		String timeSelectEnd = timeSelect.split("-")[1];
		historyFilterMap.put("timeSelectStart", timeSelectStart);
		historyFilterMap.put("timeSelectEnd", timeSelectEnd);
		
		EmployeeDTO employeeDTO = (EmployeeDTO)session.getAttribute("login");
		
		historyFilterMap.put("empNo", employeeDTO.getEmpNo());
		
		//날짜 조건에 해당되는 사용자 예약 이력 가져오기
		List<MypageDTO> historyFilteringList = mypageService.selectHistoryFiltering(historyFilterMap);
		model.addAttribute("historyFilteringList", historyFilteringList);

		return "mypage/mypageHistoryDetail";
	}
	
}
