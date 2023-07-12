package co.bada.leejava.quizcardreply;

import java.util.List;

public interface QuizcardReplyMapper {
	
	// 특정 퀴즈카드 세트 댓글 전체 출력
	List<QuizcardReplyVO> quizcardReplyList(QuizcardReplyVO qrvo);
	// 댓글 등록
	int quizcardReplyInsert(QuizcardReplyVO qrvo);
	// 댓글 삭제(실제로는 content값 null 처리) 
	int quizcardReplyDelete(QuizcardReplyVO qrvo);
	// 댓글 수정
	int quizcardReplyUpdate(QuizcardReplyVO qrvo);
}
