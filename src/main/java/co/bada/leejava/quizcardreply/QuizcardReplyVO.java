package co.bada.leejava.quizcardreply;

import lombok.Data;

@Data
public class QuizcardReplyVO {
	
	private int quizcardReplyRno;			// 댓글번호 기본키
	private int quizcardReplyBno;			// 참조하는 퀴즈카드 세트번호(외래키)
	private int quizcardReplyDepth;			// 기본값 0, 대댓글일 경우 1
	private int quizcardReplyParent;		// 부모 댓글 번호(참조 대상) 
	private int quizcardReplyGroup;			// 댓글과 대댓글 그룹 (댓글 숫자 세기)
	private String quizcardReplyContent;	// 댓글 내용
	private String quizcardReplyReplyer;	// 댓글 작성자
	private String quizcardReplyWdate;		// 댓글 작성일
	private String quizcardReplyUdate;		// 댓글 수정일
}
