package co.bada.leejava.board;

import java.util.Date;

import lombok.Data;

// 자유게시판용 VO객체. & 자유게시판을 토대로 페이징 개념 잡고 다른 게시판에도 적용시키기
@Data
public class BoardVO {
	private int b_no;  /// primary key. 일련번호.  시퀀스 board_seq 의 대상이다.
	private String b_category;   // 카테고리
	private String b_title;  // 글제목
	private String b_content; // 글내용
	private Date b_wdate;   // 시분초까지의 데이터를 가져오려면 java.util을 사용해야 한다. 
	private String b_writer; // 작성자
	private int b_hit; // 조회수
	private int b_like;  // 좋아요 수 
}
