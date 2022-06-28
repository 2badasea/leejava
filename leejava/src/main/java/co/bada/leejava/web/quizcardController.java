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
	public  String createQuizcardSet(Model model, HttpServletRequest request, QuizcardVO qvo) {
		// view단에서 넘어온 값들 확인
		logger.info("세션 유저" + request.getParameter("m_email"));
		logger.info("세트 이름" + request.getParameter("quizcard_set_name"));
		logger.info("세트 카테고리 값: " + request.getParameter("quizcard_category_first"));
		logger.info("세트 공개여부 값: " + request.getParameter("quizcard_set_status"));
		logger.info("intro 값: " + request.getParameter("quizcard_set_intro"));
		
		String m_email = request.getParameter("m_email");
		String quizcard_set_name = request.getParameter("quizcard_set_name");
		String quizcard_category_name = request.getParameter("quizcard_category_first");
		String quizcard_set_status = request.getParameter("quizcard_set_status");
		String quizcard_set_intro = request.getParameter("quizcard_set_intro");
		
		qvo.setM_email(m_email);
		qvo.setQuizcard_set_name(quizcard_set_name);
		qvo.setQuizcard_set_intro(quizcard_set_intro);
		qvo.setQuizcard_set_status(quizcard_set_status);
		int n = quizcardDao.quizcardSetCreate(qvo);
		if( n ==1) {
			logger.info("quizcard 테이블 데이터 정상 삽입" );
			// -1을 해주어야 한다 => 현재 조회한 시퀀스는 현재 테이블에 존재하지 않고, 다음에 부여될 예정인 값이다.
			int quizcard_set_no = quizcardDao.quizcardSetNoGet() - 1; 	
			logger.info("================= setNo는 정상적으로 조회됐는지??? "  + quizcard_set_no);
			qvo.setQuizcard_set_no(quizcard_set_no);
			logger.info("==========카테고리 이름 조회: " + quizcard_category_name);
			qvo.setQuizcard_category_name(quizcard_category_name);
			int m = quizcardDao.quizcardCategory(qvo);
			if(m ==1) {
				logger.info("========= 카테고리 테이블도 생성 완료");
			}else {
				logger.info("============= 카테고리 생성 오류");
			}
		} else {
			logger.info("=============== quizcard 세트 생성 오류");
		}
		// 카테고리 테이블의 데이터를 위해서 set_no를 조회하여, 그걸로 다시 카테고리 테이블에 데이터 생성.
		
		
		
		return "home/quizcard/quizcardQuestionForm";
	}
	
	
	
	
}
	