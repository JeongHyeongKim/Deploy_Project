package com.gsitm.mbms.room;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.DigestInputStream;
import java.security.InvalidKeyException;
import java.security.KeyManagementException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.TimeZone;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.xml.bind.annotation.adapters.HexBinaryAdapter;

import org.apache.commons.codec.binary.Base64;
import org.apache.maven.artifact.repository.metadata.Metadata;
import org.json.JSONObject;
import org.springframework.web.multipart.MultipartFile;

public class FileSaferScanning {
	
	private Timestamp t;
	private File file;


	public FileSaferScanning(File file) {
		this.file = file;
		//Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
		
		TimeZone tz  = TimeZone.getDefault();
		TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
		Calendar cal = Calendar.getInstance();
		
		this.t = new Timestamp(cal.getTimeInMillis());
		System.out.println(cal.getTime());
	}
	
	public int sendRequest() throws NoSuchAlgorithmException, IOException, KeyManagementException, InvalidKeyException, IllegalStateException {
		String originalURL = "https://filesafer.apigw.ntruss.com/hashfilter/v1/checkHash?hashtype=sha1";
		String bodyHashCode="&hashCode=";
		String fileHash = fileHash(this.file); // 멀티파트로 넘긴다
		bodyHashCode = bodyHashCode+fileHash;
		originalURL = originalURL+bodyHashCode;
		
		
		String command = "curl -X GET \"https://filesafer.apigw.ntruss.com/hashfilter/v1/checkHash?hashCode="+fileHash+"&hashType=sha1\" "
				+ "-H \"accept: application/json\" -H \"x-ncp-apigw-api-key: \" -H \"x-ncp-iam-access-key: \" "
				+ "-H \"x-ncp-apigw-timestamp:"+t.getTime()+" \" "
				+ "-H \"x-ncp-apigw-signature-v2: "+signatureHash(t, fileHash)+"\"";
		Process process = Runtime.getRuntime().exec(command);
		    
		  // Print response from host  
		  InputStream in = process.getInputStream();  
		  BufferedReader reader = new BufferedReader(new InputStreamReader(in));  
		  
		  String line = null;  
		  String buffer= "";
		  while ((line = reader.readLine()) != null) {  
		   System.out.printf("%s\n", line);  
		   buffer = buffer+line;
		  }  
		    
		  reader.close();
		  int getResult = jsonParsing(buffer);
		System.out.println("result : " + getResult);
		return getResult;
	}
	

	
	public String signatureHash(Timestamp t, String hashCode) throws NoSuchAlgorithmException, InvalidKeyException, IllegalStateException, UnsupportedEncodingException { //파일 서명한 x-ncp-signature-v2헤더 작성
		String space = " ";                    // one space
	    String newLine = "\n";                    // new line
	    String method = "GET";                    // method
	    String url = "/hashfilter/v1/checkHash?hashCode="+hashCode+"&hashType=sha1";
	    //long asdf = System.currentTimeMillis();
	    String timestamp = String.valueOf(t.getTime());            // current timestamp (epoch)
	    String accessKey = "";            // access key id (from portal or sub account)
	    String secretKey = ""; //

	    String message = new StringBuilder()
	        .append(method)
	        .append(space)
	        .append(url)
	        .append(newLine)
	        .append(timestamp)
	        .append(newLine)
	        .append(accessKey)
	        .toString();

	    SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes(), "HmacSHA256");
	    Mac mac = Mac.getInstance("HmacSHA256");
	    mac.init(signingKey);

	    byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
	    String encodeBase64String = Base64.encodeBase64String(rawHmac);
	    System.out.println("timestamp : "+timestamp);
	    System.out.println("encode : "+ encodeBase64String);
	    return encodeBase64String;
	}
	
	public String fileHash(File file) throws IOException { //파일의 해쉬 추출 sha-1
		String sha1 = null;
	    MessageDigest digest;
	    try
	    {
	        digest = MessageDigest.getInstance("SHA-1");
	    }
	    catch ( NoSuchAlgorithmException e1 )
	    {
	        throw new IOException( "Impossible to get SHA-1 digester", e1 );
	    }
	    try (InputStream input = new FileInputStream(file);
	         DigestInputStream digestStream = new DigestInputStream( input, digest ) )
	    {
	        while(digestStream.read() != -1){
	            // read file stream without buffer
	        }
	        MessageDigest msgDigest = digestStream.getMessageDigest();
	        sha1 = new HexBinaryAdapter().marshal( msgDigest.digest() );
	    }
	    System.out.println("fileHash : "+sha1);
	    return sha1;
	}
	
	private int jsonParsing(String line) {
		
		JSONObject jsonObject = new JSONObject(line);
		int isVirus =  (int) jsonObject.get("totalRows");
		System.out.println("totalRows : "+isVirus);
		return isVirus;
	}

}
