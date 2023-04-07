package co.bada.leejava.boardreply;

import lombok.Data;

@Data
public class BoardReplyVO {
	
	private int boardReplyRno;				// 댓글번호 기본키
	private int boardReplyBno;				// 참조하는 자유게시판 글번호 (외래키)
	private int boardReplyDepth;			// 기본값 0, 대댓글일 경우 1
	private int boardReplyParent;			// 부모 댓글 번호(참조 대상) 
	private int boardReplyGroup;			// 댓글과 대댓글 그룹 (댓글 숫자 세기)
	private String boardReplyContent;		// 댓글 내용
	private String boardReplyReplyer;		// 댓글 작성자
	private String boardReplyWdate;		// 댓글 작성일
	private String boardReplyUdate;			// 댓글 수정일
	
	
}
