package co.bada.leejava.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import co.bada.leejava.uploadfile.UploadfileService;
import co.bada.leejava.uploadfile.UploadfileVO;
import net.coobird.thumbnailator.Thumbnailator;

/*
 * 공지사항과 배너이미지를 제외한 모든 파일 업로드와 다운로드 로직 구현 (공통)
 */
@Controller
public class FileController {
	@Autowired
	UploadfileService uploadfileDao;
	@Resource(name = "fileUploadPath")
	String fileUploadPath;  // "C:\\leejava\\upload"
	// log 기록
	private static final Logger logger = LoggerFactory.getLogger(FileController.class);
	
	// 첨부파일 업로드
	@ResponseBody
	@PostMapping(value = "ajaxFileUpload.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<UploadfileVO>> ajaxFileUpload(MultipartFile[] uploadFile,
				@RequestParam int fileBoard, @RequestParam int fileBno){
		
		logger.info("====================== 게시판 유형: " + fileBoard);
		logger.info("====================== 게시글 번호: " + fileBno);

		List<UploadfileVO> list = new ArrayList<>();
		
		// 년/월/일 폴더 생성 
		String uploadFolderPath = getFolder();
		
		File uploadPath = new File(fileUploadPath, uploadFolderPath);
		logger.info("upload path: " + uploadPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			// Setter를 위한 DTO 객체 생성.
			UploadfileVO uvo = new UploadfileVO();
			uvo.setFileBoard(fileBoard);								// DTO setter
			uvo.setFileBno(fileBno);									// DTO setter
			String uploadFileName = multipartFile.getOriginalFilename();
			uvo.setFileOriginname(uploadFileName);  					// DTO setter
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" +  uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				uvo.setFileUuid(uuid.toString());						// DTO setter
				uvo.setFileUploadpath(uploadFolderPath);				// DTO setter
				
				// 이미지 파일 검사 
				if(checkImageType(saveFile)) {
					uvo.setFileType(true);								// DTO setter
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					// 뒤의 숫자는 width와 height를 지정하는 파라미터.
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				logger.info("====================uvo 확인: " + uvo);
				// UPLOADFILE 테이블에 INSERT 
				int n = uploadfileDao.uploadfileInsert(uvo);
				logger.info("첨부파일 등록 처리 결과: " + n); 
				// DTO 객체를 브라우저 화면에 리턴시킬 list에 담는다. 
				list.add(uvo);
			} catch (Exception e) {
				logger.info("====================2222222222222222222222222222");
				logger.info(e.getMessage());
			} // end catch 
			
		} // end for
		
		// JSON 데이터로 반환하도록 한다. 
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	// 년/월/일 형식의 업로드 디렉토리 생성
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		// 운영체제에 맞는 경로구분자로 변경시켜준다. 
		return str.replace("-", File.separator);
	}
	
	// 업로드 파일 이미지 타입 여부 검사
	private boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			logger.info("======================contentType의 값: " + contentType);
			// startWith("문자열") => 매개변수로 넘겨지는 문자열로 시작된다면 true를 리턴한다. "image"로 시작하면 true
			return contentType.startsWith("image");
		} catch (IOException e) {
			logger.info("====================11111111111111111");
			e.printStackTrace();
		}
		return false;
	}
	
	
	
}
