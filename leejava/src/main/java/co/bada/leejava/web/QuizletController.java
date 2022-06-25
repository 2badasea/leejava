package co.bada.leejava.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class QuizletController {
	
	private static final Logger logger = LoggerFactory.getLogger(QuizletController.class);
	
	// 퀴즐렛 학습 페이지 이동
	@RequestMapping("/quizlet.do")
	public String quizlet(HttpServletRequest request, Model model) {
		
		logger.info("================ 일단 컨트롤러는 찾아 오니?====");
		return "home/quizlet/quizletHome";
	}	
}
