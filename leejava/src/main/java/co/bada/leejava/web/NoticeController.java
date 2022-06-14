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

	// summernote image upload 경로 bean 등록 root-context.xml에 등록했음.
	@Resource(name = "summernoteImageUploadPath")
	private String summernoteImageUploadPath; // 이 이름으로 업로드 경로 사용
	// 공지사항 첨부파일 업로드 경로 bean 등록 root-context.xml에 설정함.
	@Resource(name = "noticeUploadPath")
	private String noticeUploadPath;

	// 관리자 공지사항 페이지로 이동. 검색요소로는 작성자(n_writer), 카테고리(n_category), 제목, 내용
	@RequestMapping("/adminNoticeList.do")
	public String adminNoticeList(Model model,
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range,
			@RequestParam(required = false, defaultValue = "all") String n_category,
			@RequestParam(required = false) String n_title, @RequestParam(required = false) String n_content,
			@RequestParam(required = false) String n_writer, Search svo) throws Exception {

		model.addAttribute("search", svo);
		svo.setN_category(n_category);
		svo.setN_title(n_title);
		svo.setN_content(n_content);
		svo.setN_writer(n_writer);

		// 페이징Info를 위해서 구한다. 총 게시글 갯수.
		int listCnt = noticeDao.getNoticeListCnt(svo);

		// Search클래스의 객체 svo 자체가 부모클래스 Paging을 extends하고 있기 때문에 svo로 접근가능.
		// 현재 페이지, 현재 속한 페이지 범위, 총 게시글 갯수를 인자로 가진다.
		svo.pageinfo(page, range, listCnt);

		List<NoticeVO> list = noticeDao.noticeSearchSelect(svo);
		// 굳이 안 해줘도 될 듯. '마으미' 프로젝트에선 date의 길이가 10을 넘었던 것 같다. 
//		for (int i = 0; i < list.size(); i++) {
//			String date = list.get(i).getN_wdate();
//			date = 	date.substring(0, 10);
//			list.get(i).setN_wdate(date);
//		}
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

		/*
		 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
		 */

		// 내부경로로 저장하는 경우. => 난 bean에 등록한 외부경로를 사용
//		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/"); // 말그대로 root경로 '/' 를 의미한다.
		String contextRoot = request.getServletContext().getRealPath(""); // webapp경로 가리키는 곳 말그대로 root경로 '/' 를 의미한다.
		String fileRoot = contextRoot + "resources/summernoteimage/";
//		String fileRoot = summernoteImageUploadPath;  외부이미지 경로, 일단 다음에 도전

		String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
		// substring의 경우, 대상 인덱스 위치의 문자부터 '포함해서' 그 뒤의 문자까지 통째로 리턴한다.
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
		String savedFileName = UUID.randomUUID() + extension; // 물리적으로 저장될 이미지 파일명

		// file 객체 생성. 설정한 경로와 파일이름으로 파일을 생성해줄 객체.
		File targetFile = new File(fileRoot + savedFileName);
		try {
			// 스트림 생성. 내가 summernote이미지 업로드한 것을 읽어줄 스트림
			InputStream fileStream = multipartFile.getInputStream();
			// 실제 경로에 파일 저장이 시작되는 부분
			FileUtils.copyInputStreamToFile(fileStream, targetFile);
			// 이클립스 내부경로로 사용했을 때의 경로명.
//			jsonObject.addProperty("url", "/resources/summernoteimage/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
			// 실제 톰캣 경로. summernote 이미지를 업로드 하면 이쪽 공간에 저장된다.
			jsonObject.addProperty("url", fileRoot + savedFileName); // contextroot + resources + 저장할 내부 폴더명
//			jsonObject.addProperty("url", summernoteImageUploadPath + savedFileName); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("responseCode", "success");
			System.out.println("targetFile의 정체: " + targetFile);
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); // 실패했을 경우 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String responseData = jsonObject.toString();
		System.out.println("responseData 확인: " + responseData);
		return responseData;
	}

	// 공지사항 등록하기( 첨부파일 업로드 작업도 포함)
	@RequestMapping("/noticeRegister.do")
	public String noticeRegister(Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, NoticeVO nvo, @RequestParam("filename") MultipartFile file) throws Exception {
		// vo객체에 실어야 하는 것: 작성자, 카테고리, 제목, 내용, 첨부파일명, 물리파일명, 조회수, 고정여부
		System.out.println("제목 들어왔니? " + request.getParameter("n_title"));
		System.out.println("카테고리 들어왔니? " + request.getParameter("n_category"));
		System.out.println("내용 들어왔니? : " + request.getParameter("n_content"));
		System.out.println("@requestparam 첨부파일 이름이랑 같니? " + file);

		// 첨부파일 업로드 작업
		String n_file = file.getOriginalFilename(); // 원본파일명
		System.out.println("첨부파일 이름 확인: " + n_file);
		String n_pfile = null; // 중복 가공된 파일. 실제 물리파일.
		if (n_file != "") { // 첨부한 게 없다면 pfilename컬럼에 값이 안 들어가도록.
			n_pfile = uploadFile(n_file, file.getBytes(), request); // 첨부파일명 랜덤생성하는 메소드. 밑에 정의되어 있음.
		}
		System.out.println("물리파일명 확인: " + n_pfile);

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
		nvo.setN_file(n_file);
		nvo.setN_pfile(n_pfile);
		nvo.setN_hit(n_hit);
		nvo.setN_fixed(n_fixed);
		int n = noticeDao.noticeInsert(nvo);
		if (n != 0) {
			System.out.println("공지사항 등록 성공~");
		} else {
			System.out.println("설마 ㅋㅋ?");
		}
		// 이건 테스트용. 일반 resolver경로가 아닌 redirect를 하더라도 model값이 넘어가는지.
		model.addAttribute("n_file", n_file);

		return "redirect:adminNoticeList.do";
	}

	// 첨부파일 업로드 작업 메소드 upLoadFile(() 정의
	private String uploadFile(String originalName, byte[] fileData, HttpServletRequest request) throws Exception {
		// uuid 생성
		UUID uuid = UUID.randomUUID();
		// 업로드 경로의 경우, 로컬로 해보았다. 기존코드는 주석처리
//		String SAVE_PATH = uploadpath + "/noticeattach/"; //webapp 아래부터 경로를 작성
		String SAVE_PATH = noticeUploadPath; // 로컬경로(C:\leejava\noticeuploadfiles\ ). 이건 외부경로로 설정했다.
		// 랜덤생성 + 파일이름 저장
		String savedName = uuid.toString() + "_" + originalName; // 가공된 파일이름.
		File target = new File(SAVE_PATH, savedName); // 가공된 파일이름을 servlet-context.xml에 등록한 bean의 경로에 저장.
		// 임시디렉토리에 저장된 업로드된 파일을 지정된 디렉토리로 복사. 실제 프로젝트 시연할 때는 uploadPath 의 경로를 변경해야 함(
		// servlet-context.xml)
		FileCopyUtils.copy(fileData, target);
		return savedName;
	}
	// logger.info 메서드를 통해 로그기록 봐야 한다.
	// 첨부파일 다운로드 로직 구현하기
	@RequestMapping("/noticeFileDownload.do")
	public void noticeFileDownload(Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String SAVE_PATH = noticeUploadPath;
		String filename = request.getParameter("filename"); // noticeRead.jsp에서 get방식으로 보낸 name속성값이 filename임.
		String encodingFilename = ""; // 원본명으로 다운받기 위함.
		System.out.println("1. filename: " + filename);
		String realFilename = ""; // 실제 경로와 물리적 파일이름이 매핑될 곳

		String pfilename = request.getParameter("pfilename"); // noticeRead.jsp에서 get방식으로 보냄
		System.out.println("pfilename 확인 : " + pfilename);

		try {
			String browser = request.getHeader("User-Agent");
			// 파일 인코딩
			if (browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")) {
				encodingFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
			} else {
				encodingFilename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
			}
		} catch (UnsupportedEncodingException ex) {
			System.out.println("UnsupportedEncodingException");
		}
		realFilename = SAVE_PATH + pfilename;
		System.out.println("3. realfilename: " + realFilename);
		File file = new File(realFilename); // 해당 경로의 물리파일을 대상으로 파일객체 생성
		if (!file.exists()) {
			// 해당 대상 파일이 정상적으로 존재하는 경우
			System.out.println("존재유무 확인 ~=================");
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
			System.out.println("FileNotFoundException : " + e);
		}
	}
	// 관리자 공지사항 조회
	@RequestMapping("/adminNoticeRead.do")
	public String adminNoticeRead(Model model, @RequestParam("n_no") int n_no, NoticeVO nvo) {

		System.out.println("글번호 값 들어왔니? : " + n_no);
		nvo.setN_no(n_no);
		nvo = noticeDao.noticeSelect(nvo);
		if (nvo != null) {
			System.out.println("글조회 성공~");
		} else {
			System.out.println("글조회 실패;;");
			return "redirect:adminNoticeList.do";
		}
		model.addAttribute("notice", nvo);
		return "home/admin/noticeRead";
	}

	// 공지사항 수정페이지 이동
	@RequestMapping("/noticeFormUpdate.do")
	public String noticeFormUpdate(Model model, HttpServletRequest request, NoticeVO nvo,
			@RequestParam("n_no") int n_no) {

		System.out.println("글번호 들어왔니?" + n_no);
		nvo.setN_no(n_no);
		nvo = noticeDao.noticeSelect(nvo);
		if (nvo != null) {
			System.out.println("성공여부 판단 후 삭제.");
		} else {
			System.out.println("글번호 조회 실패");
			return "redirect:adminNoticeList.do";
		}
		model.addAttribute("notice", nvo);
		return "home/admin/noticeUpdateForm";
	}

	// 공지사항 수정한 것 등록 //
	@RequestMapping("/noticeUpdate.do")
	public String noticeUpdate(Model model, HttpServletRequest request, NoticeVO nvo,
			@RequestParam(value = "filename", required = false) MultipartFile file) throws Exception {

		// 수정폼에서 넘어오는 것 => n_title, n_category, n_content, file
		// 위 4개는 값 확인 후, vo객체에 담아서 noticeDao.noticeUpdate()를 실행.
		// 첨부파일 업로드 로직 구현하고 => 물리파일 생성 후 => 2개 모두 db상에서 변경 => 총 5개 변경.
		String n_title = request.getParameter("n_title");
		String n_category = request.getParameter("n_category");
		String n_content = request.getParameter("n_content");

		System.out.println("수정할 제목 들어왔니? " + n_title);
		System.out.println("수정할 카테고리 값 들어왔니? " + n_category);
		System.out.println("수정할 내용은 들어왔니? " + n_content);
		System.out.println("@requestparam 첨부파일 이름이랑 같니? " + file);

		// 새로운 첨부파일 업로드 작업하기
		// 첨부파일 업로드 작업.
		// form에서 값이 넘어왔을 때만 vo객체에 담는다.
		if (file != null) {
			String n_file = file.getOriginalFilename(); // 원본파일명
			System.out.println("첨부파일 원본명 최종 확인: " + n_file);
			// 중복 가공된 파일. 실제 물리파일.
			String n_pfile = null;
			// 업로드한 파일이 없다면 물리파일명 안 만들도록. 업로드한 파일이 있으면 물리파일 생성
			if (n_file != "") {
				// 원본명을 바탕으로 물리명을 생성하는 작업. 구현 메서드는 위쪽에 구현되어 있음.
				n_pfile = uploadFile(n_file, file.getBytes(), request);
				System.out.println("물리파일명 확인: " + n_pfile);
				// 업로드한 파일과 물리적으로 가공된 파일이 존재하면 vo객체에 담는다.
				nvo.setN_file(n_file);
				nvo.setN_pfile(n_pfile);
			}
		}

		// 총 5개를 vo객체에 담아서 update 매퍼구분으로 이동시킨다.
		nvo.setN_title(n_title);
		nvo.setN_category(n_category);
		nvo.setN_content(n_content);
		// mapper문에서 where조건으로 글번호가 들어와야 한다. 이것도 vo객체에 담아야 했음.
		int n_no = Integer.parseInt(request.getParameter("n_no"));
		System.out.println("글번호는 제대로 날아온 거니? " + n_no);
		// 마지막으로 글 번호까지 담는다.
		nvo.setN_no(n_no);

		int n = noticeDao.noticeUpdate(nvo);
		if (n != 0) {
			System.out.println("업데이트 성공");
		} else {
			System.out.println("업데이트 실패");
		}

		return "redirect:adminNoticeList.do";
	}

	// 공지사항 수정폼. 첨부파일 변경. 기존 파일 삭제
	@ResponseBody
	@RequestMapping("/ajaxNoticeFileDelete.do")
	public String ajaxNoticeFileDelete(Model model, HttpServletRequest request, NoticeVO nvo,
			@RequestParam("n_no") int n_no) {

		System.out.println("request로도 넘어왔나? " + request.getParameter("n_no"));
		System.out.println("글번호 값 넘어왔니?" + n_no);
		nvo.setN_no(n_no);

		int n = noticeDao.ajaxNoticeFileDelete(nvo);
		String message = null;
		if (n != 0) {
			System.out.println("삭제 성공");
			message = "YES";
		} else {
			System.out.println("삭제 실패");
			message = "NO";
		}

		return message;
	}

	// 공지사항 개별 삭제 by ajax
	@ResponseBody
	@RequestMapping("/noticeDelete.do")
	public String noticeDelete(Model model, HttpServletRequest request, NoticeVO nvo, @RequestParam("n_no") int n_no) {

		System.out.println("삭제할 글 번호 왔니? : " + n_no);
		nvo.setN_no(n_no);
		String message = null;
		int n = noticeDao.noticeDelete(nvo);
		if (n != 0) {
			System.out.println("게시글 삭제 성공 (controller) ");
			message = "YES";
		}
		return message;
	}

	// 공지사항 개별 고정 처리
	@ResponseBody
	@RequestMapping("/ajaxNoticeFixed.do")
	public String ajaxNoticeFixed(Model model, HttpServletRequest request, NoticeVO nvo, @RequestParam("n_no") int n_no,
			@RequestParam("n_fixed") String n_fixed) {

		System.out.println("글번호: " + n_no + "수정할 고정 값: " + n_fixed);

		nvo.setN_fixed(n_fixed);
		nvo.setN_no(n_no);
		int n = noticeDao.ajaxNoticeFixed(nvo);
		String message = null;
		if (n != 0) {
			System.out.println("수정 성공");
			message = "YES";
		}

		return message;
	}

	// 공지사항 선택 삭제
	@ResponseBody
	@RequestMapping("/ajaxNoticeSelectDelete.do")
	public String ajaxNoticeSelectDelete(Model model, HttpServletRequest request, NoticeVO nvo,
			@RequestParam("checkedArray[]") List<String> checkedArray) {

		String message = null;
		int n_no;

		for (String i : checkedArray) {
			n_no = Integer.parseInt(i);
			nvo.setN_no(n_no);
			noticeDao.noticeDelete(nvo);
			message = "YES";
		}
		return message;
	}

}
