package co.bada.leejava.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import co.bada.leejava.board.BoardService;
import co.bada.leejava.board.BoardVO;
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
	@Autowired 
	BoardService boardDao;
	
	String fileUploadPath = "C:\\leejava\\upload\\";  
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
		
		if(!uploadPath.exists()) {
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
					FileInputStream fis = new FileInputStream(saveFile);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(fis, thumbnail, 100, 100);
					thumbnail.close();
					fis.close();
				}
				// UPLOADFILE 테이블에 INSERT 
				int n = uploadfileDao.uploadfileInsert(uvo);
				logger.info("첨부파일 등록 처리 결과: " + n); 
				// DTO 객체를 브라우저 화면에 리턴시킬 list에 담는다. 
				list.add(uvo);
			} catch (Exception e) {
				logger.info("이미지 타입 파일 업로드 에러");
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
	
	// 첨부파일 다운로드 
	@PostMapping(value = "boardFileDown.do", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> boardFileDown(HttpServletRequest request, HttpServletResponse response
								, @RequestHeader("User-Agent") String userAgent) {
		String fileName = request.getParameter("fileName");
		String fileuploadpath = request.getParameter("fileUploadpath");
		logger.info("============================= replace 이후:" + fileUploadPath + fileuploadpath + "\\" +fileName);
		
		Resource resource = new FileSystemResource(fileUploadPath + fileuploadpath + "\\" +fileName);
		
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		logger.info("======================= resourceName 확인 : " + resourceName);
		
		// removeUUID
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		HttpHeaders headers = new HttpHeaders();
		try {
			String downloadName = null;
			
			if(userAgent.contains("Trident")) {
				logger.info("IE Browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
			} else if(userAgent.contains("Edge")) {
				logger.info("Edge Browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			} else {
				logger.info("Chrome Browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			logger.info("downloadName : " + downloadName);
			
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	// 자유게시판 수정폼에서 첨부파일 목록 호출
	@ResponseBody
	@GetMapping(value = "ajaxAttachFileList.do", produces = "application/json; charset=UTF-8")
	public ResponseEntity<List<UploadfileVO>> ajaxAttachFileList(UploadfileVO uvo, BoardVO bvo
								, @RequestParam("boardNo") int boardNo
								, @RequestParam("fileBoard") int fileBoard){
		logger.info("================================= boardNo 확인: " + boardNo);
		logger.info("================================= fileBoard 확인: " + fileBoard);
		
		List<UploadfileVO> list = new ArrayList<>();
		
		uvo.setFileBno(boardNo);
		uvo.setFileBoard(fileBoard);
		list = uploadfileDao.uploadfileSelect(uvo);
		logger.info("====================================== list 확인: " + list);
		return new ResponseEntity<List<UploadfileVO>>(list, HttpStatus.OK);
	}
	
	// 자유게시판 수정 페이지 개별 첨부파일 삭제
	@ResponseBody
	@PostMapping(value = "ajaxBoardAttachFileDelete.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> ajaxBoardAttachFileDelete(@RequestBody Map<String,String> inputMap, UploadfileVO uvo, BoardVO bvo){
		logger.info("=================================================== 데이터 확인");
		logger.info("=================================================== fileboard : " + inputMap.get("fileboard"));
		logger.info("=================================================== boardno : " + inputMap.get("boardno"));
		logger.info("=================================================== fileuuid: " + inputMap.get("fileuuid"));
		logger.info("=================================================== fileuploadpath: " + inputMap.get("fileuploadpath"));
		logger.info("=================================================== filetype: " + inputMap.get("filetype"));
		logger.info("=================================================== originname: " + inputMap.get("originname"));
		
		List<UploadfileVO> deleteAttachList = new ArrayList<>();
		uvo.setFileBoard(Integer.parseInt(inputMap.get("fileboard")));
		uvo.setFileBno(Integer.parseInt(inputMap.get("boardno")));
		uvo.setFileOriginname(inputMap.get("originname"));
		uvo.setFileUuid(inputMap.get("fileuuid"));
		uvo.setFileUploadpath(inputMap.get("fileuploadpath"));
		uvo.setFileType( inputMap.get("filetype").equals("true") ? true : false);
		deleteAttachList.add(uvo);
		
		// 실제 파일 삭제(썸네일 이미지 포함)
		deleteFiles(deleteAttachList);
		
		// board테이블 update, uploadfile테이블 delete(row 한 개) 
		int n = uploadfileDao.uploadfileDeleteOne(uvo);
		if(n == 1) {
			// board 테이블도 수정
			bvo.setBoardNo(Integer.parseInt(inputMap.get("boardno")));
			int modifiedBfileCheck = boardDao.boardSelect(bvo).getBfileCheck() -1; 
			bvo.setBfileCheck(modifiedBfileCheck);
			int m = boardDao.boardUpdate(bvo);
			if(m == 1) {
				return new ResponseEntity<String>("success ~~~", HttpStatus.OK);
			} else {
				return new ResponseEntity<String>("fail to update bfilecheck", HttpStatus.BAD_REQUEST);
			}
		} else {
			return new ResponseEntity<String>("fail to delete uploadfile row data", HttpStatus.BAD_REQUEST);
		}
	}
	
	// 실제 로컬 디렉토리에서 파일 삭제
	public void deleteFiles(List<UploadfileVO> deleteAttachList) {
		
		logger.info("=================================== attachList: " + deleteAttachList);
		// fileUploadPath  C:\\leejava\\upload\\ 경로 정보 담고 있음.
		deleteAttachList.forEach(attach -> {
			try {
				Path file = Paths.get(fileUploadPath + attach.getFileUploadpath() + "\\" + 
						attach.getFileUuid() + "_" + attach.getFileOriginname());
				System.out.println("file 정보: " + file);
				boolean b = Files.deleteIfExists(file);
				System.out.println("delteFiles 메서드에서 파일 삭제 성공? : " + b);
				
				if(Files.probeContentType(file).startsWith("image")) {
					System.out.println("썸네일 이미지 파일도 존재");
					Path thumbNail = Paths.get(fileUploadPath + attach.getFileUploadpath() + "\\s_" + 
							attach.getFileUuid() + "_" + attach.getFileOriginname());
					System.out.println("썸네일 file정보: " + thumbNail);
					Files.delete(thumbNail);
				}
				
			} catch(Exception e) {
				logger.error("delete file error" + e.getMessage());
			} // end catch
		}); // end forEach
	}
	
}
