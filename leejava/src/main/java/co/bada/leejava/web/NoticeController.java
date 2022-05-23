package co.bada.leejava.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import co.bada.leejava.notice.NoticeService;

@Controller
public class NoticeController {
	@Autowired
	NoticeService noticeDao;
	
	// 관리자 공지사항 페이지로 이동
	@RequestMapping("/adminNoticeList.do")
	public String adminNoticeList(Model model, HttpServletRequest request,HttpSession session) { 
		
		// 페이지 이동했을 때 공지사항 리스트가 출력되어야 함. 
		model.addAttribute("notices", noticeDao.noticeSelectList());
		return "home/admin/adminNoticeList";
	}
	
	// 공지사항 작성폼 이동
	@RequestMapping("/noticeRegisterForm.do")
	public String noticeRegisterForm(Model model) { 
		
		return "home/admin/noticeForm";
	}
	
	
	
}
