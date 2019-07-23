package com.gsitm.mbms.building;

import java.util.List;


/**
 * @작성일 : 2019. 5. 23.
 * @작성자 : 김원빈
 */
public interface BuildingDAO {

	public List<BuildingDTO> SelectAll();

	public void buildingInsert(BuildingDTO dto);

	public void buildingDelete(int buildNo);

	public BuildingDTO buildingSelect(int buildNo);
	
	public void buildingUpdate(BuildingDTO dto);
	
	//<select id="selectAllWithRooms" resultMap="buildingWithRooms">
	public List<BuildingDTO> selectAllWithRooms();
}
