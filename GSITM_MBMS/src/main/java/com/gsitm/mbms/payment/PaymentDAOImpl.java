package com.gsitm.mbms.payment;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class PaymentDAOImpl implements PaymentDAO {
	
	@Inject
	private SqlSession session;
	
	@Override
	public List<PaymentDTO> selectAllPayment(String empNo) {
		return session.selectList("paymentMapper.selectAllPayment", empNo);
	}
	
	@Override
	public List<PaymentDTO> selectApproverPayment(String empNo) {
		return session.selectList("paymentMapper.selectApproverPayment", empNo);
	}
	
}
