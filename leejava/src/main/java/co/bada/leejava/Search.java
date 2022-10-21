package co.bada.leejava;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

// 사실상 여기에 모둔 vo객체 변수들을 저장해도 무방.
@Getter
@Setter
public class Search extends Paging {
	
	// 회원 member
	private String m_email;		// 가입 이메일
	private String m_password;	// 비밀번호
	private String m_joindate;	// 가입 날짜
	private String m_joinpath;  // 가입 경로(유형)
	private String m_phone;		// 연락처 
	private String m_address;	// 주소
	private String m_status; 	// 권한
	private String m_birthdate; // 생년월일
	private String m_salt; 		// 암호화를 위해 생성한 salt값
	private String m_intro;
	// 가입약관 동의여부
	private String m_privacy; // 개인정보 유효기간
	private String m_promotion; // 프로모션 수신 여부
	/* 이미지 정보 	*/
	private List<AttachImageVO> imageList; 
	// 관리자 화면 => 회원검색 기간 달력 2개
	private String frontCal;
	private String backCal;
	
	/* 프로필 이미지 경로 정보 AttachImageVO */
	// 경로
	private String uploadPath;
	// uuid
	private String uuid;
	// 파일 이름
	private String fileName;
	
	// 공지사항 notice
	private int n_no; // 글번호
	private String n_writer;	// 작성자
	private String n_wdate; 	// 작성일
	private String n_category; 	// 카테고리
	private String n_title;		// 글제목
	private String n_content;	// 글내용
	private String n_file;		// 첨부파일 원본명
	private String n_pfile;		// 첨부파일 물리적으로 저장된 이름. 
	private int n_hit;			// 조회수
	private String n_fixed;		// 게시글 상단 고정여부
	
	// 자유게시판 board
	private int boardNo;			// 글번호, 기본키. 
	private String boardWdate;		// 작성일 
	private String boardRdate;		// 최근수정일
	private String boardWriter;		// Member테이블의 m_nickname 컬럼참조
	private String boardTitle; 		// 글제목 
	private String boardContents;	// 글내용
	private int boardHit;			// 조회수
	private int boardLikeit;		// 추천수(좋아요 수)
	private int bfileCheck; 		// 첨부파일 존재 유무(0 또는 1의 값을 가지도록)
	
	// 첨부파일 업로드(자유게시판, Qna, 정보, 모임 등)
	private int whatB;					// 게시판 구분(자유게시판1, qna2, 정보3, 모임4);
	private int whatB_no;				// 해당 게시판에서의 글번호
	private String whatB_uuid; 			// 고유넘버
	private String whatB_uploadPath;	// 업로브 경로(년,월,일)
	private String whatB_ofile; 		// 업로드 파일의 원본명
	
	// QuizcardVO 클래스에 선언되어 있는 filed 값들. ================================
	private int quizcard_set_no; 				// 퀴즈카드 세트번호
//	private String m_email; 					// 사용자 이메일
	private String m_nickname;					// 사용자 닉네임
	private String quizcard_set_name;			// 퀴즈카드 세트 이름
	private String quizcard_set_cdate;			// 퀴즈카드 생성날짜
	private String quizcard_set_udate;			// 퀴즈카드 마지막 업데이트 날짜. 
	private int quizcard_set_likeit;			// 퀴즈카드 좋아요(추천수)
	private String quizcard_set_status;			// 퀴즈카드, 상태( 접근권한) 
	private String quizcard_set_intro;			// 퀴즈카드 소개(설명) 
	private int quizcard_set_hit;				// 퀴즈카드 조회수
	private String quizcard_type;				// 퀴즈카드 유형 (box형인지 아닌지)
	
	private String quizcard_category;			// 퀴즈카드 카테고리
	
	private String quizcard_no;  				 // 세트번호 + 문제번호 => 인조키로서 기본키값을 가질 필드값.
	private int quizcard_question_no; 			// 문제번호
	private String quizcard_question_name;		 // 문제(명) 
	private String quizcard_question_hint;		 // 힌트
	private String quizcard_question_answer; 	 // 답
	private int quizcard_index; 				// 인덱스(기본키)
	
	private int quizcard_reply_no;				// 댓글번호(기본키)
	private String quizcard_reply_wdate; 		 // 댓글 작성시간
	private String quizcard_reply_update; 		// 댓글 수정시간
	private String quizcard_reply_status;		 // 대댓글 여부 상태
	
	// quizcard_history 테이블
	private String quizcard_history; // 학습진도 상태
	private String quizcard_history_date; // 최근학습날짜
	
	// Repair 유지보수 관리 테이블
	private int rno;				// 글번호  
	private String rcategory;		// 카테고리(게시판 영역 select태그로 모든 페이지 선택) 
	private String rtitle;			// 제목 
	private String rcontent;		// 내용
	private String rwdate;			// 작성날짜
	private String rfdate;			// 유지보수 완료 날짜.
	private String rstatus; 		// 유지보수 진행상황 ( 완료(초록)/ 진행중(노란색/ 시작전(회색 또는 빨강)() 
	private String rgrade;			// 유지보수 우선순위 
	private String rtimeorder;		// 유지보수 게시판= => 시간순서에 대한 필드값(DB에 저장되는 값은 아님)
	// ======================================================================
	
	// 배너신청 관리 테이블
	private int banno;							// 배너게시판 글번호
	private String banfile;						// 배너 이미지파일 원본명 
	private String banpfile;					// 배너 물리 파일명
	private String banapplytitle;				// 배너 신청글 제목
	private String banapplycontent;				// 배너 신청글 내용
	private String banapplydate;				// 배너 신청날짜.
	private String banapplytype;				// 배넛 신청유형(결제유형) 
	private String banpostdate;					// 배너 게시 시작일
	private String banpostenddate;				// 배너 게시 만료일 ( 게시 시작일 + 신청유형의 값) 
	private String banpoststatus;				// 배너 게시상태( 게시 or 노게시) 
	
	// 메시지 테이블 
	private int msgno;   			// 인덱스 번호.
	private String msgdate;			// 메시지 작성날짜
	private String fromnick;		// 보내는 사람 닉네임
	private String tonick;			// 받는 사람 닉네임
	private String msgtitle;		// 메시지 제목
	private String msgcontent;		// 메시지 내용
	private int msgcheck;			// 메시지 읽음여부 확인 '0' or '1'
}	
