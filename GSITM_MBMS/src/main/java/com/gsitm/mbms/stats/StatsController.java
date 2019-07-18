package com.gsitm.mbms.stats;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gsitm.mbms.building.BuildingDTO;
import com.gsitm.mbms.building.BuildingService;
import com.gsitm.mbms.employee.DepartmentDTO;
import com.gsitm.mbms.room.RoomDTO;
import com.gsitm.mbms.room.RoomService;

/**
 * @주제 :
 * @작성일 : 2019. 5. 16.
 * @작성자 : 송민기
 */

@Controller
@RequestMapping("/stats")
public class StatsController {

	@Inject
	private StatsService statsService;
	
	@Inject
	private BuildingService buildingService;
	
	@Inject
	private RoomService roomService;

	
	
	@RequestMapping(value = "/statsFiltering", method = RequestMethod.GET)
	public String statsFiltering(String buildingSelect, String deptSelect, String roomTypeSelect, String timeSelect, Model model) {
		
		/**오류방지-------------------------------------------------------------------*/
		//들어온 값이 없다면
		if (buildingSelect==null) buildingSelect="전체";
		if (deptSelect==null) deptSelect="전체";
		if (roomTypeSelect==null) roomTypeSelect="전체";
		if (timeSelect==null) timeSelect="전체-전체";

		
		/**드롭다운 선택리스트 만들기-------------------------------------------------------------------*/
		// 근무지(빌딩)리스트 가져오기
		List<BuildingDTO> buildingList = buildingService.selectAll();
		model.addAttribute("buildingList", buildingList);

		// 부서 리스트 가져오기
		List<DepartmentDTO> departmentList = statsService.selectAllDept();
		model.addAttribute("departmentList", departmentList);
		
		// 현재 있는 모든 Room의 타입(회의실, 교육실, 기타 등) 가져오기
		List<RoomDTO> roomList = roomService.selectAllRoom();
		List<String> roomTypes = new ArrayList<String>();
		for (int i = 0; i < roomList.size(); i++) {
			String thisType = roomList.get(i).getRoomType();
			if (!roomTypes.contains(thisType)) {
				roomTypes.add(thisType);
			}
		}
		model.addAttribute("roomTypes", roomTypes);
		
		
		/**필터링한 부서 선택 작업-------------------------------------------------------------------*/
		// 필터링할 정보 맵으로 모으기 :
		Map<String, String> filterMap = new HashMap<String, String>();
		filterMap.put("buildingSelect", buildingSelect);
		filterMap.put("deptSelect", deptSelect);
		filterMap.put("roomTypeSelect", roomTypeSelect);
		timeSelect = timeSelect.replace(" ", "");
		String timeSelectStart = timeSelect.split("-")[0];
		String timeSelectEnd = timeSelect.split("-")[1];
		filterMap.put("timeSelectStart", timeSelectStart);
		filterMap.put("timeSelectEnd", timeSelectEnd);
		
		//필터링한 선택부서 리스트 가져오기
		List<HistoryForStatsDTO> historyList = statsService.selectFilterHistory(filterMap);
		model.addAttribute("historyList", historyList);
		
		//모델에도 필터링 담아서 뭐 선택했었는지 알려주기
		model.addAttribute("filterMap", filterMap);
		
		//선택부서 그래프 출력을 위한 빈도 리스트
		List<FrequencyDTO> frequencyList = statsService.selectFrequency(filterMap);
		model.addAttribute("frequencyList", frequencyList);
		System.out.println(frequencyList+"------------------------------------------");
		
	
		/**필터링 없는 모든 부서 선택 작업-------------------------------------------------------------------*/
		//모든부서 필터
		Map<String, String> AllfilterMap = new HashMap<String, String>();
		AllfilterMap.put("buildingSelect", "전체");
		AllfilterMap.put("deptSelect", "전체");
		AllfilterMap.put("roomTypeSelect", "전체");
		AllfilterMap.put("timeSelectStart", timeSelectStart);  //기간은 전체 말고 필터링기간이랑 똑같이
		AllfilterMap.put("timeSelectEnd", timeSelectEnd);
		
		//모든부서 그래프 출력을 위한 빈도 리스트
		List<FrequencyDTO> allFrequencyList = statsService.selectFrequency(AllfilterMap);
		model.addAttribute("allFrequencyList", allFrequencyList);
		
		
		
		return "stats/statsFiltering";
	}

	
	@RequestMapping(value = "/statsHistory", method = RequestMethod.GET)
	public String statsHistory(String buildingSelect, String deptSelect, String roomTypeSelect, String timeSelect, Model model) {
		
		/**오류방지-------------------------------------------------------------------*/
		//들어온 값이 없다면
		if (buildingSelect==null) buildingSelect="전체";
		if (deptSelect==null) deptSelect="전체";
		if (roomTypeSelect==null) roomTypeSelect="전체";
		if (timeSelect==null) timeSelect="전체-전체";

		
		/**드롭다운 선택리스트 만들기-------------------------------------------------------------------*/
		// 근무지(빌딩)리스트 가져오기
		List<BuildingDTO> buildingList = buildingService.selectAll();
		model.addAttribute("buildingList", buildingList);

		// 부서 리스트 가져오기
		List<DepartmentDTO> departmentList = statsService.selectAllDept();
		model.addAttribute("departmentList", departmentList);
		
		// 현재 있는 모든 Room의 타입(회의실, 교육실, 기타 등) 가져오기
		List<RoomDTO> roomList = roomService.selectAllRoom();
		List<String> roomTypes = new ArrayList<String>();
		for (int i = 0; i < roomList.size(); i++) {
			String thisType = roomList.get(i).getRoomType();
			if (!roomTypes.contains(thisType)) {
				roomTypes.add(thisType);
			}
		}
		model.addAttribute("roomTypes", roomTypes);
		
		
		/**필터링한 부서 선택 작업-------------------------------------------------------------------*/
		// 필터링할 정보 맵으로 모으기 :
		Map<String, String> filterMap = new HashMap<String, String>();
		filterMap.put("buildingSelect", buildingSelect);
		filterMap.put("deptSelect", deptSelect);
		filterMap.put("roomTypeSelect", roomTypeSelect);
		timeSelect = timeSelect.replace(" ", "");
		String timeSelectStart = timeSelect.split("-")[0];
		String timeSelectEnd = timeSelect.split("-")[1];
		filterMap.put("timeSelectStart", timeSelectStart);
		filterMap.put("timeSelectEnd", timeSelectEnd);
		
		//필터링한 선택부서 리스트 가져오기
		List<HistoryForStatsDTO> historyList = statsService.selectFilterHistory(filterMap);
		model.addAttribute("historyList", historyList);
		
		//모델에도 필터링 담아서 뭐 선택했었는지 알려주기
		model.addAttribute("filterMap", filterMap);
		
		return "stats/statsHistory";
	}
	
}
