package co.bada.leejava.quizcardreply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("quizcardReplyDao")
public class QuizcardReplyServiceImpl implements QuizcardReplyService{
	@Autowired
	QuizcardReplyMapper map;
	
	// 퀴즈카드 댓글 전체 출력
	@Override
	public List<QuizcardReplyVO> quizcardReplyList(QuizcardReplyVO qrvo) {
		System.out.println("======================== mapper 실행 전 qrvo: " + qrvo);
		return map.quizcardReplyList(qrvo);
	}
	
	// 퀴즈카드 댓글 등록
	@Override
	public int quizcardReplyInsert(QuizcardReplyVO qrvo) {
		return map.quizcardReplyInsert(qrvo);
	}

	@Override
	public int quizcardReplyDelete(QuizcardReplyVO qrvo) {
		return map.quizcardReplyDelete(qrvo);
	}

	@Override
	public int quizcardReplyUpdate(QuizcardReplyVO qrvo) {
		return map.quizcardReplyUpdate(qrvo);
	}
	
	
}
