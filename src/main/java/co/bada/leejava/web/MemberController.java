package co.bada.leejava.web;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import co.bada.leejava.AttachImageVO;
import co.bada.leejava.SHA256Util;
import co.bada.leejava.Search;
import co.bada.leejava.member.MemberService;
import co.bada.leejava.member.MemberVO;
import co.bada.leejava.notice.NoticeService;
import co.bada.leejava.notice.NoticeVO;
import co.bada.leejava.totolist.TodoService;
import net.coobird.thumbnailator.Thumbnails;
import oracle.jdbc.proxy.annotation.Post;

@Controller
public class MemberController {
	@Autowired
	MemberService memberDao;
	@Autowired
	NoticeService noticeDao;
	@Autowired
	TodoService todoDao;
	@Resource(name="profileUploadPath")
	private String profileUploadPath;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	// 관리자화면  회원리스트 정보 페이지 이동
	@RequestMapping("/adminMemberList.do")
	public String adminMemberList(Model model,
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range, 
			@RequestParam(required = false, defaultValue = "ALL") String m_joinpath,
			@RequestParam(required = false) String m_email,
			@RequestParam(required = false) String m_nickname,
			@RequestParam(required = false) String frontCal,
			@RequestParam(required = false) String backCal,
			Search svo) {
		
		model.addAttribute("search", svo);
		svo.setM_joinpath(m_joinpath);
		svo.setM_email(m_email);
		svo.setM_nickname(m_nickname);
		svo.setFrontCal(frontCal);
		svo.setBackCal(backCal);
		int listCnt = memberDao.getMemberListCnt(svo);
		System.out.println("listCnt값 확인해보기: " + listCnt);
		
		svo.pageinfo(page, range, listCnt);
		List<MemberVO> list = memberDao.memberSearchSelect(svo);
		
		model.addAttribute("pagination", svo);
		model.addAttribute("member", list);
		
		// v_memberlist(회원 정보 일부) 정보 가지고 페이지로 이동  ( view생성하는 거 연습삼아서 최소한의 정보만 호출 ) 
//		model.addAttribute("member", memberDao.v_memberSelectList());
		return "home/admin/adminMemberList";
	}
	
	// 유저 개인정보 조회하는 곳으로 이동 => 프로필 사진이랑 모두 추가해야 함. 
	@RequestMapping("/memberMyInfo.do")
	public String memberMyInfo(Model model, HttpServletRequest request,
			MemberVO mvo, HttpSession session) { 
		
		// 접속한 회원의 개인정보를 뿌려줘야 한다. 
		// 현재 Session_user의 값이 이메일 이므로 이걸 가져와야 함. 
		String m_email = (String) session.getAttribute("session_user");
		mvo.setM_email(m_email);
		mvo = memberDao.memberMyInfoList(mvo);
		model.addAttribute("member", mvo);
		return "home/member/memberMyInfo";
	}
	   
	// 서버에서 뷰로 반환되는 정보가 한글일 경우 데이터가 깨질 수 있어서 produces속성을 추가하여 뷰로 전해줄 데이터를 utf8로 인코딩 해주는 작업을 한다. 
	@PostMapping(value = "/ajaxProfileUpdate.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<AttachImageVO>> ajaxProfileUpdate(MultipartFile[] uploadFile) {
			// MultipartFile[] => 여러 파일을 받을 때 사용. 이렇게 해놓고 한 개만 업로드 해도 상관없다. 
			// 그릐고 for문으로 돌리면 된다. 나도 [] 형태로 수정.  
		
		// 나중에 log4j 설정하면 sysout은 사용하지 말 것. 
		logger.info("===============ajaxProfileUpdate.do POST......");
		
		/* 이미지 파일 체크 */ 
		for(MultipartFile multipartFile : uploadFile) {
			File checkfile = new File(multipartFile.getOriginalFilename());
			// MIME TYPE을 저장할 String타입의 "type" 변수를 선언하고  null로 초기화
			String type = null;
			// Files의 probeContenttype()메서드를 호출하여 반환하는 MIME TYPE 데이터를 type변수에 대입
				// probeContentType은 파라미터로 전달받은 파일의 MIME TYPE을 문자열로 반환해주는 메서드.
				// 파라미터로는 Path()객체를 전달받아야 한다. => MIME TYPE 호가인 대상이자 File 객체인
				// checkfile을 Path 객체로 만들어 주어야 하고, 이를 위해 File클래스의 toPath()메서드를 사용
			try {
				type = Files.probeContentType(checkfile.toPath());
				logger.info("===============MIME TYPE(Files.probeContentType()의 결과) : " + type);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// 반환되는 MIME TYPE에 대한 정보가 image로 시작하는지 판단한다. 
			if( !type.startsWith("image")) {
				// 전달 해줄 파일의 정보는 없지만, 반환타입이 ResponseEntity<List<AttachImageVO>> 이기에 
					// ResponseEntity 객체에 첨부해줄 값이 null인 List<AttachImageVO> 타입의 참조 변수를 선언
				List<AttachImageVO> list = null; 
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
			}
			
		} // view에서 넘어오는 파일 객체들에 대해 반복문을 통하여 타입체크 끝
		
		// 'yyyy-MM-dd' 형태로 날짜 정보를 얻기 위함. 날짜별로 디렉토리를 구성하기 위함. 
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// 날짜 정보를 얻을 수 있는 객체 생성 => java.util.Date 패키지에 속한다. 
		Date date = new Date();  
		// sdf가 가지고 있는 format()메서드를 사용 => 인스턴스를 생성할 때 어떤 형식으로 날짜 정보를 제공할지 설정해놓음
		String str = sdf.format(date); 
		logger.info("===============경로구분자로 가공되기 전 str의 값: " + str);
		// File클래스에서 실행되는 운영체제 별로 사용되는 구분자를 반환하는 정적(static) 변수인
			// separator가 존재. => '-' 문자열을 String클래스의 replace() 메서드를 이용하여
			// File.separator로 변경해준다.  ( "/" 경로구분자를 의미 ).
		String profilePath = str.replace("-", File.separator);
		logger.info("==============='-'을 경로구분자로 변환 후 str의 값: " + profilePath);
		// File타입의 uploadPath 변수를 통하여 우리가 원하는 경로에 날짜별로 디렉토리를 생성하는 객체를 생성한다.
		File uploadPath = new File(profileUploadPath,profilePath);
		// 그럼 폴더를 생성한다. 폴더를 생성하는 메서드로 mkdir()과 mkdirs() 메서드가 존재하는데,
			// 후자의 경우 여러 개의 폴더를 생성한다. => 전자의 경우 선행하는 디렉토리가 없으면 만들어지지 않는다.  
			// 요청이 있을 때마다 새로운 폴더를 생성하는 것을 방지하기 위함 => File객체에서 제공하는 exist()메서드. 
		if(uploadPath.exists() == false) {
			// 요청이 있는 날짜 기준으로 폴더가 생성되었다. 
				// File.separator() 메서드를 통해 경로구분자(\) 기준으로 디렉토리 생성됨.
				// mkdir() / mkdirs()메서드 차이 => notion에 정리
			uploadPath.mkdirs();
		}
		
		// 이미지 정보 담는 객체. 위에 타입체크용 for문 내에서도 한번 선언했음.
			// 나중에 return타입으로 ResponseEntity로, 이미지 정보가 담긴 list와, HttpStatus 상태값을 담아서 보낸다.
		List<AttachImageVO> list = new ArrayList<>();
		
		// 실제 파일을 폴더에 저장하기 위해서 transperTo() 메서드를 사용한다. 
		// 사용방법은 전달받은 파일인 MultipartFile 객체에 저장하고자 하는 위치를 지정한
		// File객체를 파라미터로 하여 transperTo() 메서드를 호출하면 된다.  
		// MultipartFile.transferTo(File detination); 대충 이런 형태 
		
		// 본격적으로 업로드한 파일에 대해 다루기 시작. 앞서 있었던 향상된 for문의 경우는 해당 이미지 파일의 유효성 검사용.
		// 향상된 for문  첨부파는 이미지가 여러 개일 경우 => for문으 동시에 업로드 처리한다.
		for(MultipartFile multipartFile : uploadFile) {
			
			// 이미지 정보 객체 
			AttachImageVO avo = new AttachImageVO(); 
			// 파일 이름
			String uploadFileName = multipartFile.getOriginalFilename();
			// setter 메서드를 사용하여 각 정보를 avo 객체에 저장
			avo.setFileName(uploadFileName);  // 파일 원본명
			logger.info("===============avo객체에 담은 uploadFilename: " + uploadFileName);
			avo.setUploadPath(profilePath); // 날짜별 디렉토리까지 구분되어 있는 경로
			logger.info("===============avo객체에 담은 profilePath: " + profilePath);
			// UUID 적용이 된 파일이름으로 변경
			String uuid = UUID.randomUUID().toString();
			// avo객채ㅔ에 uuid도 저장
			avo.setUuid(uuid);
			logger.info("===============avgo객체에 담은 uuid명 : " + uuid);
			uploadFileName = uuid + "_" + uploadFileName; // uuid+"_"+원본파일 => 물리파일명 생성
			// 첫 번째 파라미터는 경로(c:\\leejava\\prifile\\2022\\08\\08)
				// 두 번째 파라미터 "uploadFileName"은  uuid를 포함한 물리적으로 저장된 파일 이름.
			File saveFile = new File(uploadPath, uploadFileName);
			// 실제 파일 저장이 일어나는 곳.
			try {
				// transperTo()의 경우 IOException, IllegalStateException를 일으킬 수 있어 try-catch문을 사용! 
					// 우선 물리파일명 하나를 생성하고, 밑에서 썸네일 이미지도 따로 가공하여 생성한다. 
				multipartFile.transferTo(saveFile);
				
				/* 썸네일 이미지 생성(ImageIO  => java 자체적으로 제공하는 클래스) */
				// ImageIO를 통해 썸네일 이미지를 생성하기 위해 원본 파일과 썸네일 파일 객체가 필요
					// 썸네일 파일 객체는 원본 파일과 구분하기 위해 앞에 's_'를 붙이고 생성함.
//				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
//				logger.info("===============파일 객체 조회: " + thumbnailFile);
				// 원본 이미지 파일을 ImageIO의 read() 메서드를 호출하여 BufferedImage 타입으로
					// 변경해준 뒤 BufferedImage 타입의 참조 변수를 선언하여 해당 변수에 대입해준다. 
					// (bo_image 변수는 Buffered original image라는 의미로 작성=> 원하는 변수명 사용해도 된다) 
					// 조작하기 전 대기실에 둔다고 생각하면 된다. BufferedImage타입의 경우.
//				BufferedImage bo_image = ImageIO.read(saveFile); 
//				logger.info("===============bo_image의 정체: " + bo_image);
				
				// 높이와 너비에 대해 비율을 하드코딩 해서 맞춰줄 경우, 특정 이미지의 경우 보기가 불편하게 변경될 수 있음.
					// 그래서 전체적으로 동일한 비율로 썸네일 이미지를 생성하기 위해 다음과 같이 코드를 작성한다. 
					// ratio가 double타입이기 때문에 나눈 값이 double타입이된다. 파라미터로 부여할 형은 int형이기 때문에 형변환
				
				/* 비율 */
//				double ratio = 3; 
				/* 높이 널이 */ 
//				int width = (int) (bo_image.getWidth() / ratio);
//				int height = (int) (bo_image.getHeight() / ratio); 
				
				// BufferedImage 생성자 사용 => 썸네일 이미지를 담을 BuffereImage 객체를 생성해주고
					// 참조 변수에 대입한다. => 일종의 크기를 지정하여 흰색 도화지를 만드는 과정이다. 
					// 사용한 BufferedImage 생성자는 매개변수로  넓이, 높이,'생성될 이미지 타입'을 작성하면 된다. 
//				BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
//				logger.info("===============bt_image 조회: " + bt_image);
				// 썸네일 BufferedImage 객체(bt_image)에서 createGraphics() 메서드 호출을 통해
					// Graphic2D 객체를 생성 해준 후 Graphic2D 타입의 참조 변수에 대입한다.
					// ( 앞서 만든 도화지에 그림을 그릴 수 있도록 하는 과정 ) 
					// 썸네일 BufferedImage 객체에 그림을 그리기 위해 Graphic2D 객체를 생성한다. 
					// Graphic2D 메서드를 통해 조작을 하게 되면 그 결과가 썸네일 BufferedImage 객체에 적용이 된다. 
//				Graphics2D graphic = bt_image.createGraphics(); 
//				logger.info("===============graphic 이름 확인: " + graphic);
				// drawImage 메서드를 호출하면 원본 이미지를 썸네일 BufferedImage에 지정한 크기로 변경하여
					// 왼쪽 상단 "0,0" 좌표부터 그려준다. (마찬가지로 도화지에 이미지를 그리는 과정이라고 생각하면 된다) .
//				graphic.drawImage(bo_image, 0, 0, width, height, null); 
				// 첫 번째 인자는 그려놓고자 하는 이미지
					// 2, 3 번째 인자는 그림을 어느 좌표부터 그릴 것인지에 대한 x값과 y값이다. 
					// 4, 5 번째 인자 값은 첫 번째 인자로 작성한 이미지의 '넓이'와 '높이' 
					// 지정한 '넓이'와 '높이'로 이미지 크기가 확대 혹은 축소되고, 크기가 변경된 이미지가 그려지게 된다. 
					// 여섯 번째 인자는 ImageObserver 객체. ImageObserver는 이미지의 정보를 전달받아서 
					// 이미지를 업데이트 시키는 역할을 한다. 일반적인 경우 null을 전달하면 된다. 
				//제작한 썸네일 이미지를 이제 파일로 만들어준다. ImageIO의 write() 메소드를 호출하여 파일로 저장. 
//				ImageIO.write(bt_image, "jpg", thumbnailFile);
				// 첫 번째 인자는 파일로 저장할 이미지. 우리가 만든 썸네일 이미지를 인자로 전달한다. 
					// 두 번째 인자는 어떠한 이미지 형식으로 저장할 것인지 String타입으로 작성한다. 
					// 세 번째 인자는 우리가 앞서 썸네일 이미지가 저장될 경로와 이름으로 생성된 File객체(thumbnailFile) 객체를 부여
				
				/* 방법 2 썸네일 라이브러리를 pom.xml에 추가하여 활용하는 방식*/
				// 두 방법 중 하나를 주석처리해서 사용. 
					// 썸네일 파일의 이름은 uuid+"_"+원본파일명 형태의 물리파일명에서 앞에 "s_"를 붙였다. 
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				// 마찬가지로 BufferImage 객체에 담아준다.
				BufferedImage bo_image = ImageIO.read(saveFile);
				
					// 비율
					double ratio = 3; 
					// 높이 넓이
					int width = (int) (bo_image.getWidth() / ratio);
					int height = (int) (bo_image.getHeight() / ratio); 
					
				// 위에 설정한대로 실질적으로 썸네일 파일이 생성되는 메서드
				Thumbnails.of(saveFile).size(width, height).toFile(thumbnailFile);
				// ImageIO를 통한 코드 작성보다 훨씬 간단히 생성 가능. thumbnailator 라이브러리는 이미지 생성에
				// 세부적 설정을 할 수 있는 메서드들을 제공. 
			} catch (Exception e) {
				logger.info("===============실패");
				e.printStackTrace();
			}
			// 이미지 정보가 저장된 AttachImageVO객체를 List의 요소로 추가해준다. 이때 추가된 정보는 썸네일 이미지 정보가 아닌 가공된 물리적 파일
				// 뷰로부터 전달받은 만큼 AttachImageVO 객체가 생성되어 각 정보를 저장한 후 해당 객체가
				// List의 요소로 추가되게 된다. 
			list.add(avo);
		}
		// ResponseEntity 참조 변수를 선언하고 생성자로 초기화한다. 
		ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list, HttpStatus.OK);
			return result;
		
//		// 향상된 for문으로 하는 방식
//		for(MultipartFile multipartFile : uploadFile) { 
//			logger.info("===============ajaxProfileUpdate.do POST......");
//			logger.info("===============파일 이름 : " + multipartFile.getOriginalFilename());
//			logger.info("===============파일 타입 : " + multipartFile.getContentType());
//			logger.info("===============파일 크기 : " + multipartFile.getSize());
//		}
//		// 기본 for문을 이용한 방식
//		for(int i = 0; i< uploadFile.length; i++) {
//			logger.info("===============ajaxProfileUpdate.do POST......");
//			logger.info("===============파일 이름 : " + uploadFile[i].getOriginalFilename());
//			logger.info("===============파일 타입 : " + uploadFile[i].getContentType());
//			logger.info("===============파일 크기 : " + uploadFile[i].getSize());
//		}
	} // url매핑( "ajaxProfileUpdate.do" ) 부분 끝  
	
	
	// 업로드 이미지 출력 구현 부분을 위한 메서드. by 김밤파
		// ResponseEntity 객체를 통해 body에 byte[]배열을 보내야 하기 때문에 다음과 같은 반환타입으로 작성.
		// 파라미터의 경우, '파일 경로' + '파일 이름'을 전달받아야 하기 때문에 String타입의 fileName변수를 파라미터로 부여
		// url 경로를 통해 변수와 변수 값을 부여할 수 있도록 GetMapping 어노테이션을 사용. 
	@GetMapping("/display.do")
	public ResponseEntity<byte[]> getImage( @RequestParam String fileName){
		logger.info("===============fileName의 값: " +fileName);
		File file = new File("c:\\leejava\\profile\\" + fileName); 
		
		ResponseEntity<byte[]> result = null;  
		try {
			// 대상 이미지 파일의 MIME TYPE을 얻기 위해 이전 포스팅에서 사용한 Files 클래스의 
				//proveContentType() 메서드를 사용한다. => 해당 메서드의 경우 IOExeption을 일으킬 가능성이 큰 메서드이기에
				// try catch문을 작성해준다. 
				// ResponseEntity에 Response의 header와 관련된 설정의 객체를 추가해주기 위해서 
				// HttpHeaders를 인스턴스화 한 후 참조 변수를 선언하여 대입한다.
			HttpHeaders header = new HttpHeaders();
			// header의 'Content-type' 속성 값에 이미지 파일 MIME TYPE을 추가해주기 위해서 HttpHeader클래스에 있는 add()메서드 사용2
				// add() 메서드의 첫 번째 파라미터에는 Response header의 '속성명', 두 번째 파라미터에는 해당 '속성명'에 부여할 값(value)를 삽입한다. 
			header.add("Content-type", Files.probeContentType(file.toPath()));
			// 대상 이미지 파일, header객체, 상태 코드를 인자 값으로 부여한 생성자를 통해 ResponseEntity 객체를 생성하여
				// 앞서 선언한 ReponseEntity 참조 변수에  대입한다. 
				// 첫 번째 파라미터는 출력시킬 대상 이미지 데이터 파일이라고 말했는데, FilesCopyUils.copyToByteArray(file)코드를 작성함.
				// FileCoyUtils 클래스는 파일과 stream 복사에 사용할 수 있는 메서드를 제공하는 클래스다. 
				// 해당 클래스 중에서 copyToByteArray() 메서드는 파라미터로 부여한는 File객체 즉, 대상 파일을 복사하여
				// Byte배열로 변환해주는 메서드다.   // 추가 설명은 메모 80번. 
			logger.info("=============================================header 값: " + header);  // [Content-type:"image/jpeg"] 형태로 반환된다.
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch(IOException e) {
			e.printStackTrace();
		}
		System.out.println("result 값 : " + result);
		return result; 
	}
	/* 이미지 파일 삭제*/
	// HTTP Body에 String 데이터를 추가하기 위해 타입 매개 변수로서 String을 부여한다. 
	@PostMapping("/deleteFile.do")
	public ResponseEntity<String> deleteFile(String fileName){
		// logger.info 구현하면 => 수정하기 
		// 이때 넘어온 fileName은 view에서 넘어온 fileCallPath 데이터(경로 + "s_"+  uuid + 파일이름)
		logger.info("===============view에서 넘어온 삭제할 deleteFile : " + fileName);
		logger.info("================ decocde 실행 직전============");
		File file = null;
		
		// 사용할 URLDecoder.decode(), File.delete() 두 개 모두 예외를 발생시킬 가능성이 큰 메서드. 
		try {
			// 메모 95. 삭제할 파일을 대상으로 하는 File클래스를 인스턴스화 하여 앞서 선언한 file참조변수가 참조하도로 한다. 
			file = new File("c:\\leejava\\profile\\" + URLDecoder.decode(fileName, "UTF-8"));
			logger.info("========================URLDecoder.decode(fileName, 'UTF-8') 결과 : " +file);
			// delete()메서드를 호출하여 해당 파일을 삭제하도록 코드를 작성한다.
			file.delete();
			// 메모 96. 물리파일도 삭제. 썸네일 이미지를 의미하는 's_'만 지워주면 물리파일명이고, 둘은 같은 경로에 있다. 
			String originFileName = file.getAbsolutePath().replace("s_", "");
			logger.info("===============originFileName : " + originFileName);
			// 본 파일을 대상으로 하는 File객체를 생성 후 이를 기존에 선언하고 사용하였던 file참조변수가 참조하도록 함.
				// 썸네일 이미지 삭제와 동일하게 원본 파일 이미지를 삭제하도록 delete()메서드를 호출
			file = new File(originFileName);
			file.delete();
		
		} catch(Exception e) {
			// 예외가 발생 => 파일 삭제 요청을 정상적으로 처리하지 못 함 => 실패를 알리는 상태 return
			e.printStackTrace();
			// 그러면 ajax콜백함수의 data값이 "fail" 값을 가진다. 
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
		} 
		// try문이 예외가 발생하지 않은 것은 정상적으로 삭제 작업을 수행했다는 것이기 때문에 성공 코드와 함께 성공과 
			// 관련된 문자열을 뷰로 전송해주도록 return문을 작성한다. 
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	/* 이미지 정보 반환 */ 
	// 반환해주는 데이터가 json형식이 되도록 지정해주기 위해 @GetMapper 어노테이션에 produces속성을 추가
	@GetMapping(value = "/getAttachList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<AttachImageVO>> getAttachList(String m_email){ 
		
		return new ResponseEntity<List<AttachImageVO>>(memberDao.getAttachList(m_email), HttpStatus.OK);
	}
	
	// 실제 프로필 이미지 DB등록 ajax  (다음엔 반환타입이 ResponseEntity인 메서드로 사용해볼 것.) 
	@ResponseBody
	@RequestMapping("/ajaxProfileImgUpdate.do")
	public String ajaxProfileImgUpdate(HttpServletRequest request, MemberVO mvo, AttachImageVO ivo) {
		// 전달받은 데이터 확인  m_email, uuid, uploadPath, fileName 
		logger.info("===============날라온 이메일: " + request.getParameter("m_email"));
		logger.info("===============날라온 uuid: " + request.getParameter("uuid"));
		logger.info("===============날라온 uploadPath: " + request.getParameter("uploadPath"));
		logger.info("===============날라온 fileName: " + request.getParameter("fileName"));
		
		String m_email = request.getParameter("m_email");
		String uuid = request.getParameter("uuid");
		String uploadPath = request.getParameter("uploadPath");
		// "\"를  "/"형태로 치환해서 DB로 들어가게 해보자.
		uploadPath = uploadPath.replace("\\", "/");
		logger.info("============== '\'를 '/'로 수정해서 DB에 넣을 uploadPath 정보: " + uploadPath);
		String fileName = request.getParameter("fileName");
		
		// 이제 DB에 insert. 그전에 select해서 이미 존재한다면 update문으로 정보를 변경한다. 
		// 조회하는 쿼리  profileImageCheck
		ivo.setM_email(m_email);
		ivo.setFileName(fileName);
		ivo.setUploadPath(uploadPath);
		ivo.setUuid(uuid);
		String result = null;
		boolean b = memberDao.profileImageCheck(ivo);
		if(b) {
			logger.info("===============기존 정보 없음");
			// insert 구문. 
			int m = memberDao.insertProfileImage(ivo);
			if( m == 1) {
				logger.info("===============프로필 이미지 insert 성공");
				result = "Y";
			} 
		} else {
			logger.info("===============기존 정보 있음");
			// update 구문
			int n = memberDao.updateProfileImage(ivo);
			if( n == 1) {
				logger.info("===============프로필 업데이트 성공");
				result = "Y";
			}
		}
		// 프로필 신규추가나 업데이트가 성공했으면 Y값을 가짐
		return result;
	}
	
	// 개인정보 프로필 이미지 DB값 리셋
	@ResponseBody
	@PostMapping(value = "profileImgReset.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> profileImgReset(@RequestBody AttachImageVO ivo){
		
		String message = null;
		int n = memberDao.updateProfileImage(ivo);
		if(n != 0) {
			message = "DB값이 초기화 되었습니다.";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		} else {
			message = "DB값 업데이트에 실패했습니다.";
			return new ResponseEntity<String>(message, HttpStatus.NOT_MODIFIED);
		}
	}
	 
	// 개인정보 페이지에서 닉네임 변경 신청 
		// view단의 ajax문에서 error가 지속적으로 난 원인 => ajax는 @ResponseBody 어노테이션 사용해야 함. 
		// 그리고 produces속성의 값으로 밑에처럼 명시한 이유는 => 서버에서 view로 응답할 때 한글의 경우 인식을 못 하기 때문이다.
	@ResponseBody
	@PostMapping(value = "/ajaxNicknameUpdate.do", produces = "application/text; charset=utf-8"  )
	public ResponseEntity<String> ajaxNicknameUpdate(Model model, HttpServletRequest request
			, MemberVO mvo
			,@RequestParam String m_nickname
			,@RequestParam String m_email ) {
		
		// mvo객체에 담아서 중복체크를 먼저 한 다음에 중복이 아닐 때 처리해준다. 
		mvo.setM_nickname(m_nickname);
		// 닉네임 중복체크 쿼리는 이미 존재	
		String message = null;
		boolean b = memberDao.memberNicknameCheck(mvo);
		if(b) { 
			logger.info("===============중복된 닉네임 없음");
			mvo.setM_email(m_email);
			int n = memberDao.ajaxNicknameUpdate(mvo);
			if(n !=0) {
				logger.info("===============닉네임 변경 성공");
				message = "YES";
				return new ResponseEntity<String>(message, HttpStatus.OK);
			} else {
				logger.info("===============닉네임 변경 실패");
				message ="NO"; 
				return new ResponseEntity<String>(message, HttpStatus.NOT_MODIFIED);
			}
		} else {
			logger.info("===============중복된 이메일 존재");
			message ="ALREADY";
			return new ResponseEntity<String>(message, HttpStatus.ALREADY_REPORTED);
		}
	}  
	// 사용자뷰 공지사항으로 이동 (페이징 처리 & 검색항목 구현) 
	@RequestMapping("/memberNoticeList.do")  
	public String memberNoticeList(Model model
				,@RequestParam(required = false, defaultValue = "1") int page
				,@RequestParam(required = false, defaultValue = "1") int range
				,@RequestParam(required = false, defaultValue = "all" ) String n_category
				,@RequestParam(required = false) String n_title
				,@RequestParam(required = false) String n_content
				,@RequestParam(required = false) String n_writer
				,Search svo)  throws Exception{
		
		// 해당 view에석 검색요소로 쓰일 변수들을 보낸다
		model.addAttribute("search", svo);
		svo.setN_category(n_category); 
		svo.setN_title(n_title);  
		svo.setN_content(n_content);
		svo.setN_writer(n_writer);
		int listCnt = noticeDao.getUserNoticeListCnt(svo);
		System.out.println("페이징 처리된 게시글의 갯수: " + listCnt );
		
		svo.pageinfo(page, range, listCnt);
		List<NoticeVO> list = noticeDao.userNoticeSearchSelect(svo);
		System.out.println("페이지에 전달해줄 list: " + list);
		
		// 페이징처리된 해당 페이지의 정보  
		model.addAttribute("pagination", svo);
		// 화면에 출력해줄 공지사항 리스트들
		model.addAttribute("notice", list);
		
		return "home/member/memberNoticeList";
	} 
	
	// 사용자뷰 공지사항 조회
	@RequestMapping(value = "memberNoticeRead.do", method = RequestMethod.GET)
	public String memberNoticeRead(Model model, NoticeVO nvo
			, @RequestParam("n_no") int n_no 
			, @RequestParam(value= "n_hit", required = false) int n_hit ){
		
		// 공지사항 클릭 => 조회수(n_hit)+ 1 update
		n_hit += 1;
		nvo.setN_hit(n_hit);
		nvo.setN_no(n_no);
		int n = noticeDao.noticeHitUpdate(nvo);
		if( n == 0) {
			logger.info("===========조회수업뎃 실패");
		};
		
		model.addAttribute("notice", noticeDao.noticeSelect(nvo));
		// 조회수 count되게 만들어야 함 클릭했을 때, 
		// 현재 조회수 count를 가져가야 하나? 
		return "home/member/memberNoticeRead";
	}
	
	// memberMyInfo 자기소개 수정  resonseEntity로 해보기 
	@RequestMapping("/ajaxMyIntroUpdate.do")
	public ResponseEntity<String> ajaxMyIntroUpdate(MemberVO mvo, HttpServletRequest request
			,@RequestParam(value = "m_email" , required = false) String m_email
			,@RequestParam(value = "m_intro", required = false) String m_intro){
		
		logger.info("================ajax로 넘어온 m_email값: " + m_email);
		logger.info("================ajax로 넘어온 m_intro값: " + m_intro);
		
		mvo.setM_intro(m_intro);
		mvo.setM_email(m_email);
		
		String message = null;
		int n = memberDao.memberUpdate(mvo);
		if(n == 1) { 
			message = "Update Success";
			logger.info("=====================업데이트 성공");
			return new ResponseEntity<String>(message, HttpStatus.OK);
		} else {
			message = "Updae failure...";
			logger.info("=====================업데이트 실패");
			return new ResponseEntity<String>(message, HttpStatus.NOT_IMPLEMENTED);
		}
	}
	
	// memberMyInfo 프로모션 동의여부 수정 
	@ResponseBody
	@RequestMapping("/ajaxJoinTermsUpdate.do")
	public String ajaxPromotionUpdate(MemberVO mvo, HttpServletRequest request
			,@RequestParam(value = "m_email", required = false) String m_email
			,@RequestParam(value = "m_privacy", required = false) String m_privacy
			,@RequestParam(value = "m_promotion", required = false) String m_promotion) {
		
		logger.info("================ ajax로 날아온 m_email값: " + m_email);
		logger.info("================ ajax로 날아온 m_promotion값: " + m_promotion);
		logger.info("================ ajax로 날아온 m_privacy: " + m_privacy);
		
		mvo.setM_privacy(m_privacy);
		mvo.setM_email(m_email);
		mvo.setM_promotion(m_promotion);
		String message = null;
		int n = memberDao.ajaxJoinTermsUpdate(mvo);
		if( n ==1) {
			message ="Update Success!!";
			logger.info("======================업데이트 성공");
		} else {
			message = "Update Failure!!";
			logger.info("=====================업데이트 실패");
		}
		return message;
	}
	
	// 회원탈퇴 처리 => m_status값만 변경. 
	@ResponseBody
	@RequestMapping("/ajaxMemberLeave.do")
	public ResponseEntity<String> ajaxMemberLeave(HttpServletRequest request
			,@RequestParam("m_email") String m_email
			,@RequestParam("m_status") String m_status
			,MemberVO mvo) {
		
		logger.info("=================== ajax 넘어온 이메일: " + m_email); 
		logger.info("================== ajax로 넘어온 상태값: " + m_status);
		
		String result = null;
		mvo.setM_email(m_email);
		mvo.setM_status(m_status);
		// map.xml에 모두 정의해놓음. 
		int n = memberDao.memberUpdate(mvo);
		if(n == 1) {
			result = "YES";
			logger.info("===============업데이트 성공");
			return new ResponseEntity<String>(result, HttpStatus.OK);
		} else {
			result = "NO";
			logger.info("================ 업데이트 실패");
			return new ResponseEntity<String>(result, HttpStatus.NOT_MODIFIED);
		}
	}
	
	// 연락처 수정 ajax 
	@ResponseBody
	@RequestMapping(value = "ajaxMemberUpdate.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> ajaxMemberUpdate( MemberVO mvo,
				@RequestParam String m_email,
				@RequestParam String m_phone){
		
		System.out.println("에메일: " + m_email);
		System.out.println("연락처: " + m_phone);
		mvo.setM_email(m_email);
		mvo.setM_phone(m_phone);
		String message = null;
		
		int n = memberDao.memberUpdate(mvo);
		if( n == 1) {
			message = "YES";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		} else {
			message = "NO";
			return new ResponseEntity<String>(message, HttpStatus.NOT_MODIFIED);
		}
	}
	
	// 주소 변경 업데이트
	@ResponseBody
	@PostMapping(value = "ajaxAddressUpdate.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> ajaxNicknameUpdate( @RequestBody MemberVO mvo){
		
		System.out.println("@requestbody값: " + mvo);
		
		String message = null;
		int n = memberDao.memberUpdate(mvo);
		if(n == 1) {
			message = "YES";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(message, HttpStatus.NOT_MODIFIED);
		}
	}
	
	// 비밀번호 수정 전 기존 비밀번호 확인  ( salt값이랑 digest값 감안해야 한다) 
	@ResponseBody
	@GetMapping(value = "ajaxPwdCheck.do")
	public ResponseEntity<String> ajaxPwdCheck(MemberVO mvo, @RequestParam String m_email,
					@RequestParam String m_password){
		
		logger.info("넘어온 이메일: " + m_email + ",  넘어온 비밀번호: " + m_password);
		// 1. 우선 이메일을 통해서 현재 salt값을 조회
			// 2. 해당 salt값이랑 입력한 비밀번호를 통해서 digest비밀번호를 생성하여, 맞는지 조회
		mvo.setM_email(m_email);
		String m_salt = memberDao.selectSalt(mvo);
		m_password = SHA256Util.getEncrypt(m_password, m_salt);
		mvo.setM_password(m_password);
		boolean b = memberDao.ajaxPwdCheck(mvo);
		String message = "";
		if(b) {  // true가 리턴된 경우(입력한 이메일과 비밀번호로 조회결과 없음)  
			System.out.println("b의 값: " + b);
			message  ="NO"; 
			return new ResponseEntity<String>(message, HttpStatus.OK);
		} else { // false가 리턴된 경우(입력한 이메일과 비밀번호와 일치)
			System.out.println("b의 값: " + b);  
			message = "YES";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		}
	}
	
	// 비밀번호 업데이트 ajax
	@ResponseBody
	@PostMapping(value= "ajaxNewPwdUpdate.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> ajaxNewPwdUpdate(@RequestBody Map<String, Object> map, MemberVO mvo){
		
		System.out.println("map의 형태: " + map);
		String password = (String) map.get("m_password");
		String m_email = (String) map.get("m_email");
		System.out.println("조회: " + m_email  + ", " +  password);   
		
		// 새로운 m_salt값 생성
		String m_salt = SHA256Util.generateSalt();
		// 암호화가 적용된 새로운 비밀번호 생성
		String m_password = SHA256Util.getEncrypt(password, m_salt); 
		mvo.setM_email(m_email);
		mvo.setM_salt(m_salt);
		mvo.setM_password(m_password);
		int n = memberDao.memberUpdate(mvo);
		String message = "";
		if(n == 1) {
			message = "YES";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		} else {
			message = "NO";
			return new ResponseEntity<String>(message, HttpStatus.NOT_MODIFIED);
		}
	}
	
	// 관리자 화면에서 회원의 권한을 변경시킨다. put방식으로 고고
	@ResponseBody  
	@PutMapping(value = "memberStatusUpdate.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> memberStatusUpdate(@RequestBody MemberVO mvo){
		
		int n = memberDao.memberStatusUpdate(mvo);
		String message = null;
		if(n == 1) {
			message = "YES";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		} else {
			message = "NO";
			return new ResponseEntity<String>(message, HttpStatus.NOT_IMPLEMENTED);
		}
	}
}
