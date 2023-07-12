package co.bada.leejava.quizcardreply;

import lombok.Data;

@Data
public class QuizcardReplyVO {
	
	private int quizcard_Reply_Rno;			// 댓글번호 기본키
	private int quizcard_Reply_Bno;			// 참조하는 퀴즈카드 세트번호(외래키)
	private int quizcard_Reply_Depth;			// 기본값 0, 대댓글일 경우 1
	private int quizcard_Reply_Parent;		// 부모 댓글 번호(참조 대상) 
	private int quizcard_Reply_Group;			// 댓글과 대댓글 그룹 (댓글 숫자 세기)
	private String quizcard_Reply_Content;	// 댓글 내용
	private String quizcard_Reply_Replyer;	// 댓글 작성자
	private String quizcard_Reply_Wdate;		// 댓글 작성일
	private String quizcard_Reply_Udate;		// 댓글 수정일
}
