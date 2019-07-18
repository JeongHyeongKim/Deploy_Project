package com.gsitm.mbms.payment;

import java.util.List;


public interface PaymentDAO {
	
	/** 관리자 비용 결제 조회 */
	public List<PaymentDTO> selectAllPayment(String empNo);
	
	/** 결제자 비용 결제 조회 */
	public List<PaymentDTO> selectApproverPayment(String empNo);

}
