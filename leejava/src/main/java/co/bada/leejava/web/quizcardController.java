package co.bada.leejava.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import co.bada.leejava.quizcard.QuizcardService;
import co.bada.leejava.quizcard.QuizcardVO;

@Controller
public class quizcardController {
	@Autowired
	QuizcardService quizcardDao;
	
	
	private static final Logger logger = LoggerFactory.getLogger(quizcardController.class);
	
	// 퀴즐렛 학습 페이지 이동
	@RequestMapping("/quizcard.do")
	public String quizcard(HttpServletRequest request, Model model) {
		
		logger.info("================ 일단 컨트롤러는 찾아 오니?====");
		return "home/quizcard/quizcardHome";
	}
	
	// 퀴즈카드 생성 후 퀴즈카드 문제 생성 폼으로 이동
	@RequestMapping("/createQuizcardSet.do")
	public String createQuizcardSet(Model model, HttpServletRequest request, QuizcardVO qvo) {
		// view단에서 넘어온 값들 확인
		logger.info("세션 유저" + request.getParameter("m_email"));
		logger.info("세트 이름" + request.getParameter("quizcard_set_name"));
		logger.info("세트 카테고리 값: " + request.getParameter("quizcard_category_first"));
		logger.info("세트 공개여부 값: " + request.getParameter("category_status"));
		
		String m_eamil = request.getParameter("m_email");
		String quizcard_set_name = request.getParameter("quizcard_set_name");
//		String quizcard_category
		return "home/quizcard/quizcardQuestionForm";
	}
	
	
	
	
}
	