package com.gsitm.mbms.building;

import java.util.List;

/**
 * @작성일 : 2019. 5. 23.
 * @작성자 : 김원빈
 */
public interface BuildingService {
	/** 모든 건물 조회 **/
	public List<BuildingDTO> selectAll();
	
	/** 건물 등록 **/
	public void buildingInsert(BuildingDTO dto);

	/** 건물 삭제 **/
	public void buildingDelete(int buildNo);
	
	/** 건물 수정을 위한 건물 조회 **/
	public BuildingDTO buildingUpdateForm(int buildNo);

	/** 건물 수정 **/
	public void buildingUpdate(BuildingDTO dto);
	
	//<select id="selectAllWithRooms" resultMap="buildingWithRooms">
	public List<BuildingDTO> selectAllWithRooms();
}
