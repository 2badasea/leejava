package co.bada.leejava.web;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import co.bada.leejava.member.MemberService;
import co.bada.leejava.member.MemberVO;

@Controller
public class MemberController {
	@Autowired
	MemberService memberDao;
	
	// 관리자 회원리스트 페이지 이동
	@RequestMapping("/adminMemberList.do")
	public String adminMemberList(Model model, HttpServletRequest request
			, MemberVO mvo) {
		
		// v_memberlist(회원 정보 일부) 정보 가지고 페이지로 이동
		model.addAttribute("members", memberDao.v_memberSelectList());
		return "home/admin/adminMemberList";
	}
	
	// 유저 개인정보 조회하는 곳으로 이동 => 프로필 사진이랑 모두 추가해야 함. 
	@RequestMapping("/userMyInfo.do")
	public String userMyInfo(Model model, HttpServletRequest request,
			MemberVO mvo, HttpSession session) { 
		
		// 접속한 회원의 개인정보를 뿌려줘야 한다. 
		// 현재 Session_user의 값이 이메일 이므로 이걸 가져와야 함. 
		String m_email = (String) session.getAttribute("session_user");
		mvo.setM_email(m_email);
		mvo = memberDao.memberMyInfoList(mvo);
		model.addAttribute("member", mvo);
		return "home/userMyInfo";
	}
	   
	// 개인정보 페이지 프로필 이미지 사진 변경
	@PostMapping("/ajaxProfileUpdate.do")
	public void ajaxProfileUpdate(MultipartFile[] uploadFile) {
			// MultipartFile[] => 여러 파일을 받을 때 사용. 이렇게 해놓고 한 개만 업로드 해도 상관없다. 
			// 그릐고 for문으로 돌리면 된다. 나도 [] 형태로 수정.  
		
		// 나중에 log4j 설정하면 sysout은 사용하지 말 것. 
		System.out.println("ajaxProfileUpdate.do POST......");
		// 업로드할 프로필 사진을 저장할 경로 설정
		String uploadFolder = "C:\\leejava\\profile"; 
		
		// 'yyyy-MM-dd' 형태로 날짜 정보를 얻기 위함. 
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// 날짜 정보를 얻을 수 있는 객체 생성 => java.util.Date 패키지에 속한다. 
		Date date = new Date();  
		// sdf가 가지고 있는 format()메서드를 사용 => 인스턴스를 생성할 때 어떤 형식으로 날짜 정보를 제공할지 설정해놓음
		String str = sdf.format(date); 
		// 현재 str변수에는 날짜 사이에 '-'문자열 데이터가 저장되어 있음. replace()로 교체
		// File클래스에서 실행되는 환경에 따라 그에 맞는 경로 구분자를 반환하는 정적(static) 변수인
		// separator가 존재. => '-' 문자열을 String클래스의 replace() 메서드를 이용하여
		// File.separator로 변경해준다.  / 경로구분자를 말한다. 
		String profilePath = str.replace("-", File.separator);
		// File타입의 uploadPath 변수를 통하여 우리가 원하는 경로에 날짜별로 디렉토리를 생성하는 객체를 생성한다.
		File uploadPath = new File(uploadFolder,profilePath);
		
		// 그럼 폴더를 생성한다. 폴더를 생성하는 메서드로 mkdir()과 mkdirs() 메서드가 존재하는데,
		// 후자의 경우 여러 개의 폴더를 생성한다. => 우리는 mkdirs()메서드를 사용한다. 
		System.out.println("kim vam pa 쩐다...");
		// 날짜 정보가 담긴 디렉토리를 생성한다. 
		
		// 요청이 있을 때마다 새로운 폴더를 생성하는 것을 방지하기 위함 => File객체에서 제공하는 exist()메서드. 
		if(uploadPath.exists() == false) {
			// 요청이 있는 날짜 기준으로 폴더가 생성되었다. 
			// File.separator() 메서드를 통해 경로구분자(\) 기준으로 디렉토리 생성됨.
			uploadPath.mkdirs();
		}
		
		// 실제 파일을 폴더에 저장하기 위해서 transperTo() 메서드를 사용한다. 
		// 사용방법은 전달받은 파일인 MultipartFile 객체에 저장하고자 하는 위치를 지정한
		// File객체를 파라미터로 하여 transperTo() 메서드를 호출하면 된다. 
		// MultipartFile.transferTo(File detination); 대충 이런 형태 
		
		// 향상된 for문
		for(MultipartFile multipartFile : uploadFile) {
			// 파일 이름
			String uploadFileName = multipartFile.getOriginalFilename();
			
			// UUID 적용이 된 파일이름으로 변경
			String uuid = UUID.randomUUID().toString();
			
			uploadFileName = uuid + "_" + uploadFileName;
			
			// 파일 위치, 파일 이름을 합친 File 객체 
			File saveFile = new File(uploadPath, uploadFileName);
			
			
			
			// 실제 파일 저장이 일어나는 곳.
			try {
				multipartFile.transferTo(saveFile);
				// ImageIO를 통해 썸네일 이미지를 생성하기 위해 원본 파일과 썸네일 파일 객체가 필요
				// 썸네일 파일 객체는 원본 파일과 구분하기 위해 앞에 's_'를 붙이고 생성함.
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				// 원본 이미지 파일을 ImageIO의 read() 메서드를 호출하여 BufferedImage 타입으로
				// 변경해준 뒤 BufferedImage 타입의 참조 변수를 선언하여 해당 변수에 대입해준다. 
				// (bo_image 변수는 Buffered original image라는 의미로 작성=> 원하는 변수명 사용해도 된다) 
				BufferedImage bo_image = ImageIO.read(saveFile); 
				// BufferedImage 생성자 사용 => 썸네일 이미지인 BuffereImage 객체를 생성해주고
				// 참조 변수에 대입한다. => 일종의 크기를 지정하여 흰색 도화지를 만드는 과정이다. 
				// 사용한 BufferedImage 생성자는 매개변수로  넓이, 높이,'생성될 이미지 타입'을 작성하면 된다. 
				BufferedImage bt_image = new BufferedImage(300, 500, BufferedImage.TYPE_3BYTE_BGR);
				// 썸네일 BufferedImage 객체(bt_image)에서 createGraphics() 메서드 호출을 통해
				// Graphic2D 객체를 생성 해준 후 Graphic2D 타입의 참조 변수에 대입한다.
				// ( 앞서 만든 도화지에 그림을 그릴 수 있도록 하는 과정 ) 
				// 썸네일 BufferedImage 객체에 그림을 그리기 위해 Graphic2D 객체를 생성한다. 
				// Graphic2D 메서드를 통해 조작을 하게 되면 그 결과가 썸네일 BufferedImage 객체에 적용이 된다. 
				Graphics2D graphic = bt_image.createGraphics(); 
				
				// drawImage 메서드를 호출하면 원본 이미지를 썸네일 BufferedImage에 지정한 크기로 변경하여
				// 왼쪽 상단 "0,0" 좌표부터 그려준다. (마찬가지로 도화지에 이미지를 그리는 과정이라고 생각하면 된다) .
				graphic.drawImage(bo_image, 0, 0, 300, 500, null); 
				// 첫 번째 인자는 그려놓고자 하는 이미지
				// 2, 3 번째 인자는 그림을 어느 좌표부터 그릴 것인지에 대한 x값과 y값이다. 
				// 4, 5 번째 인자 값은 첫 번째 인자로 작성한 이미지의 '넓이'와 '높이' 
				// 지정한 '넓이'와 '높이'로 이미지 크기가 확대 혹은 축소되고, 크기가 변경된 이미지가 그려지게 된다. 
				// 여섯 번째 인자는 ImageObserver 객체. ImageObserver는 이미지의 정보를 전달받아서 
				// 이미지를 업데이트 시키는 역할을 한다. 일반적인 경우 null을 전달하면 된다. 
				
				//제작한 썸네일 이미지를 이제 파일로 만들어준다. ImageIO의 write() 메소드를 호출하여 파일로 저장. 
				ImageIO.write(bt_image, "jpg", thumbnailFile);
				// 첫 번째 인자는 파일로 저장할 이미지. 우리가 만든 썸네일 이미지를 인자로전달한다. 
				// 두 번째 인자는 어떠한 이미지 형식으로 저장할 것인지 String타입으로 작성한다. 
				// 세 번째 인자는 우리가 앞서 썸네일 이미지가 저장될 경로와 이름으로 생성된 File객체(thumbnailFile) 객체를 부여
				
				// 복잡해 보이지만 전체적인 과정은 java내에서 크기를 지정한 이미지를 만들고, 그 이미지에 맞게 원본 이미지를
				// 그려 놓은 다음 해당 이미지를 파일로 저장한 것이다. 
				
				
				System.out.println("성공");
			} catch (Exception e) {
				System.out.println("실패");
				e.printStackTrace();
			}
			
		}
		
//		// 향상된 for문으로 하는 방식
//		for(MultipartFile multipartFile : uploadFile) { 
//			System.out.println("ajaxProfileUpdate.do POST......");
//			System.out.println("파일 이름 : " + multipartFile.getOriginalFilename());
//			System.out.println("파일 타입 : " + multipartFile.getContentType());
//			System.out.println("파일 크기 : " + multipartFile.getSize());
//		}
//		// 기본 for문을 이용한 방식
//		for(int i = 0; i< uploadFile.length; i++) {
//			System.out.println("ajaxProfileUpdate.do POST......");
//			System.out.println("파일 이름 : " + uploadFile[i].getOriginalFilename());
//			System.out.println("파일 타입 : " + uploadFile[i].getContentType());
//			System.out.println("파일 크기 : " + uploadFile[i].getSize());
//		}
		
		
		
	}
	
	// 개인정보 페이지에서 닉네임 변경 신청
	@RequestMapping("/ajaxNicknameUpdate.do")
	public String ajaxNicknameUpdate(Model model, HttpServletRequest request
			, MemberVO mvo
			,@RequestParam("m_nickname") String m_nickname
			,@RequestParam("m_email") String m_email ) {
		
		// 닉네임이랑 회원의 이메일을 가져와야 한다. 
		System.out.println("ajax를 통해 들어온 새로운 닉네임: " + m_nickname);
		System.out.println("ajax로 넘어온 전역변수 사용자 이메일: " + m_email );
		
		String responseText = "압도적 감사!";
		
		return responseText;
	}
	
}
