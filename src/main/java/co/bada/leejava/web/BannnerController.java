package co.bada.leejava.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sound.sampled.AudioFormat.Encoding;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import co.bada.leejava.Search;
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
		return new ResponseEntity<List<BannerVO>>(list, HttpStatus.OK);
	}
	
	// 관리자뷰의 사이드바에서 배너관리 페이지로 이동 
	@RequestMapping(value ="adminBannerManage.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String adminBannerManage(Model model, BannerVO bvo, Search svo, 
									@RequestParam(required = false, defaultValue = "1") int page,
									@RequestParam(required = false, defaultValue = "1") int range) {
		
		model.addAttribute("search", svo);
		int listCnt = bannerDao.getListCnt();
		svo.pageinfo(page, range, listCnt);
		List<BannerVO> list = bannerDao.bannerApplyList(svo);
		model.addAttribute("pagination", svo);
		model.addAttribute("banner", list);
		
		return "home/admin/adminBannerManage";
	}
	
	// 사용자뷰 배너 신청 내역 조회
	@ResponseBody
	@GetMapping(value = "bannerApplySelect.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<BannerVO> bannerApplySelect(@RequestParam int banno, BannerVO bvo){
		
		System.out.println("bvo값 조회: " + banno);
		bvo.setBanno(banno);
		bvo = bannerDao.bannerApplySelect(bvo);
		System.out.println("조회한 bvo값 조회: " + bvo);
		return new ResponseEntity<BannerVO> (bvo, HttpStatus.OK);
	}
	
	// 첨부파일 이미지 다운로드 
	@RequestMapping(value = "bannerDownload.do")
	public void bannerDownload(HttpServletRequest request, HttpServletResponse response,
				@RequestParam String filename, @RequestParam String pfilename  ) throws Exception{
		logger.info("원본파일명 확인: " + filename);
		logger.info("물리파일명 확인: " + pfilename);
		
		String savePath = bannerimgUploadPath;
		String realDownloadName = "";
		String realPfilePath = savePath + pfilename; 
		logger.info("업로드 파일의 경로: " + realPfilePath);
		try {
			String browser = request.getHeader("User-Agent");
			// 파일 인코딩 작업 시작
			if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")) {
				realDownloadName = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
			} else {
				realDownloadName = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
			}
		} catch(UnsupportedEncodingException e) {
			logger.info("========================== UnsupportedEncodingException");
		}
		logger.info("realDownloadName 값: " + realDownloadName);
		File file = new File(realPfilePath);
		if(!file.exists()) {
			logger.info("=============물리파일이 해당 경로에 존재하지 않음");
		}
		logger.info("물리파일이 해당 경로에 존재");
		response.setContentType("application/octer-stream");
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Content-Disposition", "attachmeent; filename=\"" + realDownloadName + "\""); 
		
		try {
			// 다운로드를 요청한 클라이언트에게 연결하기 위한 출력 스트림 생성
			OutputStream os = response.getOutputStream();
			// 실제 서버(로컬)에 저장되어 있는 업로드파일을 가져올 입력스트림 생성
			FileInputStream fis = new FileInputStream(realPfilePath); 
			int ncount = 0;
			byte[] bytes = new byte[512];
			
			while((ncount = fis.read(bytes)) != -1){
				os.write(bytes, 0, ncount);
			}
			fis.close();
			os.close();
		} catch(Exception e) {
			logger.info("===============FileNotFoundException : " + e);
		}
	} 
	
	@ResponseBody
	@PutMapping(value = "bannerUpdate.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> bannerUpdate(@RequestBody BannerVO bvo){
		// 스크립트 단에서 전달받은 데이터의 타입이 json이기에 @RequestBody 어노테이션을 이용하여 데이터를 받았음.
		System.out.println("넘어온 bvo값 확인: " + bvo);
		
		int n = bannerDao.bannerUpdate(bvo);
		String message = null;
		if(n != 0) {
			message = "YES";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		}else {
			message = "NO";
			return new ResponseEntity<String>(message, HttpStatus.NOT_IMPLEMENTED);
		}
	}
	
	// 배너신청 게시글 수정 by(사용자) 
	@ResponseBody
	@PutMapping(value = "newBannerUpdate.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> newBannerUpdate(BannerVO bvo,
					HttpServletRequest request, HttpServletResponse response,
					@RequestParam(required = false, value = "banno") int banno,
					@RequestParam(required = false, value = "newBanfile") MultipartFile newFile,
					@RequestParam(required = false, value = "existingPfilename") String existingPfilename,
					@RequestParam(required = false, value = "banapplytype") String banapplytype,
					@RequestParam(required = false, value = "banapplytitle") String banapplytitle,
					@RequestParam(required = false, value = "banapplycontent") String banapplycontent) throws Exception{
		
		bvo.setBanno(banno);
		bvo.setBanapplytype(banapplytype);
		bvo.setBanapplytitle(banapplytitle);
		bvo.setBanapplycontent(banapplycontent);
		// existingPfilename => 기존의 파일을 삭제하고 삭제가 됐다면~ 새로운 파일을 업로드 시키기
		if( existingPfilename != null) {
			File file = null;
			try {
				file = new File(bannerimgUploadPath + URLDecoder.decode(existingPfilename, "UTF-8"));
				System.out.println("URLDecoder.decoe() 결괏값: " + file);
				Boolean b =  file.delete();
				if(b) {
					System.out.println("기존의 배너 이미지 파일 삭제 성공");
					// 새로 첨부한 파일을 가지고 다시 작업.
					String banfile = newFile.getOriginalFilename();
					String banpfile = null;
					if( banfile != "") {
						 banpfile = uploadFile(banfile, newFile.getBytes(), request);
					}
					System.out.println("새롭게 가공되어 생성된 물리파읾명: " + banpfile);
					bvo.setBanfile(banfile);
					bvo.setBanpfile(banpfile);
					
				}
				
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		//  글번호, 타입, 제목, 내용, 새로원이미지파일원본명, 새로운이미지파일물리명  bvo객체에 담고 업데이트 시작. 
		String updateResult = null;
		System.out.println("항목이 담긴 데이터 bvo객체 확인: " + bvo);
		int n = bannerDao.bannerUpdate(bvo);
		if(n != 0) {
			System.out.println("업데이트 성공");
			updateResult = "YES";
			return new ResponseEntity<String>(updateResult, HttpStatus.OK);
		} else {
			System.out.println("업데이트 실패");
			updateResult = "NO";
			return new ResponseEntity<String>(updateResult, HttpStatus.NOT_MODIFIED);
		}
	}
	
	// 배너 신청 취소
	@ResponseBody
	@DeleteMapping(value = "ajaxBannerApply/{no}/{pfile}")
	public ResponseEntity<String> ajaxBannerApply(BannerVO bvo
												, @PathVariable(value="pfile") String banpfile
												, @PathVariable(value="no") int banno
												) throws Exception{
		
		logger.info("========================= banno 확인: " + banno);
		logger.info("========================물리파일 이 nu?? " + ( banpfile == null));
		if(banpfile !=null) {
			logger.info("==================== rmBanpfile 존재: " + banpfile);
			File file = null;
			try {
				file = new File(bannerimgUploadPath + URLDecoder.decode(banpfile, "UTF-8"));
				logger.info("=================== decoder 결과 확인: " + file);
				// boolean값으로 판단 후, db삭제 시키기
				boolean b = file.delete();
				if(b) {
					bvo.setBanno(banno);
					int n = bannerDao.ajaxBannerApplyDel(bvo);
					if(n == 1) {
						return new ResponseEntity<String>("success", HttpStatus.OK); 
					}else {
						return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
					}
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
		} return new ResponseEntity<String>("error", HttpStatus.BAD_REQUEST);
	}
	
	// 배너이미지 신청 거절사유 작성하는 폼 팝업 호출
	@RequestMapping(value = "bannerimageDeclinePop.do", method = RequestMethod.GET)
	public String bannerimageDeclinePop(Model model, HttpServletRequest request, 
				@RequestParam("fromUser") String fromUser,
				@RequestParam("toUser") String toUser) {
		
		System.out.println("전달받은 파라미터값: " + fromUser + ", " + toUser);
		model.addAttribute("toUser", toUser);
		model.addAttribute("fromUser", fromUser);
		return "home/popup/bannerimageDeclinePop";
	}
	
	// 배너관리 페이지. 게제중(banpoststatus 값이 'PUBLICING'인 리스트 출력) 
	@ResponseBody
	@GetMapping(value = "publicingBannerList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<BannerVO>> publicingBannerList(BannerVO bvo, 
				@RequestParam String banpoststatus){
		
		List<BannerVO> list = new ArrayList<>();
		System.out.println("파라미터 값 조회: " + banpoststatus);
		bvo.setBanpoststatus(banpoststatus);
		list = bannerDao.bannerimageSelect(bvo);
		return new ResponseEntity<List<BannerVO>> (list, HttpStatus.OK);
		// 보통의 경우 메소드이름과 똑같은  쿼리문 id값을 찾지만, 기존의 list를 출력시키는 "bannerimageSelect" 를 활용한다 <trim>을 줘서
	}
	
	// 배너관리 페이지 => 배너 이미지 조회
	@GetMapping("bannerDisplay.do")
	public ResponseEntity<byte[]> bannerDisplay(String banpfileName){
		System.out.println("banpfilename 값 확인: " + banpfileName);
		File file = new File(bannerimgUploadPath + banpfileName);
		System.out.println("File 객체의 값 확인: " + file);
		ResponseEntity<byte[]> resultData = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-type", Files.probeContentType(file.toPath()));
			System.out.println("header값 조회: " + header);
			resultData = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("반환할 resultData 확인: " +  resultData);
		return resultData;
	}
	
}
