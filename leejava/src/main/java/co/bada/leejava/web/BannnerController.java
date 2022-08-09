package co.bada.leejava.web;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import co.bada.leejava.banner.BannerService;
import co.bada.leejava.banner.BannerVO;

@Controller
public class BannnerController {
	@Autowired
	BannerService bannerDao;
	@Resource(name = "bannerimgUploadPath")
	private String bannerimgUploadPath;
	
	private static final Logger logger = LoggerFactory.getLogger(BannnerController.class);
	
	// 배너신청하는 페이지로 이동 => 로그인을 해야 만 할 수 있다고 알리기
	@RequestMapping("/bannerApply.do")
	public String bannerApply(Model model) {
		
		return "home/member/bannerApply";
	}
	@ResponseBody
	@PostMapping(value = "ajaxBannerApply.do", produces = "application/test; charset=utf-8")
	public ResponseEntity<String> ajaxBannerApply(HttpServletRequest request,
								@RequestParam("banoriginfile") MultipartFile file, 
								@RequestParam String m_email,
								@RequestParam String banapplytitle,
								@RequestParam String banapplycontent,
								@RequestParam String banapplytype,
								BannerVO bvo) throws Exception {
		
		logger.info("신청자 이메일 확인: " + m_email);
		logger.info("첨부한 배너 파일 확인" + file);
		logger.info("배넛 신청 제목 확인: " + banapplytitle);
		logger.info("배너 신청 내용 확인: " + banapplycontent);
		logger.info("배너 신청 유형 확인: " + banapplytype);
		
		// 첨부된 이미지 파일의 원본명
		String banfile = file.getOriginalFilename();
		String banpfile = null;
		if( banfile != "") {
			banpfile = uploadFile(banfile, file.getBytes(), request);
		}
		logger.info("가공된 물리파일명 확인: " + banpfile);
		bvo.setM_email(m_email);
		bvo.setBanfile(banfile);
		bvo.setBanpfile(banpfile);
		bvo.setBanapplytitle(banapplytitle);
		bvo.setBanapplycontent(banapplycontent);
		
		int n = bannerDao.bannerInsert(bvo);
		String message = null;
		if(n != 0) {
			// 성공
			message = "배너 신청이 완료되었습니다.";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		} else {
			message = "배너 신청이 정상적으로 이루어지지 않았습니다.";
			return new ResponseEntity<String>(message, HttpStatus.NOT_IMPLEMENTED);
		}
	}
	
	public String uploadFile(String originalName, byte[] fileData, HttpServletRequest request) throws Exception{
		UUID uuid = UUID.randomUUID();
		String savePath = bannerimgUploadPath;
		String savedName = uuid.toString() + "_" + originalName;
		File target = new File(savePath, savedName);
		FileCopyUtils.copy(fileData, target);
		return savedName;
	}
	
	// 배너이미지 페이지 가자마자 신청내역 있으면 출력시키기
	@ResponseBody
	@GetMapping(value = "bannerimageSelect.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<BannerVO>> bannerimageSelect(@RequestParam String m_email, BannerVO bvo){
		
		List<BannerVO> list = new ArrayList<BannerVO>();
		bvo.setM_email(m_email);
		list = bannerDao.bannerimageSelect(bvo);
		if( list.size() != 0) {
			return new ResponseEntity<List<BannerVO>>(list, HttpStatus.OK);
		} else { // list변수에 담겨있는 데이터의사이즈 크기 => 0인 경우, null을 리턴.
			list = null;
			return new ResponseEntity<List<BannerVO>>(list, HttpStatus.NOT_IMPLEMENTED);
		}
	}
	
	// 관리자뷰의 사이드바에서 배너관리 페이지로 이동
	@RequestMapping(value ="adminBannerManage.do")
	public String adminBannerManage(Model model, BannerVO bvo) {
		
		List<BannerVO> list = new ArrayList<>();
		// 딱히 파라미터를 넘길 필요는 없을 것 같다. 단순히 모든 데이터를 model에 담아서 뿌려주면 될 듯. 
//		list = bannerDao.bannerSelectList();
		
		// 리스트타입의 컬렉션을 선언 한 다음에 배너이미지 관련 데이터를 모두 model에 담아서 보낸다.
		// 페이징 처리는 아직 보류.
		
		return "home/admin/adminBannerManage";
	}
	
}
