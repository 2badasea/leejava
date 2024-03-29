package co.bada.leejava.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import co.bada.leejava.Search;
import co.bada.leejava.quizcard.QuizcardService;
import co.bada.leejava.quizcard.QuizcardVO;

@Controller
public class QuizcardController {
	@Autowired
	QuizcardService quizcardDao;
	
	private static final Logger logger = LoggerFactory.getLogger(QuizcardController.class);
	
	// 퀴즐렛 학습 페이지 이동
	@RequestMapping("/quizcard.do")
	public String quizcard(Model model
			,@RequestParam(required = false, defaultValue = "1") int page
			,@RequestParam(required = false, defaultValue = "1") int range
			,@RequestParam(required = false, defaultValue = "ALL") String quizcard_category
			,@RequestParam(required = false) String quizcard_set_name
			,@RequestParam(required = false) String m_nickname
			,Search svo) throws Exception {
		// 지금 전달하는 svo는 아무런 값이 들어있지 않은 svo객체의 필드값들이다.
			// 페이징박스(prev, 페이지넘버, next 버튼의 이벤트 파라미터로 사용된다. 검색항목이3개니, 총 9개 "serrch"값 정의)
		model.addAttribute("search", svo);
		// 검색항목 3개를 svo객체에 담아서 페이징 처리된 파라미터 전달할 준비
		svo.setQuizcard_category(quizcard_category);
		svo.setQuizcard_set_name(quizcard_set_name);
		svo.setM_nickname(m_nickname);
		// 페이징 처리를 위한 게시글의 총 갯수를 구한다. ( pageInfo(page, range, listCnt). 그리고 mapper쿼리문 정의)
		int listCnt = quizcardDao.getQuizcardListCnt(svo);
		
		// 페이징 처리를 위한 필드값들을 생성한다.
		svo.pageinfo(page, range, listCnt);
		
		List<QuizcardVO> list = quizcardDao.quizcardSearchSelect(svo);
		System.out.println("list값: " + list);
		
		// 페이지에 대한 정보를 보여주는 요소들.  Paging클래스에 있는 요소들이다.
		model.addAttribute("pagination", svo); 
		// 페이징 처리 결과로 화면에 출력될 게시글 리스트
		model.addAttribute("quizcardList", list); 
		
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
	public String quizcardQuestionForm(Model model, HttpServletRequest request, QuizcardVO qvo,
				RedirectAttributes re, HttpSession session) {
		// 생성자 이메일
		String m_email = (String) session.getAttribute("session_user");
		// 막 생성된 
		int quizcard_set_no = quizcardDao.quizcardSetNoGet() -1;
		logger.info("======== 조회할 퀴즈카드 세트 번호: " + quizcard_set_no);
		re.addAttribute("m_email", m_email);
		re.addAttribute("set_no", quizcard_set_no);
		return "redirect:quizcardBefore.do";
	}
	
	// archiveBox, 메인페이지 리스트 클릭 => quizcardInfo 페이지 이동. 
	@RequestMapping(value = "/quizcardBefore.do" )
	public String quizcardInfo(HttpServletRequest request, QuizcardVO qvo, Model model,
			 @RequestParam("set_no") int quizcard_set_no) {
		// 총 3개의 쿼리문 결과 보내기(조인문, 댓글갯수, 문제갯수)
		
		qvo.setQuizcard_set_no(quizcard_set_no);
		// 조회수 1 업데이트 ( 메인 페이지 리스트에서만 클릭 시 조회수가 올라가도록) 
		String referer = request.getHeader("Referer");
		logger.info("무슨 경로로 왔는지 체크" + referer);
		// 이 경로를 수정해야 한다. 마지막 요청 url만 확인하기
		
		// 전달받는 referer의 값. http://localhost:8000/leejava/quizcard.do";
		if(referer.endsWith("quizcard.do")) {
			// 조회수 업데이트
			quizcardDao.quizcardHitUpdate(qvo);
		}
		// Quizcard_set_no별 문제갯수
		int quizcardQuestionCount = quizcardDao.quizcardQuestionCount(qvo);
		logger.info("============ 퀴즈카드 문제 갯수: " + quizcardQuestionCount );
		model.addAttribute("quizcardQuestionCount", quizcardQuestionCount);
		
		// 마지막으로 나머지 정보를 모두 보낸다.
		qvo = quizcardDao.quizcardBeforeInfo(qvo);
		logger.info("======= qvoInfo 값 조회: " + qvo);
		model.addAttribute("qvo", qvo); 
		
		return "home/quizcard/quizcardBefore";
	}
	
	// Quizcard, 문제 수정 페이지 이동
	@RequestMapping(value = "updateQuizcard.do") 
	public String updateQuizcard(Model model, HttpServletRequest request
									, QuizcardVO qvo
									, @RequestParam("set_no") int quizcard_set_no
									, @RequestParam("questionCount") int quizcardQuestionCount ) {
		
		// 넘어온 quizcard_set_no를 통해 DB에 있는 자료들을 model로 날린다. 문제 갯수, 퀴즈카드 정보, quizcard_question객체리스트.
		List<QuizcardVO> questionList = new ArrayList<QuizcardVO>();
		
		qvo.setQuizcard_set_no(quizcard_set_no);

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
		
		return "home/quizcard/updateQuizcard";
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
	