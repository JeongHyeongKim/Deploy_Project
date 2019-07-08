package com.gsitm.meeting.util;

import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.gsitm.meeting.branch.service.BranchService;
import com.gsitm.meeting.room.service.MeetingRoomService;

@Service
public class FileUploadService { 
	
	@Autowired
	private BranchService brService;
	//https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/context/support/FileSystemXmlApplicationContext.html
	//다음 주소에서 프로젝트 갱신을 할 수 있을 것 같다.
	@Autowired
	private MeetingRoomService mrService;
	
	//할일 리스트
	//1. 사진 폼에 올리면 그 사진으로  form이 바뀌며, 디폴트 사진을 다른 것으로 대체
	//2. list에서 커서 색깔 제대로 잘 안바뀌는 오류 해결 요망
	//3. 파일 올리기 했으면 파일 삭제하는 것도 해야지.
	//4. 역시 바꿔치기도 해야지.->완료
	public String restore(MultipartFile multipartFile, String absoluteURL, String object) { // 만들 객체마다 다른 기능을 써야한다.
		String url = null;
		
		try {
			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			String extName= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();
			
			// 서버에서 저장 할 파일 이름
			String saveFileName = genSaveFileName(extName, object); // 경로 뺀 완벽한 파일 이름 ex) brImg1.jpg
			
			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("size : " + size);
			System.out.println("saveFileName : " + saveFileName);
			
			writeFile(multipartFile, saveFileName,absoluteURL, object);
			url = absoluteURL +object+"/"+saveFileName;
		}
		catch (IOException e) {
			throw new RuntimeException(e);
		}
		return url;
	}
	
	public void restoreUpdate(MultipartFile multipartFile, String absoluteURL, String object, String brId) {
		System.out.println("restoreUpdate is start!");
		//올라온 파일이 없을 때, 이를 컨트롤 하는 부분도 만들어야함!
		
		String originFilename = multipartFile.getOriginalFilename();
		//등록된 파일은 없지만, 넘어올때 multipartFile이 null이 아니므로 파일 이름을 기반으로 파일 update처리가 되었는지 체크한다.
		if(!originFilename.equals("")) {
			System.out.println("originFilename : " + originFilename);
			String extName= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());//확장자
			Long size = multipartFile.getSize();
			
			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName); //.jpg
			System.out.println("size : " + size);
			
			System.out.println(brService.branchOne(brId).getBrImg());
			String relativeURL = brService.branchOne(brId).getBrImg().split("branch/")[1];
			System.out.println(relativeURL);
			relativeURL = relativeURL.split("\\.")[0]; // DB에 저장되어 있던 확장자를 뺀 원래 파일 명
			// 서버에서 저장 할 파일 이름
			String saveFileName = relativeURL+extName;
			
			
			System.out.println("saveFileName : " + saveFileName);
			System.out.println("branch object system location : "+brService.branchOne(brId).getBrLocation());
			
			try {
				writeFile(multipartFile, saveFileName,absoluteURL, object);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	
	// 회의실 create 미반영
	private String genSaveFileName(String extName, String object) { //.~~~으로 확장자만 불러온다.
		
		String fileName = "";
		int recentId = 0;
		
		if(object.equals("branch")) {
			fileName="brImg";
			recentId = brService.branchGetRecentImgId();
		}
		else if(object.equals("meetingroom")){
			fileName="mrImg";
			recentId=mrService.meetingRoomGetRecentImgId();
		}
		fileName += recentId+extName;
		return fileName;
	}
	
	
	// 파일을 실제로 write 하는 메서드
	private boolean writeFile(MultipartFile multipartFile, String saveFileName, String absoluteURL,String object)
								throws IOException{
		boolean result = false;

		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(absoluteURL + "/" +object+"/"+ saveFileName);
		fos.write(data);
		fos.close();
		
		return result;
	}

}
