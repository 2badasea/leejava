package co.bada.leejava.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import co.bada.leejava.repair.RepairService;

@RestController
public class RepariController {
	@Autowired
	RepairService repairDao;
	
	
	private static final Logger logger = LoggerFactory.getLogger(RepariController.class);
	
	@GetMapping(value = "/adminRepair.do")
	public ModelAndView adminRepair(ModelAndView mv, HttpServletRequest request) {
		
		logger.info("일단 신호 확인");
		mv.setViewName("home/admin/repairlist");
		return mv;
	}
	
	
}
