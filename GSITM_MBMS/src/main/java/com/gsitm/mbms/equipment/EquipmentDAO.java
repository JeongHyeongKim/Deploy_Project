
package com.gsitm.mbms.equipment;

import java.util.List;
import java.util.Map;

/**
 * @작성일 : 2019. 6. 20.
 * @작성자 : 김원빈
 */
public interface EquipmentDAO {

	void equipmentInsert(EquipmentDTO dto);

	List<EquipmentDTO> equipmentDistinctSelect();

	List<EquipmentDTO> equipmentSelectAll();

	List<Map<String, Object>> equipmentSelectAllwithRoom();

	void equipmentDelete(int eqNo);

	void equipmentUpdate(EquipmentDTO dto);

	/** 성윤: 회의실번호로 회의실 내 비품목록 조회 **/
	public List<EquipmentDTO> selectOneByRoomNo(int roomNo);

}