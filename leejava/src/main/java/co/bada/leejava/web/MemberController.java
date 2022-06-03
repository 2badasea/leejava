package co.bada.leejava.web;

import javax.servlet.http.HttpServletRequest;

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
	
	
}
