package co.bada.leejava.web;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import co.bada.leejava.CoolSMS;
import co.bada.leejava.SHA256Util;
import co.bada.leejava.member.MemberService;
import co.bada.leejava.member.MemberVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	MemberService memberDao;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
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
			String nickname = mvo.getM_nickname(); // nickname을 가져옴. 사이트에서 사용할 수 있는
			if(mvo != null) {
				session.setAttribute("session_user", email);
				session.setAttribute("session_nickname", nickname);
				System.out.println("세션에 담은 값: " + email + ", " + nickname);
				responseText = "YES";
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
		
		return "redirect:home.do";
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
			responseText = "YES";	
		} else {
			responseText = "NO";
		}
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
	public String memberJoin(HttpServletRequest request, MemberVO mvo, Model model) {
		
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
		
		model.addAttribute("message", message); // 스크립트로 message내용을 alert로 보여줘보기
		return "home/loginPage";
	}
	
	// 관리자 페이지로 이동 
	@RequestMapping("/adminPage.do")
	public String adminPage(Model model, HttpServletRequest request) {
		
		return "home/admin/adminHome";
	}
	
	
}
