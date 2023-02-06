package co.bada.leejava.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import co.bada.leejava.Search;
import co.bada.leejava.notice.NoticeService;
import co.bada.leejava.notice.NoticeVO;

@Controller
public class NoticeController {
	@Autowired
	NoticeService noticeDao;
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	// 에디터 이미지 업로드 경로.
	@Resource(name = "summernoteImageUploadPath")
	private String summernoteImageUploadPath; 
	// 공지사항 업로드 파일 경로
	@Resource(name = "noticeUploadPath")  
	private String noticeUploadPath;
	
	// 공지사항 리스트 이동
	@RequestMapping("/adminNoticeList.do")
	public String adminNoticeList(Model model
			,@RequestParam(required = false, defaultValue = "1") int page
			,@RequestParam(required = false, defaultValue = "1") int range
			,@RequestParam(required = false, defaultValue = "all") String n_category
			,@RequestParam(required = false) String n_title 
			,@RequestParam(required = false) String n_content
			,@RequestParam(required = false) String n_writer
			,Search svo
		) throws Exception {
		
		model.addAttribute("search", svo);
		
		svo.setN_category(n_category);
		svo.setN_title(n_title);
		svo.setN_content(n_content);
		svo.setN_writer(n_writer);
		
		int listCnt = noticeDao.getNoticeListCnt(svo);

		svo.pageinfo(page, range, listCnt);
		List<NoticeVO> list = noticeDao.noticeSearchSelect(svo);
		
		model.addAttribute("pagination", svo); // 페이징 처리 
		model.addAttribute("notice", list); // 기존의 공지사항 리스트 대신
		
		return "home/admin/adminNoticeList";
	}

	// 공지사항 작성폼 이동
	@RequestMapping("/noticeRegisterForm.do")
	public String noticeRegisterForm(Model model) {

		return "home/admin/noticeForm";
	}

	// 써머노트 이미지 업로드 ajax 콜백함수 부분
	@ResponseBody
	@RequestMapping(value = "/ajaxUploadSummernoteImageFile.do", produces = "application/json; charset=utf8")
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request) {
		
		JsonObject jsonObject = new JsonObject();
		// C:\leejava\summernoteimageupload
//		String contextRoot = request.getSession().getServletContext().getRealPath("/");
//		logger.info("================contextRoot 확인 => " + contextRoot);
		
		String fileRoot = "C:\\leejava\\summernoteimageupload\\";
		String originalFileName = multipartFile.getOriginalFilename(); 
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
		String savedFileName = UUID.randomUUID() + extension; // 물리적으로 저장될 이미지 파일명
		
		File targetFile = new File(fileRoot + savedFileName);
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);
			jsonObject.addProperty("url", fileRoot + savedFileName); 
			jsonObject.addProperty("responseCode", "success");
			logger.info("===============targetFile의 정체: " + targetFile);
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); 
			logger.info("예외처리가 되었나?");
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}  
		String responseData = jsonObject.toString();
		return responseData;
	}

	// 공지사항 등록하기( 첨부파일 업로드 작업도 포함)
	@RequestMapping("/noticeRegister.do")
	public String noticeRegister(Model model, HttpSession session, HttpServletRequest request, NoticeVO nvo 
					, @RequestParam(value = "filename", required = false) MultipartFile file ) throws Exception {

		// 첨부파일 업로드 작업
		String n_file = "";
		String n_pfile = "";
		if(!file.isEmpty()) {
			n_file = file.getOriginalFilename(); 
			// 물리파일 생성.
			n_pfile = uploadFile(n_file, file.getBytes(), request); 
		} 
		nvo.setN_file(n_file);
		nvo.setN_pfile(n_pfile);
		
		String n_writer = (String) session.getAttribute("session_nickname");
		String n_category = request.getParameter("n_category");
		String n_title = request.getParameter("n_title");
		String n_content = request.getParameter("n_content");
		int n_hit = 0;
		String n_fixed = "F";

		// vo객체에 실어서 보내기, 글번호와 작성일은 notice-map.xml에서 해결.
		nvo.setN_writer(n_writer);
		nvo.setN_category(n_category);
		nvo.setN_title(n_title);
		nvo.setN_content(n_content);

		nvo.setN_hit(n_hit);
		nvo.setN_fixed(n_fixed);
		int n = noticeDao.noticeInsert(nvo);
		if (n != 0) {
			logger.info("===============Notice Insert Success");
		} else {
			logger.info("===============Fail to insert notice");
		}
		return "redirect:adminNoticeList.do";
	}

	// 첨부파일 업로드 작업 메소드 upLoadFile(() 정의
	private String uploadFile(String originalName, byte[] fileData, HttpServletRequest request) throws Exception {
		UUID uuid = UUID.randomUUID();
		// 로컬경로(C:\leejava\noticeuploadfiles\ )
		String SAVE_PATH = noticeUploadPath; 
		String savedName = uuid.toString() + "_" + originalName; 
		File target = new File(SAVE_PATH, savedName); 
		FileCopyUtils.copy(fileData, target);
		return savedName;
	}
	
	// 첨부파일 다운로드 로직 구현하기
	@RequestMapping("/noticeFileDownload.do")
	public void noticeFileDownload(Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// root-context.xml에 <bean>으로 정의해놓은 경로가 있음. 등록했던 <bean>의 id값이 "noticeUploadPath"을 컨트롤러 상단에 @autowired 
		String SAVE_PATH = noticeUploadPath;
		// 원본파일명
		String filename = request.getParameter("filename"); 
		String encodingFilename = ""; // 원본명으로 다운받기 위함.
		String realFilename = ""; // 실제 경로와 물리적 파일이름이 매핑될 곳
		String pfilename = request.getParameter("pfilename");
		System.out.println("================ filename: " + filename);
		System.out.println("================ pfilename: " + pfilename);
		try {
			String browser = request.getHeader("User-Agent");
			// 파일 인코딩
			if (browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")) {
				encodingFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
			} else {
				encodingFilename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
			}
		} catch (UnsupportedEncodingException ex) {
			logger.info("===============UnsupportedEncodingException");
		}
		// 경로+물리파일명 => 해당 데이터정보를 통해 File객체를 생성하여, 입출력스트림을 생성하여 다운로드를 구현한다. 
		realFilename = SAVE_PATH + pfilename;
		logger.info("===============3. realfilename: " + realFilename);
		logger.info("===============4. encodingFilename: " + encodingFilename);
		File file = new File(realFilename); // 해당 경로의 물리파일을 대상으로 파일객체 생성
		if (!file.exists()) {
			// 해당 대상 파일이 정상적으로 존재하지 않으면 return된다. 
			logger.info("===============존재유무 확인 ~=================");
			return;
		}
		// 파일명 지정
		response.setContentType("application/octer-stream");
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Content-Disposition", "attachmeent; filename=\"" + encodingFilename + "\"");
		
		try {
			// response객체(응답 객체)가 요청한 파일을 클라이언트에게 전달해주기 위한 출력스트림 생성
			OutputStream os = response.getOutputStream();
			// 현재 경로에 있는 파일을 가져올 입력스트림 생성. 입력스트림으로 받은 후 출력스트림으로 유저에게 전해준다.
			FileInputStream fis = new FileInputStream(realFilename);

			int ncount = 0;
			byte[] bytes = new byte[512];

			// -1이면 더이상 읽어들일 게 없다는 것. => 다 읽어들였다는 의미.
			while ((ncount = fis.read(bytes)) != -1) {
				// 출력스트림 시작 => 실제 유저 '다운로드' 폴더에 해당 파일이 생성되기 시작하는 부분
				os.write(bytes, 0, ncount);
			}
			// 입출력 스트림 닫아주고 끝
			fis.close();
			os.close();
		} catch (Exception e) {
			logger.info("===============FileNotFoundException : " + e);
		}
	}
	// 관리자 공지사항 조회
	@RequestMapping("/adminNoticeRead.do")
	public String adminNoticeRead(Model model, @RequestParam("n_no") int n_no, NoticeVO nvo) {

		nvo.setN_no(n_no);
		nvo = noticeDao.noticeSelect(nvo);
		if (nvo != null) {
		} else {
			logger.info("===============글조회 오류");
			return "redirect:adminNoticeList.do";
		}
		model.addAttribute("notice", nvo);
		return "home/admin/noticeRead";
	}

	// 공지사항 수정페이지 이동
	@RequestMapping("/noticeFormUpdate.do")
	public String noticeFormUpdate(Model model, NoticeVO nvo,
				@RequestParam("n_no") int n_no) {

		nvo.setN_no(n_no);
		nvo = noticeDao.noticeSelect(nvo);
		if (nvo == null) {
			logger.info("===============글번호 조회 실패");
			return "redirect:adminNoticeList.do";
		} 
		// 조회 성공 시
		model.addAttribute("notice", nvo);
		return "home/admin/noticeUpdateForm";
	}

	// 공지사항 수정한 것 등록 => <form>값으로 넘기지 않아도 스크립트 단에서 FormData()객체를 생성해서 해당 객체를 통해 전달 => @RequestBody
	@RequestMapping("/noticeUpdate.do")
	public String noticeUpdate(Model model, HttpServletRequest request, NoticeVO nvo
			,@RequestParam(value = "n_no") int n_no
			,@RequestParam(value = "filename", required = false) MultipartFile file) throws Exception {

		String n_message = request.getParameter("n_message");
		String n_title = request.getParameter("n_title");
		String n_category = request.getParameter("n_category");
		String n_content = request.getParameter("n_content");

		nvo.setN_no(n_no);
		if(n_message != "") {
			// 단순히 DB값(원본, 물리) null로 처리 => 실제 해당 경로 파일 삭제도 고민해야 함.
			noticeDao.ajaxNoticeFileDelete(nvo);
		}
		// 새로운 첨부파일 업로드 작업하기
		if (file.getSize() != 0) {
			String n_file = file.getOriginalFilename(); // 원본파일명
			logger.info("===============첨부파일 원본명 최종 확인: " + n_file);
			// 중복 가공된 파일. 실제 물리파일.
			if(n_file != null) {
				// 원본파일명이 공백("")이라도 물리파일명은 생성되었다 => 
					//그래서 원본파일명이 공백이 아닌, 실제 file에 담겼을 때만 물리파일명을 생성하고 nvo객체에 담는다. 
				String n_pfile = uploadFile(n_file, file.getBytes(), request);
				logger.info("===============물리파일명 확인: " + n_pfile);
				// 첨부한 파일이 존재했다면, 해당 파일들을 담는다.
				nvo.setN_file(n_file);
				nvo.setN_pfile(n_pfile);
			}
		}

		// 총 5개를 vo객체에 담아서 update 매퍼구분으로 이동시킨다.
		nvo.setN_title(n_title);
		nvo.setN_category(n_category);
		nvo.setN_content(n_content);

		int n = noticeDao.noticeUpdate(nvo);
		if (n != 0) {
			logger.info("===============업데이트 성공");
		} else {
			logger.info("===============업데이트 실패");
		}
		return "redirect:adminNoticeList.do";
	}

	// 공지사항 개별 삭제 by ajax
	@ResponseBody
	@RequestMapping("/noticeDelete.do")
	public String noticeDelete(Model model, HttpServletRequest request, NoticeVO nvo
			, @RequestParam("n_no") int n_no) {

		logger.info("===============개별 삭제할 글 번호 왔니? : " + n_no);
		nvo.setN_no(n_no);
		String message = null;
		int n = noticeDao.noticeDelete(nvo);
		if (n != 0) {
			logger.info("===============게시글 삭제 성공 (controller) ");
			message = "YES";
		}
		return message;
	}

	// 공지사항 개별 고정 처리
	@ResponseBody
	@RequestMapping("/ajaxNoticeFixed.do")
	public String ajaxNoticeFixed(Model model, HttpServletRequest request, NoticeVO nvo
			,@RequestParam("n_no") int n_no
			,@RequestParam("n_fixed") String n_fixed) {

		logger.info("===============글번호: " + n_no + "수정할 고정 값: " + n_fixed);

		nvo.setN_fixed(n_fixed);
		nvo.setN_no(n_no);
		int n = noticeDao.ajaxNoticeFixed(nvo);
		String message = null;
		if (n != 0) {
			logger.info("===============수정 성공");
			message = "YES";
		}
		return message;
	}

	// 공지사항 선택 삭제
	@ResponseBody
	@RequestMapping("/ajaxNoticeSelectDelete.do")
	public String ajaxNoticeSelectDelete(NoticeVO nvo
			// ajax를 통해서 받은 배열형태의 데이터 => List형 자료구조에 담는다. 그리고 각 데이터는 String타입. 
			,@RequestParam("checkedArray[]") List<String> checkedArray) {
		logger.info("==============삭제할 글번호(data-value) 값들이 담긴 List형 배열 checkArray : " + checkedArray);
		
		String message = null;
		int n_no;
		
		// 향상된(forEach)for문 => 해당 배열에 담겨있는 요소 수만큼 루핑을 반복한다.
		for (String i : checkedArray) {
			n_no = Integer.parseInt(i);
			nvo.setN_no(n_no);
			noticeDao.noticeDelete(nvo);
			message = "YES";
		}
		return message;
	}
}
