package com.gsitm.mbms.building;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

/**
 * @작성일 : 2019. 5. 23.
 * @작성자 : 김원빈
 */


@Repository
public class BuildingDAOImpl implements BuildingDAO{

	@Inject
	private SqlSession sqlSession;

	@Override
	public List<BuildingDTO> SelectAll() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("buildingMapper.allBuilding");
	}

	@Override
	public void buildingInsert(BuildingDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.insert("buildingMapper.buildingInsert", dto);
	}

	@Override
	public void buildingDelete(int buildNo) {
		// TODO Auto-generated method stub
		sqlSession.delete("buildingMapper.buildingDelete", buildNo);
	}

	@Override
	public BuildingDTO buildingSelect(int buildNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("buildingMapper.buildingSelect",buildNo);
	}

	@Override
	public void buildingUpdate(BuildingDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.update("buildingMapper.buildingUpdate", dto);
	}

	@Override
	public List<BuildingDTO> selectAllWithRooms() {
		return sqlSession.selectList("buildingMapper.selectAllWithRooms");
	}
	
}
