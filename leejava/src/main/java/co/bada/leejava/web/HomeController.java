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
		String password = request.getParameter("password");
		System.out.println("확인 Email: " + email + " Password: " + password);
		
		mvo.setM_email(email);
		mvo.setM_password(password);
		
		mvo = memberDao.memberSelect(mvo);
		String responseText = null;
		if(mvo != null) {
			session.setAttribute( "session_user", email);
			System.out.println( "세션에 담은 값: " + email);
			responseText = "YES";
		} else {
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
	
	
}
