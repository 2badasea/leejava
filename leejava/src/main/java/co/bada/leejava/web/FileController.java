package co.bada.leejava.web;

import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import co.bada.leejava.uploadfile.UploadfileService;
import co.bada.leejava.uploadfile.UploadfileVO;

/*
 * 공지사항과 배너이미지를 제외한 모든 파일 업로드와 다운로드 로직 구현 (공통)
 */
@Controller
public class FileController {
	@Autowired
	UploadfileService uploadfileDao;
	@Resource(name = "fileUploadPath")
	String fileUploadPath;  // "C:\\leejava\\uoloadFile\\"
	
	// 첨부파일 업로드
	@ResponseBody
	@PostMapping(value = "ajaxFileUpload.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> ajaxFileUpload(MultipartFile[] uploadFile, UploadfileVO uvo){
		
		
		
		for(MultipartFile multipartFile : uploadFile) {
			System.out.println("==========================");
			String whatB_uuid = UUID.randomUUID().toString();
			System.out.println("upload 파일이름: " + multipartFile.getOriginalFilename());
			System.out.println("upload 파일 사이즈: " + multipartFile.getSize());
		}
		
		String message = "OK";
		return new ResponseEntity<String>(message, HttpStatus.OK);
	}
	
}
