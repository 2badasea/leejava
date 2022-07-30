package co.bada.leejava.web;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.bind.annotation.RequestBody;
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
//		logger.info("==========Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);
		model.addAttribute("notices", noticeDao.mainNoticeSelectList());

		return "home/member/home";

		// private int memberInsert(memberVO mvo)
	}

	// 로그인 창으로 이동
	@RequestMapping("/loginPage.do")
	public String loginPage(Model model, HttpServletRequest request) {
		logger.info("어디 페이지에서 로그인 요청이 날라왔는지 확인하는 request.getHeader('referer')" + request.getHeader("Referer"));
		// 로그인 요청이 온 페이지의 URI를 받아서, login입력창의 input요소에 부여한다.
		// 로그인이 성공하면 해당 uri정보가 담긴 태그의 value값을 받아서 location.href로 넘긴다.
		String referer = request.getHeader("Referer");
		System.out.println("referer값:" + referer);
		model.addAttribute("url", referer);
//		return "redirect:" + referer;
		return "home/member/loginPage";
	}

	// 로그인 처리
	@ResponseBody
	@RequestMapping("/login.do")
	public String login(Model model, MemberVO mvo, HttpSession session, HttpServletRequest request) {

		String email = request.getParameter("email");
		String formPassword = request.getParameter("password");
		logger.info("===============확인 Email: " + email + " Password: " + formPassword);

		mvo.setM_email(email);
		String m_salt = memberDao.selectSalt(mvo);
		String responseText = null;
		if (m_salt != null) {
			// m_salt값과 입력한 패스워드값을 getEncrypt( ) 메소드의 인자로 넘겨서 넘어오는 다이제스트값과 db상의
			// m_password비교.
			// salt값은 정해져 있다. 그래서 전달하는 정보가 같다면 해당 salt값을 통한 다이제스트 값도 동일하다.
			String m_password = SHA256Util.getEncrypt(formPassword, m_salt);
			mvo.setM_password(m_password);
			mvo = memberDao.memberSelect(mvo); // 이메일 아이디와 다이제스트 비밀번호를 넘겨서 조회
			if (mvo != null) {
				String nickname = mvo.getM_nickname(); // nickname을 가져옴. 사이트에서 사용할 수 있는
				// 회원등급도 같이 가져와서 session값에 부여한다. ADMIN 
				String mstatus = mvo.getM_status();
				session.setAttribute("session_status", mstatus);
				session.setAttribute("session_user", email);
				session.setAttribute("session_nickname", nickname);
				logger.info("===============세션에 담은 이메일: " + email + ", 그리고 닉네임" + nickname);
				responseText = "YES";
			} else {
				// salt값은 있는데, 암호화한 비밀번호가 틀리 경우
				responseText = "NO";
			}
		} else {
			// m_salt값을 조회할 수 없었던 경우.
			responseText = "NO";
		}

		return responseText;
	}

	// 로그아웃 처리
	@RequestMapping("/logout.do")
	public String logout(Model model, HttpSession session) {

		String sessionValue = (String) session.getAttribute("session_user");
		logger.info("==========없애버릴 세션값: " + sessionValue);

		session.invalidate();

		return "redirect:loginPage.do";
	}

	// 회원 가입 약관 동의 페이지 이동
	@RequestMapping("/memberJoinTerms.do")
	public String memberJoinTerms(Model model) {
		return "home/member/memberJoinTerms";
	}

	// 회원가입 양식으로 이동
	@RequestMapping("/memberJoinForm.do")
	public String memberJoinForm(Model model, HttpServletRequest request) {

		String privacy = request.getParameter("privateTerms");
		String promotion = request.getParameter("promotionTerms");
		logger.info("===========개인정보 유효기간 선택사항 확인: " + privacy);
		logger.info("===========프로모션 수신 여부 선택사항 확인: " + promotion);

		// 값이 Y든 NULL이든 그 상태로 DB에 넣으면 된다.
		model.addAttribute("privacy", privacy);
		model.addAttribute("promotion", promotion);

		return "home/member/memberJoinForm";
	}

	// 회원가입 이메일 Ajax 중복 체크
	@ResponseBody
	@RequestMapping("/ajaxEmailCheck.do")
	public String ajaxEmailCheck(Model model, HttpServletRequest request, MemberVO mvo) {

		String email = request.getParameter("email");
		logger.info("===========ajax로 넘어온 이메일 값: " + email);
		String responseText = null;

		mvo.setM_email(email);

		// count값이 0이면 true를 반환
		boolean b = memberDao.memberEmailCheck(mvo);
		if (b) {
			// 입력한 이메일이 중복으로 존재하지 않음 => 사용가능한 이메일
			responseText = "YES";
		} else {
			// 중복 이메일 존재 => 사용불가
			responseText = "NO";
		}
		logger.info("===========컨트롤러, 이메일 존재여부 체크 값 YES 여야 함" + responseText);
		return responseText;
	}

	// 회원가입 닉네임 중복체크 ajax
	@ResponseBody
	@RequestMapping("/ajaxNicknameCheck.do")
	public String ajaxNicknameCheck(HttpServletRequest request, MemberVO mvo) {

		String nickname = request.getParameter("nickname");
		logger.info("===========ajax로 넘어온 닉네임 값: " + nickname);

		mvo.setM_nickname(nickname);
		String responseText = null;
		boolean b = memberDao.memberNicknameCheck(mvo);
		if (b) {
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
		logger.info("===========ajax로 넘어온 번호: " + sendPhone);

		// 6자리 생성 => 10을 곱하면 최소 1자리수.
		int randomNumber = (int) (Math.random() * (999999 - 100000 + 1)) + 100000;
		logger.info("===========인증번호 값 확인: " + randomNumber);

		CoolSMS coolSms = new CoolSMS();
		// 해당 클래스에 존재하는 certifiedPhone()으로 매개변수를 전달하면 해당 클래스에서 실행하게 된다.
		coolSms.certifiedPhone(sendPhone, randomNumber);

		return Integer.toString(randomNumber);
	}

	// 회원가입 요청
	@RequestMapping("/memberJoin.do")
	public String memberJoin(HttpServletRequest request, MemberVO mvo, Model model, AttachImageVO ivo) {

		// 일단 모든 넘어온 값들 확인ㄱㄱ
		logger.info("===========Eamil 값: " + request.getParameter("email"));
		logger.info("===========nickname 값: " + request.getParameter("nickname"));
		logger.info("===========password 값: " + request.getParameter("password"));
		logger.info("===========phone 값: " + request.getParameter("phone"));
		logger.info("===========address 값: " + request.getParameter("address"));
		logger.info("===========birthdate 값: " + request.getParameter("birthdate"));
		logger.info("===========privacy 값: " + request.getParameter("m_privacy"));
		logger.info("===========promotion 값: " + request.getParameter("m_promotion"));

		// 추가적으로 넣어야 하는 값들 sysdate, joinpath(가입경로), status(권한/상태 : USER) , m_into
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
		String m_intro = "";

		/* 패스워드 암호화 부분 */
		// salt 생성. salt값도 db에 들어간다.
		String m_salt = SHA256Util.generateSalt();
		logger.info("===========salt 값 조회: " + m_salt);
		String m_password = SHA256Util.getEncrypt(password, m_salt);
		logger.info("===========암호화된 m_password : " + m_password);

		mvo.setM_email(m_email);
		mvo.setM_nickname(m_nickname);
		mvo.setM_password(m_password);
		mvo.setM_phone(m_phone);
		mvo.setM_address(m_address);
		mvo.setM_birthdate(m_birthdate);
		mvo.setM_joinpath(m_joinpath);
		mvo.setM_status(m_status);
		mvo.setM_salt(m_salt); // salt값도 db컬럼에 담는다.
		mvo.setM_intro(m_intro);

		mvo.setM_privacy(m_privacy);
		mvo.setM_promotion(m_promotion);

		String message = null;
		int n = memberDao.memberInsert(mvo);
		if (n == 0) {
			logger.info("===========회원가입 실패");
			message = "회원가입이 실패했습니다. 관리자에게 문의해주세요";
		} else {
			logger.info("===========회원가입 성공");
			message = "회원가입이 성공했습니다. 로그인 해주세요";
		}

		if (n == 1) {
			// 회원가입이 성공적으로 됐다면, 이것도 추가.
			int m = memberDao.memberJointerms(mvo);
			if (m == 0) {
				logger.info("===========가입약관 오류");
			} else {
				logger.info("===========가입약관 정상 반영");
			}
		}

		model.addAttribute("message", message); // 스크립트로 message내용을 alert로 보여줘보기
		return "home/member/loginPage";
	}

	// 관리자 페이지로 이동
	@RequestMapping("/adminPage.do")
	public String adminPage(Model model, HttpServletRequest request) {

		return "home/admin/adminHome";
	}

	// 이메일 인증코드 확인용 by 비밀번호 분실
	@ResponseBody
	@RequestMapping("/ajaxEmailCheckForgotPassword.do")
	public String ajaxEmailCheckForgotPassword(HttpServletRequest request, Model model,
			@RequestParam("inputEmail") String m_email) throws Exception {

		logger.info("===========ajax로 입력한 이메일 넘어왔니? " + m_email);
		// 인증번호(난수) 생성
		Random random = new Random();
		int checkNum = random.nextInt(8888) + 1111; // 1111~9999 범위의 숫자를 얻기 위함.
		logger.info("===========인증번호" + checkNum); // 콘솔창에 인증번호 나오는지 확인.

		/************** 이메일 인증 일단 보류 **************/
		// 이메일 보내기. 주석 삭제하면 실제 이메일 날라감. ( 변수를 선언해서 이메일 전송에 필요로 한 데이터를 할당한다.)
		String setFrom = "gnjqtpf1@naver.com"; // root-context.xml에 작성한 자신의 이메일 계정. 아이디랑 메일주소 모두 입력!
		String toMail = m_email; // 수신받을 이메일. view로부터 받은 이메일 주소인 변수 email을 사용
		String title = "비밀번호 분실 인증 이메일 입니다."; // 자신이 보낼 이메일 제목
		String content = // 자신이 보낼 이메일 내용
				"javastory를 이용해주셔서 감사합니다." + "<br><br>" + "인증번호는 " + checkNum + " 입니다." + "<br>"
						+ "해당 인증번호를 인증번호 확인란에 입력해주세요.";

		logger.info("===========실제 시작하는 부분. try시작 부분");
		try {
			// 이메일을 보낼 수 있는 객체 생성
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
			logger.info("============메일 전송 완료==========");
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("============== 메일 전송 실패============");
		}

		// 생성한 인증번호 변수를 view로 반환. 생성한 인증번호의 경우 int 타입. ajax를 통한 요청으로 인해 view로 다시 반환할 때
		// 데이터 타입은 String만 가능.
		String responseCode = Integer.toString(checkNum); // return타입도 void에서 String으로 수정. 테스트는 끝났으니깐.
		logger.info("===========컨트롤러에서 넘어가는 인증코드 : " + responseCode);
		return responseCode; // ajax를 요청한 view페이지로 num데이터(인증번호)를 전달한다. => 해당 view의 ajax구문으로 ㄱㄱ
	}

	// ajax로 새로운 비밀번호로 업데이트 시키기 ( 비밀번호를 찾는 과정에서 새롭게 업데이트 ) 
	@ResponseBody
	@RequestMapping("/ajaxNewPasswordUpdate.do")
	public String ajaxNewPasswordUpdate(Model model, HttpServletRequest request, MemberVO mvo,
			@RequestParam("m_email") String m_email, @RequestParam("m_password") String password) {

		logger.info("===========ajax로 넘어온 이메일이랑 새로운 비밀번호 조회: " + m_email + " : " + password);

		// 새로운 salt값과 다이제스트 암호 생성
		String m_salt = SHA256Util.generateSalt();
		logger.info("===========새로운 salt 값 조회: " + m_salt);
		String m_password = SHA256Util.getEncrypt(password, m_salt);
		logger.info("===========새로운 암호화된 m_password : " + m_password);

		// mapper를 통해 새로운 비밀번호를 DB에 update시킨다.
		mvo.setM_email(m_email);
		mvo.setM_salt(m_salt);
		mvo.setM_password(m_password);
		int n = memberDao.ajaxNewPasswordUpdate(mvo);
		String responseText = "NO";
		if (n != 0) {
			logger.info("===========새로운 비밀번호 변경 성공");
			responseText = "YES";
		} else {
			logger.info("===========비밀번호 변경 실패");
		}
		return responseText;
	}

	// 연락처 조회 by memberMyInfo.jsp 회원탈퇴 부분
	@ResponseBody
	@RequestMapping("ajaxPhoneSelect.do")
	public String ajaxPhoneSelect(MemberVO mvo, HttpServletRequest request, 
			@RequestParam("m_email") String m_email,
			@RequestParam("m_phone") String m_phone, 
			@RequestParam("m_password") String m_password) {

		logger.info("======================= ajax로 넘어온 이메일: " + m_email);
		logger.info("======================= ajax로 넘어온 연락처: " + m_phone);
		logger.info("======================= ajax로 넘어온 비밀번호: " + m_password);

		mvo.setM_email(m_email);
		String result = null;
		String m_salt = memberDao.selectSalt(mvo);
		if (m_salt != null) {
			// m_salt값과 입력한 패스워드값을 getEncrypt( ) 메소드의 인자로 넘겨서 넘어오는 다이제스트값과 db상의
			// m_password비교.
			m_password = SHA256Util.getEncrypt(m_password, m_salt);
			mvo.setM_password(m_password);
			mvo.setM_phone(m_phone);	
			mvo = memberDao.memberSelect(mvo); // 이메일 아이디와 다이제스트 비밀번호를 넘겨서 조회
			if (mvo != null) {
				result = "YES";
				logger.info("======================사용자 정보 조회 성공");
			} else {
				// salt값은 있는데, 암호화한 비밀번호가 틀리 경우
				result = "Passowrd is not correct";
				logger.info("=====================입력한 비밀번호가 틀림");
			}
		} else {
			// m_salt값을 조회할 수 없었던 경우.
			result = "Password Error...";
			logger.info("======================== m_salt값 조회 실패");
		}
		return result;
	}

	// 관리자 개인 테스트 페이지
	@RequestMapping(value = "/adminStudy.do")
	public String adminStudy(Model model, HttpServletRequest request) {
		logger.info("페이지 이동");
		return "home/admin/adminStudy";
	}

	// 관리자 개인 테스트. 데이터 파싱 연습
	@ResponseBody
	@RequestMapping(value = "/updateTest.do", method = RequestMethod.POST)
	public String updateTest(@RequestBody List<HashMap<String, Object>> list) {

		logger.info("넘어온 list의 값: " + list);
		for (HashMap<String, Object> map : list) {
			int question_no = (int) map.get("question_no");
			int whereQno = question_no + 1;
			int quizcard_set_no = (int) map.get("quizcard_set_no");
			String quiezcard_no = (String) map.get("quizcard_no");
			logger.info(question_no + " : " + whereQno+ " : " + quizcard_set_no + " : " + quiezcard_no);
		}

		return "";
	}

}
