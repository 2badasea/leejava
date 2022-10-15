package co.bada.leejava.board;

import lombok.Data;

// 자유게시판용 VO객체. & 자유게시판을 토대로 페이징 개념 잡고 다른 게시판에도 적용시키기
@Data
public class BoardVO {
	private int boardNo;			// 글번호, 기본키. 
	private String boardWdate;		// 작성일 
	private String boardRdate;		// 최근수정일
	private String boardWriter;		// Member테이블의 m_nickname 컬럼참조
	private String boardTitle; 		// 글제목 
	private String boardContents;	// 글내용
	private int boardHit;			// 조회수
	private int boardLikeit;		// 추천수(좋아요 수)
	private int bfileCheck; 		// 첨부파일 존재 유무(0 또는 1의 값을 가지도록)
}
