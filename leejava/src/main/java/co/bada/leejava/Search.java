package co.bada.leejava;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

// 사실상 여기에 모둔 vo객체 변수들을 저장해도 무방.
@Getter
@Setter
public class Search extends Paging {
	
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
	
	// 여기에다가 자유게시판 영역에 들어갈 vo변수들을 선언해야 함.
	
}
