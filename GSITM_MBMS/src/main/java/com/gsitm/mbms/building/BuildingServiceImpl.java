package com.gsitm.mbms.building;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @작성일 : 2019. 5. 23.
 * @작성자 : 김원빈
 */
@Service
public class BuildingServiceImpl implements BuildingService{
	
	@Autowired
	private BuildingDAO buildingDAO;
	
	@Override
	public List<BuildingDTO> selectAll() {
		// TODO Auto-generated method stub
		return buildingDAO.SelectAll();
	}

	@Override
	public void buildingInsert(BuildingDTO dto) {
		// TODO Auto-generated method stub
		buildingDAO.buildingInsert(dto);
	}

	@Override
	public void buildingDelete(int buildNo) {
		// TODO Auto-generated method stub
		buildingDAO.buildingDelete(buildNo);
		
	}


	@Override
	public BuildingDTO buildingUpdateForm(int buildNo) {
		// TODO Auto-generated method stub
		return buildingDAO.buildingSelect(buildNo);
	}

	@Override
	public void buildingUpdate(BuildingDTO dto) {
		// TODO Auto-generated method stub
		buildingDAO.buildingUpdate(dto);
		 
	}

	@Override
	public List<BuildingDTO> selectAllWithRooms() {
		return buildingDAO.selectAllWithRooms();
	}

}
