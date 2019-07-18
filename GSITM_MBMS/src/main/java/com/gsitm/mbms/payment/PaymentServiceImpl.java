package com.gsitm.mbms.payment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PaymentServiceImpl implements PaymentService {
	
	@Autowired
	private PaymentDAO paymentDAO;
	
	@Override
	public List<PaymentDTO> selectAllPayment(String empNo) {
		return paymentDAO.selectAllPayment(empNo);
	}
	
	@Override
	public List<PaymentDTO> selectApproverPayment(String empNo) {
		return paymentDAO.selectApproverPayment(empNo);
	}
	
}
