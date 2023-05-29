package co.bada.leejava.quizcardreply;

import java.util.List;

public interface QuizcardReplyMapper {
	
	// 특정 퀴즈카드 세트 댓글 전체 출력
	List<QuizcardReplyVO> quizcardReplyList(int quizcardSetNo);
}
