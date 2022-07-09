package co.bada.leejava.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import co.bada.leejava.quizcard.QuizcardService;
import co.bada.leejava.quizcard.QuizcardVO;

// Quizcard와 관련된 RESTApi 관련 메서드들은 모두 여기로 정의.
@RestController
public class QuizcardRestController {
	@Autowired
	QuizcardService quizcardDao;
	
	private static final Logger logger = LoggerFactory.getLogger(QuizcardController.class);
	
	
	// 퀴즈카드 문제별로 blur이벤트 발생시 내용 업데이트
	@PostMapping("/ajaxQuestionUpdate.do")
	public String ajaxQuestionUpdate(QuizcardVO qvo, HttpServletRequest request, 
			@RequestParam(value = "quizcard_set_no") int quizcard_set_no,
			@RequestParam(value = "quizcard_question_no") int quizcard_question_no,
			@RequestParam(value = "quizcard_question_name", required = false) String quizcard_question_name,
			@RequestParam(value = "quizcard_question_hint", required = false) String quizcard_question_hint,
			@RequestParam(value = "quizcard_question_answer", required = false) String quizcard_question_answer){
		
		logger.info("============ 세트번호 : " + quizcard_set_no);
		logger.info("============ 문제번호 : " + quizcard_question_no);
		logger.info("============ 문제명 : " + quizcard_question_name);
		logger.info("============ 힌드 : " + quizcard_question_hint);
		logger.info("============ 답: " + quizcard_question_answer);
		
		qvo.setQuizcard_set_no(quizcard_set_no);
		qvo.setQuizcard_question_no(quizcard_question_no);
		qvo.setQuizcard_question_name(quizcard_question_name);
		qvo.setQuizcard_question_hint(quizcard_question_hint);
		qvo.setQuizcard_question_answer(quizcard_question_answer);
		
		// 우선 위에처럼 일일이 명시해보고, 다음엔 매개변수로 QuizcardVO quizcardVO로 바로 해보자.그다음은 그냥 qvo로.
		String result = null;
		int n = quizcardDao.ajaxQuestionUpdate(qvo);
		if(n == 1) {
			result = "success";
			// 업데이트가 성공하면 마지막 수정일도 변경되도록
			qvo.setQuizcard_set_no(quizcard_set_no);
			quizcardDao.quizcardUdateChange(qvo);
		} else {
			result = "fail";
		}
		return result;
	}
	
	// 퀴즈카드 신규생성된 카드 DB insert (기본값들)
		// 여기서 문제넘버링도 조작해야 해서 삽입해야 한다.
	@PostMapping(value = "/ajaxQuestionNew.do")
	public ResponseEntity<String> ajaxQuestionNew(QuizcardVO qvo, HttpServletRequest request,
			@RequestParam(value = "quizcard_question_no") int quizcard_question_no,
			@RequestParam(value = "quizcard_set_no") int quizcard_set_no,
			@RequestParam(value = "quizcard_no") String quizcard_no) {
		
		logger.info("================= 문제번혹값: " + quizcard_question_no);
		logger.info("================= 세트번호값: " + quizcard_set_no);
		logger.info("================= 문제넘버링값: " + quizcard_no);
		
		// 값들을 생성해야 한다. quizcard_no 생성해야 함. 
			// 세트번호 + 문제번호. but, 문제번호가 10미만이면 앞에 문자 '0;을 붙여야 한다. 최종타입은 string임. 
		
		qvo.setQuizcard_no(quizcard_no);
		qvo.setQuizcard_question_no(quizcard_question_no);
		qvo.setQuizcard_set_no(quizcard_set_no);
		qvo.setQuizcard_question_name("문제를 입력해주세요");
		qvo.setQuizcard_question_hint("힌트를 입력해주세요");
		qvo.setQuizcard_question_answer("답을 입력해주세요");
		
		String message = null;
		int n = quizcardDao.ajaxQuestionNew(qvo);
		if( n ==1 ) {
			message = "Insert Success~";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		} else {
			message = "Insert Fail";
			return new ResponseEntity<String>(message, HttpStatus.NOT_IMPLEMENTED);
		}
		
	}
	
	// 퀴즈카드 삭제 이벤트 
	@PostMapping(value= "ajaxQuestionDel.do")
	public ResponseEntity<String> ajaxQuestionDel(QuizcardVO qvo, 
			@RequestParam("quizcard_question_no") int quizcard_question_no,
			@RequestParam("quizcard_set_no") int quizcard_set_no){
		
		logger.info("========== 삭제할 문제번호: " + quizcard_question_no);
		logger.info("========== 삭제대상 세트번호: " + quizcard_set_no);
		
		qvo.setQuizcard_question_no(quizcard_question_no);
		qvo.setQuizcard_set_no(quizcard_set_no);
		
		int n = quizcardDao.ajaxQuestionDel(qvo);
		String message = null;
		if(n ==1) {
			message = "Delete Success~";
			return new ResponseEntity<String>(message, HttpStatus.OK);
		} else {
			message  = "Delete Fail";
			return new ResponseEntity<String> (message, HttpStatus.NOT_IMPLEMENTED);
		}
		
	}
	
	// 퀴즈카드 인덱스 정렬 업데이트
	@PutMapping(value = "ajaxUpdateQuestionNo.do")
		public void ajaxUpdateQuestionNo( @RequestBody List<Map<String, Object>> list, QuizcardVO qvo) {
				
		logger.info("넘어온 list값: " + list);
		for(Map<String, Object> map : list) {
			int question_no = (int) map.get("setQno");
			int quizcard_set_no = (int) map.get("setNo");
			String quizcard_no = (String) map.get("setQuizcardNo");
			logger.info("문제번호: " + question_no +", 세트번호: " + quizcard_set_no + ", 넘버링: " + quizcard_no);
			
			qvo.setQuizcard_question_no(question_no);
			qvo.setQuizcard_set_no(quizcard_set_no);
			qvo.setQuizcard_no(quizcard_no);
			int n = quizcardDao.ajaxUpdateQuestionNo(qvo);
			if( n != 1) {
				logger.info("오류남");
			}
		}
		logger.info("완료");
	}
	
	// 퀴즈카드 문제 호출 
	@GetMapping(value = "ajaxStudyStart.do" , produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<QuizcardVO> ajaxStudyStart( QuizcardVO qvo,
				@RequestParam int quizcard_set_no, 
				@RequestParam int quizcard_question_no){
		
		logger.info("ajax로 넘어온 set번호: " + quizcard_set_no);
		logger.info("ajax로 넘어온 문제번호: " + quizcard_question_no);
		
		qvo.setQuizcard_set_no(quizcard_set_no);
		qvo.setQuizcard_question_no(quizcard_question_no);
		qvo = quizcardDao.ajaxStudyStart(qvo);
		logger.info("qvo값 조회========================================: " + qvo);
		if( qvo != null) {
			return new ResponseEntity<QuizcardVO>(qvo, HttpStatus.OK);
		} else {
			return new ResponseEntity<QuizcardVO>(qvo, HttpStatus.NOT_FOUND);
		}
	}
	
	
	
}
