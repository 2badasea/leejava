package co.bada.leejava.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.protocol.HTTP;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import co.bada.leejava.Search;
import co.bada.leejava.member.MemberService;
import co.bada.leejava.member.MemberVO;
import co.bada.leejava.quizcard.QuizcardService;
import co.bada.leejava.quizcard.QuizcardVO;

// Quizcard와 관련된 RESTApi 관련 메서드들은 모두 여기로 정의.
@RestController
public class QuizcardRestController {
	@Autowired
	QuizcardService quizcardDao;
	@Autowired
	MemberService memberDao;
	
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
	
	// 내가 만든 세트 조회하기
	@GetMapping(value= "/ajaxMyQuizcard.do", produces = MediaType.APPLICATION_JSON_VALUE )
	public List<QuizcardVO> ajaxMyQuizcard( QuizcardVO qvo,
				@RequestParam(value = "m_email") String m_email) {
		logger.info("================ ajax로 넘어온 m_email값: " + m_email);
		List<QuizcardVO> list = new ArrayList<QuizcardVO>();
		
		qvo.setM_email(m_email);
		list = quizcardDao.ajaxMyQuizcard(qvo);
		logger.info("=============== qvo 결과 조회: " + qvo);
		if( list !=null) {
			return list;
		} else {
			return null;
		}
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
	
	
	// 퀴즈카드 단어추가/수정 페이지, info 수정
	@PostMapping(value = "ajaxQuizInfoUpdate.do")
	public ResponseEntity<String> ajaxQuizInfoUpdate(QuizcardVO qvo, 
				@RequestParam(value = "quizcard_set_no" ) int quizcard_set_no,
				@RequestParam(value = "quizcard_set_name", required = false) String quizcard_set_name,
				@RequestParam(value = "quizcard_set_intro", required = false) String quizcard_set_intro,
				@RequestParam(value = "quizcard_type", required = false) String quizcard_type,
				@RequestParam(value = "quizcard_set_status", required = false) String quizcard_set_status){
		
		logger.info("===========세트번호: " + quizcard_set_no);
		logger.info("===========세트이름: " + quizcard_set_name);
		logger.info("============세트설명: " + quizcard_set_intro);
		logger.info("============세트 status: " + quizcard_set_status);
		
		qvo.setQuizcard_set_no(quizcard_set_no);
		qvo.setQuizcard_set_name(quizcard_set_name);
		qvo.setQuizcard_set_intro(quizcard_set_intro);
		qvo.setQuizcard_set_status(quizcard_set_status);
		
		int n = quizcardDao.ajaxQuizInfoUpdate(qvo);
		if(n ==1) {
			logger.info("수정 성공");
			return new ResponseEntity<String>("Success!", HttpStatus.OK);
		} else {
			logger.info("수정 실패");
			return new ResponseEntity<String>("Fail~", HttpStatus.NOT_MODIFIED);
		}
	}
	
	// 퀴즈카드 틀린 문제 호출(by quizcard_no ) 
	@GetMapping(value = "ajaxWrongQuestion.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<QuizcardVO> ajaxWrongQuestion(QuizcardVO qvo, 
				@RequestParam int quizcard_set_no,
				@RequestParam String quizcard_no ){
		
		qvo.setQuizcard_set_no(quizcard_set_no);
		qvo.setQuizcard_no(quizcard_no);
		
		qvo = quizcardDao.ajaxWrongQuestion(qvo);
		if(qvo != null) {
			return new ResponseEntity<QuizcardVO>(qvo, HttpStatus.OK);
		} else {
			qvo = null;
			logger.info("============================ 호출 실패");
			return new ResponseEntity<QuizcardVO>(qvo, HttpStatus.NOT_FOUND);
		}
	}
	
	// 퀴즈카드 스크랩 추가
	@PostMapping(value = "ajaxScrapAdd.do" , produces = "application/text;charset=utf8")
	public ResponseEntity<String> ajaxScrapAdd(QuizcardVO qvo, 
				@RequestParam int quizcard_index,
				@RequestParam String m_email){
		qvo.setM_email(m_email);
		qvo.setQuizcard_index(quizcard_index);
		boolean b = quizcardDao.ajaxScrapSelect(qvo);
		String message = null;
		if(b) {  // count(*) 결과가 0 => 중복없음.
			int n = quizcardDao.ajaxScrapAdd(qvo);
			if(n == 1) {
				message = "스크랩 추가 성공!!!!";
				return new ResponseEntity<String>(message, HttpStatus.OK);
			} else {
				message = "FAIL";
				return new ResponseEntity<String>(message, HttpStatus.NOT_IMPLEMENTED);
			}
		} else {
			message = "NO";
			return new ResponseEntity<String>(message, HttpStatus.ALREADY_REPORTED);
		}
	}
	
	// 퀴즈카드 Before페이지 모든 문제 select 
	@GetMapping(value = "questionNameList.do", produces = MediaType.APPLICATION_JSON_VALUE )
	public ResponseEntity<List<QuizcardVO>> questionNameList(QuizcardVO qvo, 
				@RequestParam int quizcard_set_no){
		
		qvo.setQuizcard_set_no(quizcard_set_no);
		List<QuizcardVO> list = new ArrayList<>();
		list = quizcardDao.questionNameList(qvo);
		if( list != null) {
			return new ResponseEntity<List<QuizcardVO>>(list, HttpStatus.OK);
		} else {
			list = null;
			return new ResponseEntity<List<QuizcardVO>>(list, HttpStatus.NOT_FOUND);
		}
	}
	
	// 즐겨찾기 추가 (in Quizcard Before 페이지 )
	@PostMapping(value = "ajaxBookmarkAdd.do", produces = "application/text;charset=utf8")
	public String ajaxBookmarkAdd(QuizcardVO qvo, @RequestParam String m_email,
				@RequestParam int quizcard_set_no) {
		
		qvo.setM_email(m_email);
		qvo.setQuizcard_set_no(quizcard_set_no);
		String responseText = null;
		int n = quizcardDao.ajaxBookmarkAdd(qvo);
		if(n == 1) {
			responseText = "OK";
		} else {
			responseText  = "NO";
		}
		return responseText; 
	}
	
	// 즐겨찾기 취소 (in Quizcard Before 페이지) 
	@PostMapping(value = "ajaxBookmarkDelete.do", produces = "application/text;charset=utf8")
	public String ajaxBookmarkDelete(QuizcardVO qvo, @RequestParam String m_email,
				@RequestParam int quizcard_set_no) {
		
		String responseText = null;
		qvo.setM_email(m_email);
		qvo.setQuizcard_set_no(quizcard_set_no);
		int n = quizcardDao.ajaxBookmarkDelete(qvo);
		if(n == 1) {
			responseText = "OK";
		} else {
			responseText = "NO";
		}
		return responseText;
	}
	
	// 즐겨찾기 상태 조회 
	@GetMapping(value = "ajaxBookmarkStatus.do", produces = "application/text;charset=utf8")
	public String ajaxBookmarkStatus(QuizcardVO qvo, @RequestParam String m_email,
				@RequestParam int quizcard_set_no) {
		qvo.setM_email(m_email);
		qvo.setQuizcard_set_no(quizcard_set_no);
		String responseText =null;
		
		boolean b = quizcardDao.ajaxBookmarkStatus(qvo);
		if(b) {
			responseText = "NO";
		}else {
			responseText = "YES";
		}
		return responseText;
	}
	
	// 좋아요 추가 ( 퀴즈카드 학습 결과 페이지) 
	@PostMapping(value = "ajaxLikeitAdd.do", produces = "application/text;charset=utf8")
	public ResponseEntity<String> ajaxLikeitAdd(QuizcardVO qvo, @RequestParam String m_email,
				@RequestParam int quizcard_set_no){
		System.out.println("이메일: " + m_email + ", 세트번호: " + quizcard_set_no);
		
		qvo.setM_email(m_email);
		qvo.setQuizcard_set_no(quizcard_set_no);
		String message = null;
		boolean b = quizcardDao.ajaxLikeitCheck(qvo);
		if(b) {
			int n = quizcardDao.ajaxLikeitAdd(qvo);
			if(n == 1) {
				message = "YES";
				int m = quizcardDao.quizcardLikeitUpdate(qvo);
				if(m == 1) System.out.println("퀴즈카드_set_likeit도 성공");
				return new ResponseEntity<String>(message, HttpStatus.OK);
			} else {
				message = "NO";
				return new ResponseEntity<String>(message, HttpStatus.NOT_IMPLEMENTED);
			}
		} else {
			message = "EXIST";
			return new ResponseEntity<String>(message, HttpStatus.ALREADY_REPORTED);
		}
	}
	
	// 사용자 정보 조회 모달창에 출력할 내용.
	@GetMapping(value = "ajaxUserInfo.do", produces = MediaType.APPLICATION_JSON_VALUE )
	public ResponseEntity<MemberVO> ajaxUserInfo(MemberVO mvo, QuizcardVO qvo, 
			@RequestParam("m_nickname") String m_nickname){
		System.out.println("넘어온 닉네임: " + m_nickname);
		mvo.setM_nickname(m_nickname);
		String m_email = memberDao.emailSelectByNickname(mvo).getM_email();
		System.out.println("닉네임으로 조회한 이메일: " + m_email);
		// 해당 이메일읉 오해서 프로필 이미지와ㅈ 정보들을 모두 가져온다. 
		mvo.setM_email(m_email);
		return new ResponseEntity <MemberVO>(memberDao.memberInfoSelect(mvo), HttpStatus.OK);
	}
	
	// 아카이브 박스 즐겨찾기 리스트 조회
	@GetMapping(value = "ajaxBookmark.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<QuizcardVO>> ajaxBookmark(QuizcardVO qvo, @RequestParam String m_email){
		logger.info("넘어온 이메일 조회: " + m_email );
		List<QuizcardVO> list = new ArrayList<QuizcardVO>();
		qvo.setM_email(m_email);
		list = quizcardDao.ajaxBookmark(qvo);
		return new ResponseEntity<List<QuizcardVO>>(list, HttpStatus.OK);
	}
	
	// 퀴즈카드 히스토리 insert & update
	@RequestMapping(value = "ajaxHistory.do", method = {RequestMethod.POST, RequestMethod.PUT}, produces = "application/text; charset=utf-8")
	public ResponseEntity<String> ajaxHistory(@RequestBody QuizcardVO qvo){
		
		System.out.println("파라미터 qvo값 조회: " + qvo);
		String responseText = "";
		boolean b = quizcardDao.ajaxHistory(qvo);
		if(b) {  // true인 경우. => 해당 quizcard_set_no  데이터로 history테이블에 존재한다는 뜻. => update 실행
			int m = quizcardDao.ajaxHistoryUpdate(qvo);
			if(m == 1) {
				responseText = "UPDATE";
				return new ResponseEntity<String>(responseText, HttpStatus.OK);
			} else {
				responseText  = "NOTUPDATE";
				return new ResponseEntity<String>(responseText, HttpStatus.NOT_MODIFIED);
			}
		} else { // false인 경우 => 최초. insert실행. 
			String quizcard_history = "학습중";
			qvo.setQuizcard_history(quizcard_history);
			int n = quizcardDao.ajaxHistoryInsert(qvo);
			if(n == 1) {
				responseText = "INSERT";
				return new ResponseEntity<String>(responseText, HttpStatus.OK);
			} else {
				responseText =  "NOTINSERT";
				return new ResponseEntity<String>(responseText, HttpStatus.NOT_IMPLEMENTED);
			}
		}
	}
	
	// 아카이브 박스 현재 학습중인 세트 조회하기 
	@PostMapping(value = "ajaxHistorySelect.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<QuizcardVO>> ajaxHistorySelect(@RequestBody QuizcardVO qvo){
		
		logger.info("ajax로 넘어온 @RequestBody의 값: " + qvo);
		List<QuizcardVO> list = new ArrayList<QuizcardVO>();
		list = quizcardDao.ajaxHistorySelect(qvo);
		System.out.println(list);
		return new ResponseEntity<List<QuizcardVO>>(list,HttpStatus.OK);
	}
	
	// 아카이브 박스 스크랩 목록 출력시키기
	@PostMapping(value = "ajaxArchiveScrapSelect.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<QuizcardVO>> ajaxScrapSelect(@RequestBody Map<String, String> map, QuizcardVO qvo){
		
		System.out.println("이메일 값 조회: " + map.get("m_email"));
		qvo.setM_email(map.get("m_email"));
		List<QuizcardVO> list = new ArrayList<>();
		list = quizcardDao.ajaxArchiveScrapSelect(qvo);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	// 아카이브 박스 스크랩 삭제 버튼 클릭
	@DeleteMapping(value = "ajaxScrapDelete.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> ajaxScrapDelete(@RequestBody QuizcardVO qvo){
		
		System.out.println("넘어온 qvo값 확인: " + qvo);
		String message = "";
		int n = quizcardDao.ajaxScrapDelete(qvo);
		if(n ==1) {
			message = "삭제되었습니다.";
		} else {
			message = "삭제실패";
		}
		return new ResponseEntity<>(message, HttpStatus.OK);
	}
	
	// 스크랩 문제 호출
	@GetMapping(value = "scrapQuestionSelect.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<QuizcardVO> scrapQuestionSelect(QuizcardVO qvo){
		return new ResponseEntity<QuizcardVO>(quizcardDao.scrapQuestionSelect(qvo), HttpStatus.OK);
	}
	
}
