package co.bada.leejava.quizcard;

import lombok.Data;

@Data
public class QuizcardVO {
	// quizcard테이블에 존재하는 vo객체들 필드값들 모두 명시하면서 다시 정리하기
	
	// quizcard 테이블
	private int quizcard_set_no;				// 퀴즈카드 세트번호
	private String m_email;						// 작성자 이메일
	private String m_nickname;					// 작성자 닉네임
	private String quizcard_set_name;			// 퀴즈카드  세트이름
	private String quizcard_set_cdate;			// 퀴즈카드 (최초)생성일
	private String quizcard_set_udate;			// 퀴즈카드 (최근)마지막 업데이트날 
	private int quizcard_set_likeit;			// 퀴즈카드 추천수, 좋아요 수
	private String quizcard_set_status;			// 퀴즈카드, 상태( 접근권한) 
	private String quizcard_set_intro;			// 퀴즈카드 소개(설명) 
	private int quizcard_set_hit;				// 퀴즈카드 조회수
	private String quizcard_type;				// 퀴즈카드 유형(box, 주관식, 객관식)
	private int quizcard_replycnt;				// 댓글 개수
	
	
	// Quizcard_category 테이블
		// quizcard 테이블의 quizcard_set_no
//	private int quizcard_category_no;			// 퀴즈카드 카테고리 번호.
	private String quizcard_category;
	
	// Quizcard_Question 테이블
		// quizcard_set_no는 quizcard 테이블의 외래키로서 적용
	private String quizcard_no;   // 세트번호 + 문제번호 => 인조키로서 기본키값을 가질 필드값.
	private int quizcard_question_no; // 문제번호
	private String quizcard_question_name; // 문제(명) 
	private String quizcard_question_hint; // 힌트
	private String quizcard_question_answer;  // 답
	private int quizcard_index; 	// 인덱스(기본키)
	
	// Quizcard_Reply  문제세트별 댓글이나 후기 남기는 테이블
		// quizcard_set_no 가 외래키로서 필드값에 담는다.
		// m_email 은 댓글 작성자로서, 외래키다.
	private int quizcard_reply_no;	// 댓글번호(기본키)
	private String quizcard_reply_wdate;  // 댓글 작성시간
	private String quizcard_reply_update; // 댓글 수정시간
	private String quizcard_reply_status; // 대댓글 여부 상태
	
	
	// quizcard_history 테이블
	private String quizcard_history; // 학습진도 상태
	private String quizcard_history_date; // 최근학습날짜
	
	
}