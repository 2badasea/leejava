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
	private int b_no;  /// primary key. 일련번호.  시퀀스 board_seq 의 대상이다.
	private String b_category;   // 카테고리
	private String b_title;  // 글제목
	private String b_content; // 글내용
	private Date b_wdate;   // 시분초까지의 데이터를 가져오려면 java.util을 사용해야 한다. 
	private String b_writer; // 작성자
	private int b_hit; // 조회수
	private int b_like;  // 좋아요 수
	
	
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
	private String quizcard_type;				// 퀴즈카드 유형
	
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
	// ======================================================================
	
}
