package com.gsitm.mbms.building;


import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * @작성일 : 2019. 5. 23.
 * @작성자 : 김원빈
 */
@Controller
@RequestMapping("/building")
public class BuildingController {

	private static final Logger logger = LoggerFactory.getLogger(BuildingController.class);
	
	@Inject
	private BuildingService service;
	
	//Building 목록
	@RequestMapping(value="/buildingList", method=RequestMethod.GET)
	public String list(Model model) {
		logger.info("Building ListPage!");
		
		List<BuildingDTO> list = service.selectAllWithRooms();
		model.addAttribute("list",list);
		return "/building/buildingList";//test
	}
	
	//Building 등록하는 화면으로 넘어가기
	@RequestMapping(value="/buildingInsertForm", method=RequestMethod.GET)
	public String buildingInsertForm() {
		logger.info("Building Insert Form!");
		return "/building/buildingInsertForm";
	}
	
	//Building 등록
	@RequestMapping(value="/buildingInsert", method=RequestMethod.POST)
	public String buildingInsert(BuildingDTO dto) {
		System.out.println(dto.toString());
		logger.info("Building InsertAction");
		service.buildingInsert(dto);
		return "redirect:/building/buildingList?type=insert";
	}
	
	//Building 삭제
	@RequestMapping(value="/buildingDelete",method=RequestMethod.GET)
	public String buildingDelete(int buildNo) {
		logger.info("Building DeleteAction");
		service.buildingDelete(buildNo);
		return "redirect:/building/buildingList?type=delete";
	}
	
	//Building 수정화면으로 이동
	@RequestMapping(value="/buildingUpdateForm",method=RequestMethod.GET)
	public String buildingUpdateForm(Model model,int buildNo) {
		logger.info("Building UpdateForm");
		BuildingDTO dto = service.buildingUpdateForm(buildNo);
		model.addAttribute("build",dto);
		return "/building/buildingUpdateForm";
	}
	
	//Building 수정
	@RequestMapping(value="/buildingUpdate",method=RequestMethod.POST)
	public String buildingUpdate(BuildingDTO dto) {
		logger.info("Building UpdateAction");
		System.out.println(dto.toString());
		service.buildingUpdate(dto);
		return "redirect:/building/buildingList?type=update";
	}
	
	
}
