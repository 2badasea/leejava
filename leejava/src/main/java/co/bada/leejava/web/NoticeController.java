package co.bada.leejava.web;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import co.bada.leejava.notice.NoticeService;

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
	@RequestMapping(value = "/uploadSummernoteImageFile.do", produces = "application/json; charset=utf8")
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  {
		JsonObject jsonObject = new JsonObject();
		
        /*
		 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
		 */
		
		// 내부경로로 저장하는 경우. => 난 bean에 등록한 외부경로를 사용
//		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
//		String fileRoot = contextRoot+"resources/fileupload/";
		String fileRoot = summernoteImageUploadPath;
		
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
//			jsonObject.addProperty("url", "/summernote/resources/fileupload/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("url", summernoteImageUploadPath +savedFileName); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	// 실패했을 경우 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String responseData = jsonObject.toString();
		System.out.println("responseData 확인: " + responseData);
		return responseData;
	}
	
	
	
}
