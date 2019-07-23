
package com.gsitm.mbms.equipment;

import java.util.List;
import java.util.Map;

/**
 * @주제 : 
 * @작성일 : 2019. 6. 19.
 * @작성자 : 김원빈
 */

public interface EquipmentService {
	//비품 등록
	public void equipmentInsert(EquipmentDTO dto);

	public List<EquipmentDTO> equipmentDistinctSelect();

	public List<EquipmentDTO> equipmentSelectAll();

	public List<Map<String, Object>> equipmentSelectAllwithRoom();

	public void equipmentDelete(int eqNo);

	public void equipmentUpdate(EquipmentDTO dto);

	/** 성윤: 회의실번호로 회의실 내 비품목록 조회 **/
	public List<EquipmentDTO> selectOneByRoomNo(int roomNo);

}

