package co.bada.leejava;

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
	
	
//	@RequestMapping("/memberSelectList.do")
//	public String memberSelectList(MemberVO mvo, Model model) {
//		
//		System.out.println("확인: " + memberDao.memberSelectList());
//		
//		model.addAttribute("members", memberDao.memberSelectList());
//		
//		return "home/home";
//	}
}
