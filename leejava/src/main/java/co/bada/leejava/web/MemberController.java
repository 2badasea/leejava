package co.bada.leejava.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	
	
}
