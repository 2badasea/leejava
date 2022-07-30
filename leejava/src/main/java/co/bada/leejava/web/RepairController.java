package co.bada.leejava.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import co.bada.leejava.repair.RepairVO;

// 여기 페이지에서는 주로 화면과 데이터가 같이 이동할 때 주로 사용한다. form값을 넘기거나. 
@Controller
public class RepairController {
	
	private static final Logger logger = LoggerFactory.getLogger(RepairController.class);
	
	@RequestMapping(value = "adminRepair.do" , method = { RequestMethod.POST , RequestMethod.GET} )
	public String adminRepair( Model model, RepairVO rvo) {
		
		// 데이터가 있으면 날려서 보내야 된다. 다만 페이징 처리를 해야 함.
		
		return "home/admin/repairlist";
	}
	
	// 유지보수 관리 게시판으로 이동하기 ( 관리자 화면의 사이드바 메뉴를 통해서 이동된다.) 
	
}
