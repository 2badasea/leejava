package co.bada.leejava.quizcardreply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("quizcardReplyDao")
public class QuizcardServiceImpl implements QuizcardReplyService{
	@Autowired
	QuizcardReplyMapper map;

	@Override
	public List<QuizcardReplyVO> quizcardReplyList(int quizcardSetNo) {
		return map.quizcardReplyList(quizcardSetNo);
	}
	
	
}
