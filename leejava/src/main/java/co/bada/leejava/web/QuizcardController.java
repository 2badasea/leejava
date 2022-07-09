package co.bada.leejava.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.bada.leejava.quizcard.QuizcardService;
import co.bada.leejava.quizcard.QuizcardVO;

@Controller
public class QuizcardController {
	@Autowired
	QuizcardService quizcardDao;
	
	private static final Logger logger = LoggerFactory.getLogger(QuizcardController.class);
	
	// 퀴즐렛 학습 페이지 이동
	@RequestMapping("/quizcard.do")
	public String quizcard(HttpServletRequest request, Model model) {
		
		// 여기로 올 때 현재 생성되어 있는 퀴즐렛 quizcard들이 목록으로 출력되도록 한다.
		model.addAttribute("quizcardList", quizcardDao.quizcardList());
		List<QuizcardVO> list = new ArrayList<>();
		list = quizcardDao.quizcardList();
		logger.info("메인페이지에 넘어갈 퀴즈카드 리스트: " + list);
		return "home/quizcard/quizcardHome";
	}
	
	// 퀴즈카드 생성 후 퀴즈카드 문제 생성 폼으로 이동
	@RequestMapping("/createQuizcardSet.do")
	public  String createQuizcardSet(Model model, HttpServletRequest request, QuizcardVO qvo) {
		// view단에서 넘어온 값들 확인
		logger.info("세션 닉네임" + request.getParameter("m_email"));
		logger.info("세트 이름" + request.getParameter("quizcard_set_name"));
		logger.info("세트 카테고리 값: " + request.getParameter("quizcard_category_first"));
		logger.info("세트 공개여부 값: " + request.getParameter("quizcard_set_status"));
		logger.info("intro 값: " + request.getParameter("quizcard_set_intro"));
		logger.info("문제 유형 값: " + request.getParameter("quizcard_type"));
		
		String m_email = request.getParameter("m_email");
		String quizcard_set_name = request.getParameter("quizcard_set_name");
		String quizcard_category = request.getParameter("quizcard_category_first");
		String quizcard_set_status = request.getParameter("quizcard_set_status");
		String quizcard_set_intro = request.getParameter("quizcard_set_intro");
		String quizcard_type = request.getParameter("quizcard_type");
		
		qvo.setM_email(m_email);
		qvo.setQuizcard_set_name(quizcard_set_name);
		qvo.setQuizcard_set_intro(quizcard_set_intro);
		qvo.setQuizcard_set_status(quizcard_set_status);
		qvo.setQuizcard_type(quizcard_type);
		
		int n = quizcardDao.quizcardSetCreate(qvo);
		if( n ==1) {
			logger.info("quizcard 테이블 데이터 정상 삽입" );
			// -1을 해주어야 한다 => 현재 조회한 시퀀스는 현재 테이블에 존재하지 않고, 다음에 부여될 예정인 값이다.
			int quizcard_set_no = quizcardDao.quizcardSetNoGet() - 1; 	
			logger.info("================= setNo는 정상적으로 조회됐는지??? "  + quizcard_set_no);
			qvo.setQuizcard_set_no(quizcard_set_no);
			logger.info("==========카테고리 이름 조회: " + quizcard_category);
			qvo.setQuizcard_category(quizcard_category);
			// quizcard_category 테이블도 생성한다.  
			int m = quizcardDao.quizcardCategory(qvo);
			if(m ==1) {
				logger.info("========= 카테고리 테이블도 생성 완료");
			}else {
				logger.info("============= 카테고리 생성 오류");
			}
			// quizcard_question 테이블도 삽ㅇ입해보자
			qvo.setQuizcard_set_no(quizcard_set_no);
			int o = quizcardDao.firstQuestionInsert(qvo);
			if( o ==1) {
				logger.info("=============== Question table도 Insert 성공");
			} else {
				logger.info("=============== Question table FAIL~~~~~~~~~~ ");
			}
		} else {
			logger.info("=============== quizcard 세트 생성 오류");
		}
		
		// 카테고리 까지 생성 후 기본값으로 question 테이블의 데이터를 추가하자
		
		// 위의 결과값을 토대로 => 조인문의 결과 데이터를 redirect로 던진다? 
		return "home/quizcard/quizcardTemp";
	}
	
	// 퀴즈카드 문제 생성 폼 이동
	@RequestMapping(value = "/quizcardQuestionForm.do")
	public String quizcardQuestionForm(Model model, HttpServletRequest request, QuizcardVO qvo) {
		
		// 막 생성된 
		int quizcard_set_no = quizcardDao.quizcardSetNoGet() -1;
		logger.info("======== 조회할 퀴즈카드 세트 번호: " + quizcard_set_no);
		qvo.setQuizcard_set_no(quizcard_set_no);
		qvo = quizcardDao.quizcardSelect(qvo);
		logger.info("========== qvo객체 : " + qvo);
		if( qvo != null) {
			logger.info("=================== 조인문 데이터 조회 성공");
			model.addAttribute("qvo",qvo);
		} else {
			logger.info("======= 조인문 실패: redircet로  quizletHome으로 이동");
			return "redirect:quizcard.do";
		}
		return "home/quizcard/quizcardQuestionForm";
	}
	
	// 내가 만든 세트 조회하기
	@ResponseBody
	@GetMapping(value= "/ajaxMyQuizcard.do", produces = MediaType.APPLICATION_JSON_VALUE )
	public List<QuizcardVO> ajaxMyQuizcard(HttpServletRequest request, QuizcardVO qvo,
				@RequestParam(value = "m_email") String m_email) {
		logger.info("================ ajax로 넘어온 m_email값: " + m_email);
		List<QuizcardVO> list = new ArrayList<QuizcardVO>();
		
		qvo.setM_email(m_email);
		qvo = quizcardDao.ajaxMyQuizcard(qvo);
		logger.info("=============== qvo 결과 조회: " + qvo);
		if( qvo !=null) {
			list.add(qvo);
			return list;
		} else {
			return null;
		}
	}
	
	// archiveBox, 메인페이지 리스트 클릭 => quizcardInfo 페이지 이동. 
	@RequestMapping(value = "/quizcardBefore.do" )
	public String quizcardInfo(HttpServletRequest request, QuizcardVO qvo, Model model,
			 @RequestParam("set_no") int quizcard_set_no,
			 @RequestParam("m_email") String m_email) {
		logger.info("=========== view단에서 넘어온 m_email : " + m_email);
		logger.info("=========== ajax로 넘어온 데이터 세트번호: " + quizcard_set_no);
		// 총 3개의 쿼리문 결과 보내기(조인문, 댓글갯수, 문제갯수)
		
		qvo.setQuizcard_set_no(quizcard_set_no);
		// 조회수 1 업데이트 ( 메인 페이지 리스트에서만 클릭 시 조회수가 올라가도록) 
		String referer = request.getHeader("Referer");
		logger.info("무슨 경로로 왔는지 체크" + referer);
		String urjPath = "http://localhost:8000/leejava/quizcard.do";
		if(referer.equals(urjPath)) {
			logger.info("=====================================조회수 업뎃 성공");
			quizcardDao.quizcardHitUpdate(qvo);
		}
		// Quizcard_set_no별 문제갯수, 댓글갯수를 먼저 보내고,
		int quizcardQuestionCount = quizcardDao.quizcardQuestionCount(qvo);
		logger.info("============ 퀴즈카드 문제 갯수: " + quizcardQuestionCount );
		int quizcardReplyCount = quizcardDao.quizcardReplyCount(qvo);
		logger.info("=============퀴즈카드 댓글 갯수: " + quizcardReplyCount);
		
		model.addAttribute("quizcardQuestionCount", quizcardQuestionCount);
		model.addAttribute("quizcardReplyCount", quizcardReplyCount);
		
		// 마지막으로 나머지 정보를 모두 보낸다.
		qvo = quizcardDao.quizcardBeforeInfo(qvo);
		logger.info("======= qvoInfo 값 조회: " + qvo);
		model.addAttribute("qvo", qvo); 
		
		return "home/quizcard/quizcardBefore";
	}
	
	// Quizcard, 문제 수정 페이지 이동
	@RequestMapping(value = "updateQuizcard.do") 
	public String updateQuizcard(Model model, HttpServletRequest request, QuizcardVO qvo,
				@RequestParam("set_no") int quizcard_set_no,
				@RequestParam("questionCount") int quizcardQuestionCount ) {
		logger.info("=========== 쿼리스트링 quicard_set_no의 값: " + quizcard_set_no);
		logger.info("=========== 쿼리스트링 quizcardQuestionCount의 값: " + quizcardQuestionCount);
		// 넘어온 quizcard_set_no를 통해 DB에 있는 자료들을 model로 날린다. 문제 갯수, 퀴즈카드 정보, quizcard_question객체리스트.
		List<QuizcardVO> questionList = new ArrayList<QuizcardVO>();
		
		qvo.setQuizcard_set_no(quizcard_set_no);

//		quizcardQuestionList 쿼리문의 리턴타입이 달라야 한다. 리턴타입이 파라미터가 있는 list타입이어야 한다. 
		questionList = quizcardDao.quizcardQuestionList(qvo);
		logger.info("============== questionList에 담긴 qvo객체들의 값: " + questionList);
		
		// 이번에는 info정보에 해당하는 값을 넣는다. 기존에 등록해둔 quizcardSelect Dao를 통해서 값을 넘긴다.
		qvo = quizcardDao.quizcardSelect(qvo);
		logger.info("=============== qvo의 값: " + qvo);
		
		// 퀴즈카드 메인 정보
		model.addAttribute("qvo", qvo);
		// 퀴즈카드 문제박스
		model.addAttribute("questionList",questionList);
		// 문제갯수만큼 반복문으로 DB에 저장된 quesiton들을 출력시킨다.
		model.addAttribute("questionCount", quizcardQuestionCount);
		
		return "home/quizcard/quizcardQuestionForm";
	}
	
	// 퀴즈카드 학습 시작 페이지 이동
	@RequestMapping("/studyStart.do")
	public String studyStart(Model model, QuizcardVO qvo, 
			@RequestParam(value = "setNo") int setNo,
			@RequestParam(value = "studyType") String studyType) {
		logger.info("============ 세트번호: " + setNo);
		logger.info("============ 문제풀이 방식: " + studyType);
		
		// 해당 세트번호의 총 문제 갯수도 넘겨야 한다. => 문제리스트 배열의 크기를 생성하기 위함.
		qvo.setQuizcard_set_no(setNo);
		;
		model.addAttribute("questionCount", quizcardDao.quizcardQuestionCount(qvo));
		model.addAttribute("setNo", setNo);
		model.addAttribute("studyType", studyType);
		return "home/quizcard/studyStart";
	}
	
	
}
	