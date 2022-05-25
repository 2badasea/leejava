package co.bada.leejava.web;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
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

import co.bada.leejava.notice.NoticeService;
import co.bada.leejava.notice.NoticeVO;

@Controller
public class NoticeController {
	@Autowired
	NoticeService noticeDao;
	
	// summernote image upload 경로 bean 등록 root-context.xml에 등록했음.
    @Resource(name = "summernoteImageUploadPath")
    private String summernoteImageUploadPath;  // 이 이름으로 업로드 경로 사용
    // 공지사항 첨부파일 업로드 경로 bean 등록 root-context.xml에 설정함.
    @Resource(name = "noticeUploadPath")
    private String noticeUploadPath; 
	
	// 관리자 공지사항 페이지로 이동
	@RequestMapping("/adminNoticeList.do")
	public String adminNoticeList(Model model, HttpServletRequest request,HttpSession session) { 
		
		// 페이지 이동했을 때 공지사항 리스트가 출력되어야 함. 
		model.addAttribute("notices", noticeDao.noticeSelectList());
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
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  {
		JsonObject jsonObject = new JsonObject();
		
        /*
		 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
		 */
		
		// 내부경로로 저장하는 경우. => 난 bean에 등록한 외부경로를 사용
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String fileRoot = contextRoot+"resources/summernoteimage/";
//		String fileRoot = summernoteImageUploadPath;  외부이미지 경로, 일단 다음에 도전
		
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;	// 물리적으로 저장될 이미지 파일명
		
		// file 객체 생성. 설정한 경로와 파일이름으로 파일을 생성해줄 객체.
		File targetFile = new File(fileRoot + savedFileName);	
		try {
			// 스트림 생성. 내가 summernote이미지 업로드한 것을 읽어줄 스트림
			InputStream fileStream = multipartFile.getInputStream();
			// 실제 경로에 파일 저장이 시작되는 부분
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	
			// 주석 친 부분은 내부경로로 사용했을 때의 경로명.
			jsonObject.addProperty("url", "/resources/summernoteimage/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
//			jsonObject.addProperty("url", summernoteImageUploadPath + savedFileName); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("responseCode", "success");
			System.out.println("targetFile의 정체: " + targetFile);	
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	// 실패했을 경우 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String responseData = jsonObject.toString();
		System.out.println("responseData 확인: " + responseData);
		return responseData;
	}
	
	// 첨부파일 등록하기
	@RequestMapping("/noticeRegister.do")
	public String noticeRegister(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, 
			NoticeVO nvo, @RequestParam("filename") MultipartFile file) throws Exception {
		// vo객체에 실어야 하는 것: 작성자, 카테고리, 제목, 내용, 첨부파일명, 물리파일명, 조회수, 고정여부 
		System.out.println("제목 들어왔니? " + request.getParameter("n_title"));
		System.out.println("카테고리 들어왔니? " + request.getParameter("n_category"));
		System.out.println("내용 들어왔니? : " + request.getParameter("n_content"));
		System.out.println("@requestparam 첨부파일 이름이랑 같니? " + file);
		
		// 첨부파일 업로드 작업
		String n_file = file.getOriginalFilename(); // 원본파일명
		System.out.println("첨부파일 이름 확인: " + n_file);
		String n_pfile = null; // 중복 가공된 파일. 실제 물리파일.
		if( n_file != "") {    // 첨부한 게 없다면 pfilename컬럼에 값이 안 들어가도록.
			n_pfile = uploadFile(n_file, file.getBytes(), request);  // 첨부파일명 랜덤생성하는 메소드. 밑에 정의되어 있음.
		} 
		System.out.println("물리파일명 확인: " + n_pfile);
		
		String n_writer = (String)session.getAttribute("session_nickname"); 
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
		if( n!=0) {
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
		String SAVE_PATH = noticeUploadPath; // 로컬경로(C:\leejava\noticeuploadfiles\ ) 
		// 랜덤생성 + 파일이름 저장
		String savedName = uuid.toString() + "_" + originalName; // 가공된 파일이름.
		File target = new File(SAVE_PATH, savedName);   // 가공된 파일이름을 servlet-context.xml에 등록한 bean의 경로에 저장.
		// 임시디렉토리에 저장된 업로드된 파일을 지정된 디렉토리로 복사. 실제 프로젝트 시연할 때는 uploadPath 의 경로를 변경해야 함(
		// servlet-context.xml)
		FileCopyUtils.copy(fileData, target);
		return savedName;
	}
	
	// 첨부파일 다운로드 로직 구현하기 
	
	
	// 관리자 공지사항 조회
	@RequestMapping("/adminNoticeRead.do")
	public String adminNoticeRead(Model model, @RequestParam("n_no") int n_no, 
				NoticeVO nvo) {
		
		System.out.println("글번호 값 들어왔니? : " + n_no);
		nvo.setN_no(n_no);
		nvo = noticeDao.noticeSelect(nvo);
		if( nvo != null) {
			System.out.println("글조회 성공~");
		} else {
			System.out.println("글조회 실패;;");
			return "redirect:adminNoticeList.do";
		}
		model.addAttribute("notice", nvo);
		return "home/admin/noticeRead";
	}
	
	
	
	
	
}
