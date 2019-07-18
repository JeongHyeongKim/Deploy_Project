package com.gsitm.mbms.util;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.gsitm.mbms.approval.ApprovalDAO;
import com.gsitm.mbms.approval.ApprovalDTO;
import com.gsitm.mbms.employee.EmployeeDTO;
import com.gsitm.mbms.reserve.ReserveHistoryDTO;
import com.gsitm.mbms.room.RoomDTO;

@Service
public class MailServiceImpl implements MailService {
	
//	private final JavaMailSender javaMailSender;
	
	@Autowired
	private ApprovalDAO approvalDAO;

//	@Autowired
//	public MailServiceImpl(JavaMailSender javaMailSender) {
//		this.javaMailSender = javaMailSender;
//	}

//	@Override
//	public boolean send(String subject, String to, ApprovalDTO reserve, String comment) {
//		MimeMessage msg = javaMailSender.createMimeMessage();
//		String text = getMailTemplate(reserve, comment);
//		
//		try {
//			msg.addRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
//			
//			MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");
//			helper.setSubject(subject);
//			helper.setText(text, true);
//			helper.setFrom("jayjoy77@naver.com");
//
//			javaMailSender.send(msg);
//			return true;
//		} catch (MessagingException e) {
//			e.printStackTrace();
//		}
//		return false;
//	}
//	
//	@Override
//	public boolean send(String subject, String to, ReserveHistoryDTO reserveHistory, RoomDTO roomDTO, String comment) {
//		MimeMessage msg = javaMailSender.createMimeMessage();
//		String text = getMailTemplate(reserveHistory,roomDTO,comment);
//		
//		try {
//			msg.addRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
//			
//			MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");
//			helper.setSubject(subject);
//			helper.setText(text, true);
//			helper.setFrom("jayjoy77@naver.com");
//
//			javaMailSender.send(msg);
//			return true;
//		} catch (MessagingException e) {
//			e.printStackTrace();
//		}
//		return false;
//	}
	
	public String getMailTemplate(ReserveHistoryDTO reserveHistory, RoomDTO roomDTO, String comment) {
	    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String template =
			"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">" + 
			"<html xmlns=\"http://www.w3.org/1999/xhtml\">" + 
			"<head>" + 
			"    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"/>" + 
			"    <title></title>" + 
			"    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>" + 
			"</head>" + 
			"<body style=\"margin:0; padding:10px 0 0 0;\" bgcolor=\"#F8F8F8\">" + 
			"<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\">" + 
			"    <tr>" + 
			"        <td align=\"center\">" + 
			"            <table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\"" + 
			"                   style=\"border-collapse: separate; border-spacing: 2px 5px; box-shadow: 1px 0 1px 1px #B8B8B8;\"" + 
			"                   bgcolor=\"#FFFFFF\">" + 
			"                   <tr>" + 
			"                    <td align=\"center\">" + 
			"                        <!-- Initial relevant banner image goes here under src-->" + 
			"                        MBMS" + 
			"                    </td>" + 
			"                </tr>" + 
			"                <tr>" + 
			"                    <td bgcolor=\"#ffffff\" style=\"padding: 40px 30px 40px 30px;\">" + 
			"                        <table border=\"1\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border: 1px #cccccc;\">" + 
			"                           <tr>" + 
			"                              <td>회의 내용</td>" + 
			"                              <td>"+ reserveHistory.getTitle() +"</td>" + 
			"                           </tr>" + 
			"                           <tr>" + 
			"                              <td>회의 장소</td>" + 
			"                              <td>"+ roomDTO.getRoomFloor() +"층 "+ roomDTO.getRoomName() +"</td>" + 
			"                           </tr>" + 
			"                           <tr>" + 
			"                              <td>일자</td>" + 
			"                              <td>"+ format.format(reserveHistory.getStartDate()) +" ~ " + format.format(reserveHistory.getEndDate()) +"</td>" + 
			"                           </tr>" + 
			"                           <tr>" + 
			"                              <td style=\"padding: 10px 0 10px 0; font-family: Avenir, sans-serif; font-size: 16px; text-align: center\" colspan=\"2\">" + 
			"                                 "+ comment + 
			"                              </td>" + 
			"                           </tr>" + 
			"                            <tr>" + 
			"                                <td style=\"padding: 30px 0 30px 0; font-family: Avenir, sans-serif; font-size: 16px;\" colspan=\"2\">" + 
			"                                    "+ (reserveHistory.getReason()==null? "" : reserveHistory.getReason()) + 
			"                                </td>" + 
			"                            </tr>" + 
			"                        </table>" + 
			"                    </td>" + 
			"                </tr>" + 
			"                <tr>" + 
			"                    <td style=\"padding: 10px 0 10px 0; text-align: center\">" + 
			"					<a href='http://localhost:8000/approval/approvalDetail/"+reserveHistory.getReserveNo()+"'>"+				
			"                  <img src=\"https://postfiles.pstatic.net/MjAxOTA2MjRfMTEw/MDAxNTYxMzUzNjUwOTI2.Dz6ANEJb9Eaur2bxgpp0jRaMhhRhB7B0TMTpCgZRDoEg.eDpg0k169TWXUmKaGxfzZDUvajZnqB_QVIAJ9NPKkC0g.PNG.a_spree/check2.png?type=w773\" " + 
			"                      width=\"200\" />" +
			"					</a>"+
			"                    </td>" + 
			"                </tr>" + 
			"                <tr>" + 
			"					<hr>" +	
			"                    <td style=\"font-size: 10pt; padding: 5px 5px 5px 5px;\">" + 
			"                        <a href=\"#\" target=\"_blank\">" + 
			"                            <img src=\"https://postfiles.pstatic.net/MjAxOTA2MjRfMTQz/MDAxNTYxMzY0NjQ5NDE3.YLu0nhr7FjyrHcImGGZp7Ere0ktUI1yu35J2uodnaxkg.nYQPEQpREjCSjiQyxRADZm4lr20EJigEXkWsSVjmi-Ag.JPEG.a_spree/%EA%B7%B8%EB%A6%BC1.jpg?type=w773\" " + 
			"                                alt=\"Logo\" style=\"width:186px;border:0;\"/>" + 
			"                        </a>" + 
			"						<div style=\"float:left; width:300px;\">조성윤"
			+ "							<div style=\"float:left; width:300px;\">인사지원실 인턴사원</div>"
			+ "							<div style=\"float:left; width:300px;\">Tel: 010-1111-1111</div>"
			+ "							<div style=\"float:left; width:300px;\">Email: whtjddbs@gsitm.com</div>"
			+ "						</div>" +
			"                    </td>" + 
			"                </tr>" + 
			"            </table>" + 
			"        </td>" + 
			"    </tr>" + 
			"</table>" + 
			"</body>" + 
			"</html>";
		return template;
   }
	
	public String getMailTemplate(ApprovalDTO reserve, String comment) {
	    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String template =
			"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">" + 
			"<html xmlns=\"http://www.w3.org/1999/xhtml\">" + 
			"<head>" + 
			"    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"/>" + 
			"    <title></title>" + 
			"    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>" + 
			"</head>" + 
			"<body style=\"margin:0; padding:10px 0 0 0;\" bgcolor=\"#F8F8F8\">" + 
			"<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\">" + 
			"    <tr>" + 
			"        <td align=\"center\">" + 
			"            <table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\"" + 
			"                   style=\"border-collapse: separate; border-spacing: 2px 5px; box-shadow: 1px 0 1px 1px #B8B8B8;\"" + 
			"                   bgcolor=\"#FFFFFF\">" + 
			"                   <tr>" + 
			"                    <td align=\"center\">" + 
			"                        <!-- Initial relevant banner image goes here under src-->" + 
			"                        MBMS" + 
			"                    </td>" + 
			"                </tr>" + 
			"                <tr>" + 
			"                    <td bgcolor=\"#ffffff\" style=\"padding: 40px 30px 40px 30px;\">" + 
			"                        <table border=\"1\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border: 1px #cccccc;\">" + 
			"                           <tr>" + 
			"                              <td>회의 내용</td>" + 
			"                              <td>"+ reserve.getTitle() +"</td>" + 
			"                           </tr>" + 
			"                           <tr>" + 
			"                              <td>회의 장소</td>" + 
			"                              <td>"+ reserve.getRoomDTO().getRoomFloor() +"층 "+ reserve.getRoomDTO().getRoomName() +"</td>" + 
			"                           </tr>" + 
			"                           <tr>" + 
			"                              <td>일자</td>" + 
			"                              <td>"+ format.format(reserve.getStartDate()) +" ~ " + format.format(reserve.getEndDate()) +"</td>" + 
			"                           </tr>" + 
			"                           <tr>" + 
			"                              <td style=\"padding: 10px 0 10px 0; font-family: Avenir, sans-serif; font-size: 16px; text-align: center\" colspan=\"2\">" + 
			"                                 "+ comment + 
			"                              </td>" + 
			"                           </tr>" + 
			"                            <tr>" + 
			"                                <td style=\"padding: 30px 0 30px 0; font-family: Avenir, sans-serif; font-size: 16px;\" colspan=\"2\">" + 
			"                                    "+ (reserve.getReason()==null? "" : reserve.getReason()) + 
			"                                </td>" + 
			"                            </tr>" + 
			"                        </table>" + 
			"                    </td>" + 
			"                </tr>" + 
			"                <tr>" + 
			"                    <td style=\"padding: 10px 0 10px 0; text-align: center\">" + 
			"					<a href='http://localhost:8000/approval/approvalDetail/"+reserve.getReserveNo()+"'>"+				
			"                  <img src=\"https://postfiles.pstatic.net/MjAxOTA2MjRfMTEw/MDAxNTYxMzUzNjUwOTI2.Dz6ANEJb9Eaur2bxgpp0jRaMhhRhB7B0TMTpCgZRDoEg.eDpg0k169TWXUmKaGxfzZDUvajZnqB_QVIAJ9NPKkC0g.PNG.a_spree/check2.png?type=w773\" " + 
			"                      width=\"200\" />" +
			"					</a>"+
			"                    </td>" + 
			"                </tr>" + 
			"                <tr>" + 
			"					<hr>" +	
			"                    <td style=\"font-size: 10pt; padding: 5px 5px 5px 5px;\">" + 
			"                        <a href=\"#\" target=\"_blank\">" + 
			"                            <img src=\"https://postfiles.pstatic.net/MjAxOTA2MjRfMTQz/MDAxNTYxMzY0NjQ5NDE3.YLu0nhr7FjyrHcImGGZp7Ere0ktUI1yu35J2uodnaxkg.nYQPEQpREjCSjiQyxRADZm4lr20EJigEXkWsSVjmi-Ag.JPEG.a_spree/%EA%B7%B8%EB%A6%BC1.jpg?type=w773\" " + 
			"                                alt=\"Logo\" style=\"width:186px;border:0;\"/>" + 
			"                        </a>" + 
			"						<div style=\"float:left; width:300px;\">조성윤"
			+ "							<div style=\"float:left; width:300px;\">인사지원실 인턴사원</div>"
			+ "							<div style=\"float:left; width:300px;\">Tel: 010-1111-1111</div>"
			+ "							<div style=\"float:left; width:300px;\">Email: whtjddbs@gsitm.com</div>"
			+ "						</div>" +
			"                    </td>" + 
			"                </tr>" + 
			"            </table>" + 
			"        </td>" + 
			"    </tr>" + 
			"</table>" + 
			"</body>" + 
			"</html>";
		return template;
   }
	
	/** 예약 시작 30분전 메일알림 **/
	@Scheduled(cron="0 0/30 9-18 * * *")
	@Override
	public boolean reservedMailSend() {
		System.out.println("========= START =========");
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.MINUTE, 30);
		String nextTime = format.format(cal.getTime());
		System.out.println("========="+nextTime+"=========");
		
		// 30분 후 시작하는 예약 목록 조회
		List<Integer> reserveNoList = approvalDAO.selectImminentReserveList2(nextTime);
		System.out.println(reserveNoList);
		for(Integer reserveNo : reserveNoList) {
			System.out.println(reserveNo);
			String email = "";
			List<EmployeeDTO> attendants = approvalDAO.selectMeetingMemberList(reserveNo);
			for (EmployeeDTO employeeDTO : attendants) {
				email += employeeDTO.getEmpEmail()+",";
			}
			
			if(email.length() > 0) {
				email = email.substring(0, email.length()-1);
				this.send("예약된 회의 임박 알림", email, approvalDAO.selectOneApprovalInfo(reserveNo), "잊지말고 참석부탁드립니다.");
			}
		}

		System.out.println("========= END =========");
		return false;
	}
	
	@Async
	public void send(String title, String email, ReserveHistoryDTO reserveHistory, RoomDTO roomDTO, String comment) {

	      String host = "smtp.naver.com";
	      int port = 587;
	      final String username = "jayjoy77@naver.com";
	      final String password = "whtjddbs1";
	      
	      // String recipient = empNo;
	      String content = getMailTemplate(reserveHistory,roomDTO,comment);
	      
	      // 정보를 담기 위한 객체 생성
	      Properties props = System.getProperties();
	      
	      // SMTP 서버 정보 설정
	      props.put("mail.smtp.host", host);
	      props.put("mail.smtp.port", port);
	      props.put("mail.transport.protocol", "smtp");
	      props.put("mail.smtp.auth", "true");
	      props.put("mail.smtp.starttls.enable", "true");
	      props.put("mail.smtp.ssl.trust", host);
	      
	      Session session = Session.getDefaultInstance(props, new Authenticator() {
	         String un = username;
	         String pw = password;
	
	         protected PasswordAuthentication getPasswordAuthentication() {
	            return new javax.mail.PasswordAuthentication(un, pw);
	         }
	      });
	
	      session.setDebug(true);
	      
	      Message mimeMessage = new MimeMessage(session);
	      
	      try {
	         mimeMessage.setFrom(new InternetAddress(username));      
	         mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
	         mimeMessage.setSubject(MimeUtility.encodeText(title, "UTF-8", "B"));
	         mimeMessage.setContent(content, "text/html; charset=utf-8");
	         Transport.send(mimeMessage);
	      } catch (MessagingException e) {
	         e.printStackTrace();
	      } catch (UnsupportedEncodingException e) {
	         e.printStackTrace();
	      }
	
   }
	
	@Async
	public void send(String title, String email, ApprovalDTO reserve, String comment) {

	      String host = "smtp.naver.com";
	      int port = 587;
	      final String username = "jayjoy77@naver.com";
	      final String password = "whtjddbs1";
	      
	      // String recipient = empNo;
	      String content = getMailTemplate(reserve, comment);
	      
	      // 정보를 담기 위한 객체 생성
	      Properties props = System.getProperties();
	      
	      // SMTP 서버 정보 설정
	      props.put("mail.smtp.host", host);
	      props.put("mail.smtp.port", port);
	      props.put("mail.transport.protocol", "smtp");
	      props.put("mail.smtp.auth", "true");
	      props.put("mail.smtp.starttls.enable", "true");
	      props.put("mail.smtp.ssl.trust", host);
	      
	      Session session = Session.getDefaultInstance(props, new Authenticator() {
	         String un = username;
	         String pw = password;
	
	         protected PasswordAuthentication getPasswordAuthentication() {
	            return new javax.mail.PasswordAuthentication(un, pw);
	         }
	      });
	
	      session.setDebug(true);
	      
	      Message mimeMessage = new MimeMessage(session);
	      
	      try {
	         mimeMessage.setFrom(new InternetAddress(username));      
	         mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
	         mimeMessage.setSubject(MimeUtility.encodeText(title, "UTF-8", "B"));
	         mimeMessage.setContent(content, "text/html; charset=utf-8");
	         Transport.send(mimeMessage);
	      } catch (MessagingException e) {
	         e.printStackTrace();
	      } catch (UnsupportedEncodingException e) {
	         e.printStackTrace();
	      }
	
	}

}
