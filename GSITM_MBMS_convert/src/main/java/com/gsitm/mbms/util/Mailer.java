package com.gsitm.mbms.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.InvalidKeyException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.TimeZone;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


public class Mailer {
	
	public Timestamp t;
	
	public Mailer() {
		TimeZone tz  = TimeZone.getDefault();
		TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
		Calendar cal = Calendar.getInstance();
		
		this.t = new Timestamp(cal.getTimeInMillis());
		System.out.println(cal.getTime());
	}

	public void sendEmail() throws NoSuchAlgorithmException, IOException, KeyManagementException, InvalidKeyException, IllegalStateException {
		String timestamp = String.valueOf(t.getTime());
        
        try {
            String apiURL = "https://mail.apigw.ntruss.com/api/v1/mails";
            
            String body = "{\"senderAddress\":\"email insert\","
        		+ "\"title\":\" [] Your reservation is complete.\","
        		+ "\"body\":\" ${customer_name} Your reservation is complete! Detailed information is as follows. \","
        		+ "\"recipients\":[{\"address\":\"please insert email here\","
        		+ "\"name\":\"null\",\"type\":\"R\","
        		+ "\"parameters\":{\"customer_name\":\" \"}}],"
        		+ "\"individual\":true,"
        		+ "\"advertising\":false}\r\n ";

            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
            con.setRequestProperty("x-ncp-iam-access-key", "access key");
            con.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature(t));
            con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            
            wr.writeBytes(body);
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
            }

            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());

        } catch (Exception e) {
            System.out.println(e);
        }
    }
	
	public void sendAlarmEmail() throws NoSuchAlgorithmException, IOException, KeyManagementException, InvalidKeyException, IllegalStateException {
		String timestamp = String.valueOf(t.getTime());
        
        try {
            String apiURL = "https://mail.apigw.ntruss.com/api/v1/mails";
            
            String body = "{\"senderAddress\":\"email\","
        		+ "\"title\":\" [] Meeting notification \","
        		+ "\"body\":\" ${customer_name} The meeting will begin in half an hour. Don't forget to attend. \","
        		+ "\"recipients\":[{\"address\":\"email\","
        		+ "\"name\":\"null\",\"type\":\"R\","
        		+ "\"parameters\":{\"customer_name\":\" \"}}],"
        		+ "\"individual\":true,"
        		+ "\"advertising\":false}\r\n ";

            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
            con.setRequestProperty("x-ncp-iam-access-key", "");
            con.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature(t));
            con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            
            wr.writeBytes(body);
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
            }

            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());

        } catch (Exception e) {
            System.out.println(e);
        }
    }
	
    
    public String makeSignature(Timestamp t) throws NoSuchAlgorithmException, InvalidKeyException, UnsupportedEncodingException {
	    String space = " ";  // 공백
	    String newLine = "\n";  // 줄바꿈
	    String method = "POST";  // HTTP 메소드
	    String url = "/api/v1/mails";  // 도메인을 제외한 "/" 아래 전체 url (쿼리스트링 포함)
	    String timestamp = String.valueOf(t.getTime());  // 현재 타임스탬프 (epoch, millisecond)
	    String accessKey = "";  // access key id (from portal or sub account)
	    String secretKey = "";  // secret key (from portal or sub account)
	
	    String message = new StringBuilder()
	        .append(method)
	        .append(space)
	        .append(url)
	        .append(newLine)
	        .append(timestamp)
	        .append(newLine)
	        .append(accessKey)
	        .toString();
	
	    SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
	    Mac mac = Mac.getInstance("HmacSHA256");
	    mac.init(signingKey);
	
	    byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
	    String encodeBase64String = Base64.encodeBase64String(rawHmac);
	    
	    System.out.println("timestamp : "+timestamp);
	    System.out.println("encode : "+ encodeBase64String);
	    
	    return encodeBase64String;
	}
    
}
