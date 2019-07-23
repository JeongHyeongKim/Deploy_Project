package com.gsitm.mbms.payment;

import java.util.List;


public interface PaymentService {
	
	public List<PaymentDTO> selectAllPayment(String empNo) throws Exception;
	
	public List<PaymentDTO> selectApproverPayment(String empNo) throws Exception;

}
