
package com.gsitm.mbms.equipment;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

/**
 * @작성일 : 2019. 6. 20.
 * @작성자 : 김원빈
 */
@Repository
public class EquipmentDAOImpl implements EquipmentDAO {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public void equipmentInsert(EquipmentDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.insert("equipmentMapper.equipmentInsert", dto);
	}

	@Override
	public List<EquipmentDTO> equipmentDistinctSelect() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("equipmentMapper.equipmentDistinctSelect");
	}

	@Override
	public List<EquipmentDTO> equipmentSelectAll() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("equipmentMapper.equipmentSelectAll");
	}

	@Override
	public List<Map<String, Object>> equipmentSelectAllwithRoom() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("equipmentMapper.equipmentSelectAllwithRoom");
	}

	@Override
	public void equipmentDelete(int eqNo) {
		// TODO Auto-generated method stub
		sqlSession.delete("equipmentMapper.equipmentDelete", eqNo);
	}

	@Override
	public void equipmentUpdate(EquipmentDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.update("equipmentMapper.equipmentUpdate",dto);
	}

	@Override
	public List<EquipmentDTO> selectOneByRoomNo(int roomNo) {
		return sqlSession.selectList("equipmentMapper.selectOneByRoomNo", roomNo);
	}

}
