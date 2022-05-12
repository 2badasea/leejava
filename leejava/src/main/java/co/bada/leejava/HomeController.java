package co.bada.leejava;

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
	
	
}
