package co.bada.leejava.web;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.bada.leejava.AttachImageVO;
import co.bada.leejava.CoolSMS;
import co.bada.leejava.SHA256Util;
import co.bada.leejava.member.MemberService;
import co.bada.leejava.member.MemberVO;
import co.bada.leejava.notice.NoticeService;
import co.bada.leejava.notice.NoticeVO;
/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	MemberService memberDao;
	// 자바 이메일을 활용하기 위함 => root-context.xml에 설정해주었음. 네이버는 mailSender, 구글은 mailSender2
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	NoticeService noticeDao;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	// 홈으로 이동
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date(); 
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("notices", noticeDao.mainNoticeSelectList());
		
		
		return "home/home"; 
		
		// private int memberInsert(memberVO mvo)
	}
	
	
	// 로그인 창으로 이동
	@RequestMapping("/loginPage.do")
	public String loginPage(Model model) {
		return "home/loginPage";
	}
	
	// 로그인 처리
	@ResponseBody
	@RequestMapping("/login.do")
	public String login(Model model, MemberVO mvo, HttpSession session, HttpServletRequest request) {
		
		String email = request.getParameter("email");
		String formPassword = request.getParameter("password");
		System.out.println("확인 Email: " + email + " Password: " + formPassword);
		
		
		mvo.setM_email(email);
		String m_salt = memberDao.selectSalt(mvo);
		String responseText = null;
		if( m_salt != null) {
			// m_salt값과 입력한 패스워드값을 getEncrypt( ) 메소드의 인자로 넘겨서 넘어오는 다이제스트값과 db상의 m_password비교. 
			String m_password = SHA256Util.getEncrypt(formPassword, m_salt);
			mvo.setM_password(m_password);
			mvo = memberDao.memberSelect(mvo);  // 이메일 아이디와 다이제스트 비밀번호를 넘겨서 조회
			if(mvo != null) {
				String nickname = mvo.getM_nickname(); // nickname을 가져옴. 사이트에서 사용할 수 있는
				session.setAttribute("session_user", email);
				session.setAttribute("session_nickname", nickname);
				System.out.println("세션에 담은 값: " + email + ", " + nickname);
				responseText = "YES";
			}else {
				// salt값은 있는데, 암호화한 비밀번호가 틀리 경우 
				responseText = "NO";
			}
		}else { 
			// m_salt값을 조회할 수 없었던 경우.
			responseText = "NO"; 
		}
		
		return responseText;
	}
	
	// 로그아웃 처리
	@RequestMapping("/logout.do")
	public String logout(Model model, HttpSession session) {
		
		String sessionValue =(String)session.getAttribute("session_user");
		System.out.println("없애버릴 세션값: " + sessionValue );
		
		session.invalidate();
		
		return "redirect:loginPage.do";
	}
	
	// 회원 가입 약관 동의 페이지 이동
	@RequestMapping("/memberJoinTerms.do")
	public String memberJoinTerms(Model model) {
		return "home/memberJoinTerms";
	}
	
	// 회원가입 양식으로 이동
	@RequestMapping("/memberJoinForm.do")
	public String memberJoinForm(Model model, HttpServletRequest request){
		
		String privacy = request.getParameter("privateTerms");
		String promotion = request.getParameter("promotionTerms");
		System.out.println("개인정보 유효기간 선택사항 확인: " + privacy );
		System.out.println("프로모션 수신 여부 선택사항 확인: " + promotion);
		
		// 값이 Y든 NULL이든 그 상태로 DB에 넣으면 된다.
		model.addAttribute("privacy", privacy);
		model.addAttribute("promotion", promotion);
		
		return "home/memberJoinForm";
	}
	
	// 회원가입 이메일 Ajax 중복 체크
	@ResponseBody
	@RequestMapping("/ajaxEmailCheck.do")
	public String ajaxEmailCheck(Model model, HttpServletRequest request, MemberVO mvo) {
		
		String email = request.getParameter("email");
		System.out.println("ajax로 넘어온 이메일 값: " + email);
		String responseText = null;
		
		mvo.setM_email(email);
		
		boolean b = memberDao.memberEmailCheck(mvo);
		if(b) {
			// 입력한 이메일이 존재하지 않음 => 사용가능한 이메일
			responseText = "YES";	
		} else {
			// 중복 이메일 존재 => 사용불가
			responseText = "NO";
		}
		System.out.println("컨트롤러, 이메일 존재여부 체크 값 NO여야 함" + responseText);
		return responseText;
	}
	
	// 회원가입 닉네임 중복체크 ajax
	@ResponseBody
	@RequestMapping("/ajaxNicknameCheck.do")
	public String ajaxNicknameCheck(HttpServletRequest request, MemberVO mvo) {
		
		String nickname = request.getParameter("nickname");
		System.out.println("ajax로 넘어온 닉네임 값: " + nickname);
		
		mvo.setM_nickname(nickname);
		String responseText = null;
		boolean b = memberDao.memberNicknameCheck(mvo);
		if(b) {
			responseText = "YES";
		} else {
			responseText = "NO";
		}
		return responseText;
	}
	
	// coolsms 인증번호 ajax로 받기
	@ResponseBody
	@RequestMapping("/ajaxCoolSMS.do")
	public String ajaxCoolSMS(HttpServletRequest request) {
		
		String sendPhone = request.getParameter("inputPhone");
		System.out.println("ajax로 넘어온 번호: " + sendPhone);
		
		// 6자리 생성 => 10을 곱하면 최소 1자리수. 
		int randomNumber = (int)(Math.random()*(999999-100000+1)) +100000;
		System.out.println("인증번호 값 확인: " + randomNumber);
		
		CoolSMS coolSms = new CoolSMS();
		coolSms.certifiedPhone(sendPhone, randomNumber);
		
		return Integer.toString(randomNumber);
	}
	
	// 회원가입 요청 
	@RequestMapping("/memberJoin.do")
	public String memberJoin(HttpServletRequest request, MemberVO mvo, Model model, AttachImageVO ivo) {
		
		// 일단 모든 넘어온 값들 확인ㄱㄱ
		System.out.println("Eamil 값: " + request.getParameter("email"));
		System.out.println("nickname 값: " + request.getParameter("nickname"));
		System.out.println("password 값: " + request.getParameter("password"));
		System.out.println("phone 값: " + request.getParameter("phone"));
		System.out.println("address 값: " + request.getParameter("address"));
		System.out.println("birthdate 값: " + request.getParameter("birthdate"));
		System.out.println("privacy 값: " + request.getParameter("privacy"));
		System.out.println("promotion 값: " + request.getParameter("promotion"));
		
		// 추가적으로 넣어야 하는 값들 sysdate, joinpath(가입경로), status(권한 : USER) 
		String m_email = request.getParameter("email");
		String m_nickname = request.getParameter("nickname");
		String password = request.getParameter("password");
		String m_phone = request.getParameter("phone");
		String m_address = request.getParameter("address");
		String m_birthdate = request.getParameter("birthdate");
		// String m_joindate = 쿼리에서 sysdate로 처리함.
		String m_joinpath = "자바이야기";
		String m_status = "USER";
		String m_privacy = request.getParameter("privacy");
		String m_promotion = request.getParameter("promotion");
		
		
		
		/* 패스워드 암호화 부분 */
		// salt 생성. salt값도 db에 들어간다.
		String m_salt = SHA256Util.generateSalt();
		System.out.println("salt 값 조회: " + m_salt);
		String m_password = SHA256Util.getEncrypt(password, m_salt);
		System.out.println("암호화된 m_password : " + m_password);
		
		
		mvo.setM_email(m_email);
		mvo.setM_nickname(m_nickname);
		mvo.setM_password(m_password);
		mvo.setM_phone(m_phone);
		mvo.setM_address(m_address);
		mvo.setM_birthdate(m_birthdate);
		mvo.setM_joinpath(m_joinpath);
		mvo.setM_status(m_status);
		mvo.setM_salt(m_salt);  // salt값도 db컬럼에 담는다.
		
		mvo.setM_privacy(m_privacy);
		mvo.setM_promotion(m_promotion);
		
		String message = null;
		
		int n = memberDao.memberInsert(mvo);
		if( n == 0) {
			System.out.println("회원가입 실패");
			message = "회원가입이 실패했습니다. 관리자에게 문의해주세요";
		} else {
			System.out.println("회원가입 성공");
			message = "회원가입이 성공했습니다. 로그인 해주세요";
		}
		
		if(n == 1) {
			// 회원가입이 성공적으로 됐다면, 이것도 추가.
			int m = memberDao.memberJointerms(mvo);
			if(m == 0) {
				System.out.println("가입약관 오류");
			} else {
				System.out.println("가입약관 정상 반영");
			}
		}
		// 회원가입이 성공 => 프로필 이미지 테이블에도 행 추가
		if(n ==1) { 
			ivo.setM_email(m_email);
			ivo.setFileName("");
			ivo.setUploadPath("");
			ivo.setUuid("");
			int o = memberDao.profileInsert(ivo);
			if( o == 1) { 
				System.out.println("프로필 테이블 정상 추가");
			} else {
				System.out.println("프로필 테이블 실패");
			}
		}
		
		model.addAttribute("message", message); // 스크립트로 message내용을 alert로 보여줘보기
		return "home/loginPage";
	}
	
	// 관리자 페이지로 이동 
	@RequestMapping("/adminPage.do")
	public String adminPage(Model model, HttpServletRequest request) {
		
		return "home/admin/adminHome";
	}
	
	// 이메일 인증코드 확인용 by 비밀번호 분실
	@ResponseBody
	@RequestMapping("/ajaxEmailCheckForgotPassword.do")
	public String ajaxEmailCheckForgotPassword(HttpServletRequest request, 
			Model model, @RequestParam("inputEmail") String m_email) throws Exception {
		
		System.out.println("ajax로 입력한 이메일 넘어왔니? " + m_email);
		// 인증번호(난수) 생성
		Random random = new Random();
		int checkNum = random.nextInt(8888) + 1111; // 1111~9999 범위의 숫자를 얻기 위함.
		System.out.println("인증번호" + checkNum); // 콘솔창에 인증번호 나오는지 확인.
		
		
		/************** 이메일 인증 일단 보류**************/
		// 이메일 보내기. 주석 삭제하면 실제 이메일 날라감. ( 변수를 선언해서 이메일 전송에 필요로 한 데이터를 할당한다.) 
		String setFrom = "gnjqtpf1@naver.com";  // root-context.xml에 작성한 자신의 이메일 계정. 아이디랑 메일주소 모두 입력!
		String toMail = m_email;					// 수신받을 이메일. view로부터 받은 이메일 주소인 변수 email을 사용
		String title = "비밀번호 분실 인증 이메일 입니다.";  // 자신이 보낼 이메일 제목
		String content = 						// 자신이 보낼 이메일 내용
				"javastory를 이용해주셔서 감사합니다." +
		"<br><br>" +
				"인증번호는 " + checkNum + " 입니다." +
				"<br>" +
				"해당 인증번호를 인증번호 확인란에 입력해주세요.";
		
		System.out.println("실제 시작하는 부분. try시작 부분");
		try  {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			System.out.println("여기는? 111 ");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			System.out.println("여기는? 222 ");
			mailSender.send(message);
			System.out.println("여기는? 333 ");
		} catch (Exception e ) {
			e.printStackTrace();
		}

		// 생성한 인증번호 변수를 view로 반환. 생성한 인증번호의 경우 int 타입. ajax를 통한 요청으로 인해 view로 다시 반환할 때
		// 데이터 타입은 String만 가능.
		String responseCode = Integer.toString(checkNum); // return타입도 void에서 String으로 수정. 테스트는 끝났으니깐.
		System.out.println("컨트롤러에서 넘어가는 인증코드 : " + responseCode);
		return responseCode; // ajax를 요청한 view페이지로 num데이터(인증번호)를 전달한다. => 해당 view의 ajax구문으로 ㄱㄱ
	}
	
	// ajax로 새로운 비밀번호로 업데이트 시키기
	@ResponseBody
	@RequestMapping("/ajaxNewPasswordUpdate.do")
	public String ajaxNewPasswordUpdate(Model model, HttpServletRequest request, 
			MemberVO mvo, @RequestParam("m_email") String m_email, @RequestParam("m_password") String password) {
		
		System.out.println("ajax로 넘어온 이메일이랑 새로운 비밀번호 조회: " +  m_email + " : " + password);
		
		// 새로운 salt값과 다이제스트 암호 생성
		String m_salt = SHA256Util.generateSalt();
		System.out.println("새로운 salt 값 조회: " + m_salt);
		String m_password = SHA256Util.getEncrypt(password, m_salt);
		System.out.println("새로운 암호화된 m_password : " + m_password);
		
		// mapper를 통해 새로운 비밀번호를 DB에 update시킨다.
		mvo.setM_email(m_email);
		mvo.setM_salt(m_salt);
		mvo.setM_password(m_password);
		int n = memberDao.ajaxNewPasswordUpdate(mvo);
		String responseText = "NO";
		if( n != 0) {
			System.out.println("새로운 비밀번호 변경 성공");
			responseText = "YES";
		} else {
			System.out.println("비밀번호 변경 실패");
		}
		return responseText;
	}
	
	// 사용자뷰 공지사항으로 이동
	@RequestMapping("/userNoticeList.do")
	public String userNoticeList(Model model, HttpServletRequest request
			,NoticeVO nvo) {
		
		// 공지사항 리스트 목록 전체를 날려보낸다.
		model.addAttribute("notices", noticeDao.noticeSelectList());
		
		return "home/userNoticeList";
	}
	
	// 사용자뷰 공지사항 조회
	@RequestMapping("/userNoticeRead.do")
	public String userNoticeRead(Model model, HttpServletRequest request
			, NoticeVO nvo, @RequestParam("n_no") int n_no , @RequestParam(value= "n_hit", required = false) int n_hit ){
		
		System.out.println("view단에서 넘어온 조회할 글 번호: " + n_no);
		System.out.println("view단에서 넘어온 조회수 확인: " + n_hit);
		
		// 공지사항 클릭하면 조히수도 올리도록 한다. update
		n_hit += 1;
		System.out.println("업데이트할 조회수 값은 얼마? " + n_hit);
		nvo.setN_hit(n_hit);
		nvo.setN_no(n_no);
		int n = noticeDao.noticeHitUpdate(nvo);
		if( n != 0) {
			System.out.println("조회수 업뎃 성공");
		} else {
			System.out.println("조회수업뎃 실패");
		}
		
		model.addAttribute("notice", noticeDao.noticeSelect(nvo));
		// 조회수 count되게 만들어야 함 클릭했을 때, 
		// 현재 조회수 count를 가져가야 하나? 
		
		return "home/userNoticeRead";
	}
	
	
}
