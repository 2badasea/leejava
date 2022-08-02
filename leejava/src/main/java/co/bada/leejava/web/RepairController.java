package co.bada.leejava.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import co.bada.leejava.Search;
import co.bada.leejava.repair.RepairVO;

// 여기 페이지에서는 주로 화면과 데이터가 같이 이동할 때 주로 사용한다. form값을 넘기거나. 
@Controller
public class RepairController {
	// rest api 방식으로 구성해야 함.
	private static final Logger logger = LoggerFactory.getLogger(RepairController.class);
	
	@RequestMapping(value = "adminRepair.do" , method = { RequestMethod.POST , RequestMethod.GET} )
	public String adminRepair( Model model, RepairVO rvo
			, @RequestParam(required = false, defaultValue = "1") int page
			, @RequestParam(required = false, defaultValue = "1") int range
			, @RequestParam(required = false, defaultValue = "ALL") String rCategory
			, @RequestParam(required = false) String rTitle
			, @RequestParam(required = false) String rContent
			, @RequestParam(required = false) String m_email
			, @RequestParam(required = false, defaultValue = "ALL") String rGrade // 얘들 값을 정해야 한다. 디폴트 값은 있을지? 
			, @RequestParam(required = false, defaultValue = "ALL") String rStatus // 진행상황 => 클릭하면 반영한 값대로 출력된다. 
			, Search svo) {
		
		

		
		
		return "home/admin/repairlist"; 
	}
	// 유지보수 관리 게시판으로 이동하기 ( 관리자 화면의 사이드바 메뉴를 통해서 이동된다.) 
	// 일단 jeninks
}
