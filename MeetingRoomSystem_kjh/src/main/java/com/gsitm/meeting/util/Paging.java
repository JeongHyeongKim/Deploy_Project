package com.gsitm.meeting.util;

import java.util.*;

import org.springframework.beans.factory.annotation.*;

import com.google.gson.*;

public class Paging {
	@Autowired
	private Gson gson;
	
	// 한 페이지에 출력할 글의 수를 설정
	private Integer pagePerBoard = 10;
	
	// 한 페이지에 출력할 페이지네이션 수를 설정
	private Integer blockPerPage = 5;
	
	// MaxRow, MinRow 계산용 메소드
	public Map<String, Integer> getRow(Integer pageNo, Integer count) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		Integer maxRow;
		Integer minRow;
		
		maxRow = ((pageNo-1) * pagePerBoard) + 1;
		maxRow = maxRow >= count ? count : maxRow;
		
		minRow = pageNo * pagePerBoard;
		minRow = minRow <= 0 ? 1 : minRow;
		
		map.put("maxRow", maxRow);
		map.put("minRow", minRow);
		
		return map;
	}
	
	// 페이지네이션 계산용 메소드
	public String getPagenation(Integer pageNo, Integer count) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		Integer lastPageNo;
		Integer firstPageNo;
		Integer next;
		Integer prev;
		
		Integer maxPageNo = (count % pagePerBoard) != 0 ? (count / pagePerBoard) + 1 : count / pagePerBoard;
		lastPageNo = pageNo + ((blockPerPage - 1) / 2);
		lastPageNo = lastPageNo >= maxPageNo ? maxPageNo : lastPageNo;
		
		firstPageNo = pageNo - ((blockPerPage - 1) / 2);
		firstPageNo = firstPageNo <= 0 ? 1 : firstPageNo;
		
		next = lastPageNo >= maxPageNo ? 0 : lastPageNo;
		prev = firstPageNo <= 0 ? 0 : firstPageNo;
		
		map.put("firstPageNo", firstPageNo);
		map.put("lastPageNo", lastPageNo);
		map.put("next", next);
		map.put("min", prev);
		
		return gson.toJson(map);
	}
}
