package co.bada.leejava.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.SystemEnvironmentPropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import co.bada.leejava.Search;
import co.bada.leejava.repair.RepairService;
import co.bada.leejava.repair.RepairVO;

// 여기 페이지에서는 주로 화면과 데이터가 같이 이동할 때 주로 사용한다. form값을 넘기거나. 
@Controller
public class RepairController {
	@Autowired
	RepairService repairDao;
	
	// rest api 방식으로 구성해야 함.
	private static final Logger logger = LoggerFactory.getLogger(RepairController.class);
	
	@RequestMapping(value = "adminRepair.do" , method = { RequestMethod.POST , RequestMethod.GET} )
	public String adminRepair( Model model, RepairVO rvo
			, @RequestParam(required = false, defaultValue = "1") int page
			, @RequestParam(required = false, defaultValue = "1") int range
			, @RequestParam(required = false, defaultValue = "ALL") String rcategory
			, @RequestParam(required = false) String rtitle
			, @RequestParam(required = false) String rcontent
			, @RequestParam(required = false) String m_email
			, @RequestParam(required = false, defaultValue = "ALL") String rgrade // 얘들 값을 정해야 한다. 디폴트 값은 있을지? 
			, @RequestParam(required = false, defaultValue = "ALL") String rstatus // 진행상황 => 클릭하면 반영한 값대로 출력된다. 
			, @RequestParam(required = false, defaultValue = "DESC") String rtimeorder // 필드에서 클릭하면 ASC값으로 넘어온다. 
			, Search svo) {
		
		// 이제 페이징 처리를 해야 한다 => 쿼리문 짜서 우선 데이터가 총 몇개인지 listCnt를 출력한다. 
		svo.setRcategory(rcategory);
		svo.setRtitle(rtitle);
		svo.setRcontent(rcontent);
		svo.setM_email(m_email);
		svo.setRgrade(rgrade);
		svo.setRstatus(rstatus);
		int listCnt = repairDao.getRepairListCnt(svo);
		logger.info("게시글 총 개숫 조회 확인: " + listCnt);
		
		
//		model.addAttribute("search", svo);
//		svo.setRCategory(rCategory);
//		svo.setRTitle(rTitle);
//		svo.setRContent(rContent);
//		svo.setM_email(m_email);
//		svo.setRGrade(rGrade);
//		svo.setRStatus(rStatus);
//		int listCnt = repairDao.getRepairListCnt(svo);
//		svo.pageinfo(page, range, listCnt);
		
//		model.addAttribute("pagination", svo);
		return "home/admin/repairlist"; 
	}
	// 유지보수 관리 게시판으로 이동하기 ( 관리자 화면의 사이드바 메뉴를 통해서 이동된다.) 
	// 일단 jeninks
}
