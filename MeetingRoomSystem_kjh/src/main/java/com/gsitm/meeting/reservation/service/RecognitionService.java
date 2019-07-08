package com.gsitm.meeting.reservation.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.gsitm.meeting.reservation.dao.RecognitionDaoImpl;
import com.gsitm.meeting.reservation.dto.AttendeeDTO;
import com.gsitm.meeting.reservation.dto.RecognitionDTO.EmpAuthority;
import com.gsitm.meeting.vo.EquipmentReservation;

import net.nurigo.java_sdk.Coolsms;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class RecognitionService {

	@Autowired
	private RecognitionDaoImpl recDao;
	@Autowired
	private Gson gson;
	@Autowired
	JavaMailSender mailSender;
	
	
	
	public String resList() {
		
		return gson.toJson(recDao.resList());
	}

	public String branchList() {
		
		return gson.toJson(recDao.branchList());
	}

	public String allPayment() {
		
		return gson.toJson(recDao.allPayment());
	}
	public String allDeptPayment() {
		return gson.toJson(recDao.allDeptPayment());
	}

	public String myPaymentBySearch(String searchtype) {
		
		return gson.toJson(recDao.myPaymentBySearch(searchtype));
	}
	public int approval(String resId) {
		
		return recDao.approval(resId);
	}
	/*public String updateResState(String resId) {
		recDao.updateResState(resId);
		return recDao.selectNewResList(resId);
	}*/

	public int back(String resId) {
		
		return recDao.back(resId);
	}

	public String getReservationBySearchtype(String empId, String searchtype,String brId) {
		
		return gson.toJson(recDao.getReservationBySearchtype(empId, searchtype,brId));
	}

	public void sendMail(String email, String inputValue) {
		
		MimeMessage message = mailSender.createMimeMessage();
		try {
			
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom("dlgyqls77@gmail.com");
			messageHelper.setTo(email);
			messageHelper.setSubject("[GSITM 회의실 예약 시스템]회의실 예약 반려 사유 알림");
			messageHelper.setText(inputValue);
			mailSender.send(message);
		} catch (MessagingException e) {	
			e.printStackTrace();
		}
	}

	public void sendApprovalMail(String email, String str) {
		
		MimeMessage message = mailSender.createMimeMessage();
		try {
			
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom("dlgyqls77@gmail.com");
			messageHelper.setTo(email);
			messageHelper.setSubject("[GSITM 회의실 예약 시스템]회의실 예약 승인 알림");
			messageHelper.setText(str);
			mailSender.send(message);
		} catch (MessagingException e) {	
			e.printStackTrace();
		}
	}

	/*public void updateDeptCost(String deptId, int resCost) {
		
		recDao.updateDeptCost(deptId,resCost);

	}*/

	public void sendApprovalMailToHead(String headEmail, String str) {
		
		MimeMessage message = mailSender.createMimeMessage();
		try {
			
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom("dlgyqls77@gmail.com");
			messageHelper.setTo(headEmail);
			messageHelper.setSubject("[GSITM 회의실 예약 시스템]회의실 예약 승인 알림");
			messageHelper.setText(str);
			mailSender.send(message);
		} catch (MessagingException e) {	
			e.printStackTrace();
		}
	}

	public String waitForRecognitionByHead() {
		
		return gson.toJson(recDao.resListForHead());
	}

	public void sendApprovalMailByHead(String email, String str) {
		
		MimeMessage message = mailSender.createMimeMessage();
		try {
			
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom("dlgyqls77@gmail.com");
			messageHelper.setTo(email);
			messageHelper.setSubject("[GSITM 회의실 예약 시스템]회의실 예약 1차 승인 알림");
			messageHelper.setText(str);
			mailSender.send(message);
		} catch (MessagingException e) {	
			e.printStackTrace();
		}
	}

	public void sendBackMailByHead(String email, String str) {
		
		MimeMessage message = mailSender.createMimeMessage();
		try {
			
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom("dlgyqls77@gmail.com");
			messageHelper.setTo(email);
			messageHelper.setSubject("[GSITM 회의실 예약 시스템]회의실 예약 반려 알림");
			messageHelper.setText(str);
			mailSender.send(message);
		} catch (MessagingException e) {	
			e.printStackTrace();
		}
	}

	public int approvalByHead(String resId) {
		
		return recDao.approvalByHead(resId);
	}

	public int backByHead(String resId) {
		
		return recDao.backByHead(resId);
	}
	
	public String allEquipList() {
		
		Map<String,Map<String,Integer>> countEquip = new HashMap<>(); 
		List<EquipmentReservation> equi = recDao.allEquipList();
		
		for(EquipmentReservation eqId : equi) {
			
			if(countEquip.get(eqId.getResId()) == null) {
				
				Map<String,Integer> equip = new HashMap<>();
				equip.put(eqId.getEqId(), 1);
				countEquip.put(eqId.getResId(), equip);
				
			} else {
				if(countEquip.get(eqId.getResId()).get(eqId.getEqId())==null) {
					countEquip.get(eqId.getResId()).put(eqId.getEqId(), 1);
				} else {
					countEquip.get(eqId.getResId()).put(eqId.getEqId(), countEquip.get(eqId.getResId()).get(eqId.getEqId())+1);
				}
			}
			
		}
		return gson.toJson(countEquip);
	}
	
	public List<EmpAuthority> empAuthority() {
		return recDao.empAuthority();
	}
	
	public String empAuthorityGson() {
		return gson.toJson(recDao.empAuthority());
	}
	
	public void updateAuthority(String empString) {
		List<String> empList = new ArrayList<String>(Arrays.asList(empString.split(",")));
		System.out.println(empList);
		boolean param=false;

		for(int i=0;i<empList.size();i++) {
			if(param==false) { // admin to user
				if(empList.get(i).equals("A")) {
					param=true;
					continue;
				}else {
					recDao.updateAuthorityAdminToUser(empList.get(i));
				}
			}else if(param==true) {  // user to admin
				//recDao.updateAuthorityUserToAdmin(empList.get(i));
				String userEmail=recDao.getUserEmail(empList.get(i));
				MimeMessage message = mailSender.createMimeMessage();
				try {
					System.out.println("UserEmail : " + userEmail);
					MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
					messageHelper.setFrom("maladroit1@likelion.org");
					messageHelper.setTo(userEmail);
					messageHelper.setSubject("[GSITM 회의실 예약 시스템]관리자 본인 인증");
					MakeAdminChangeEmail html = new MakeAdminChangeEmail(empList.get(i)); // 사번으로 메일 만든다.
					messageHelper.setText(html.getEmailString(), true);
					mailSender.send(message);
				} catch (MessagingException e) {	
					e.printStackTrace();
				} // 이메일 발송
				
				try {
					sendSMS(recDao.getUserPhoneNumber(empList.get(i)), empList.get(i));
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
		}
	}

	public List<AttendeeDTO.forUpdateCost> getDeptIdDeptCostForUpdateDeptCost(String resId) {
		
		return recDao.getDeptIdDeptCostForUpdateDeptCost(resId);
	}

	public void updateDeptCost(AttendeeDTO.forUpdateCost list) {
		
		recDao.updateDeptCost(list);
	}

	public void updateFinalRecognition(String resId,String adminId) {
		
		recDao.updateFinalRecognition(resId,adminId);
	}

	public void updateFinalNotRecognition(String resId, String adminId,String inputValue) {
		
		recDao.updateFinalNotRecognition(resId,adminId,inputValue);
	}

	public void updateByHeadRecognition(String resId, String adminId) {
		
		recDao.updateByHeadRecognition(resId,adminId);
	}

	public void updateByHeadNotRecognition(String resId, String adminId, String inputValue) {
		
		recDao.updateByHeadNotRecognition(resId,adminId,inputValue);
	}

	public String RecognitionInfo() {
		
		return gson.toJson(recDao.recogList());
	}
	
	public void sendSMS(String userPhoneNumber, String empId) throws Exception { 

		String api_key = "";
		String api_secret = "";

	    Message coolsms = new Message(api_key, api_secret);

	    double randomValue = Math.random();
	    int randomInteger = (int)(randomValue*999999)+100000;
	    
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", userPhoneNumber);
	    params.put("from", "");
	    params.put("type", "SMS");
	    params.put("text", "[GSITM 회의실관리 시스템] 인증번호를 이메일에 입력해주세요. 인증번호 : "+randomInteger);
	    recDao.insertCertification(empId, String.valueOf(randomInteger)); // 인증해야하는 부분
	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	    }
	}
	
	public int infoContrast(String empId, String randomVal) {
		
		String result = recDao.infoContrast(empId, randomVal);
		
		if(result==null) {//성공
			System.out.println("fail");
			return 0;
			
		}else {
			System.out.println("success");
			recDao.updateAuthorityUserToAdmin(empId);
			recDao.deleteCertification(empId);
			return 1;
		}
	}
	

}
