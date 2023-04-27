package co.bada.leejava.boardreply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import co.bada.leejava.Search;

@Repository("replyDao")
public class BoardReplyServiceImpl implements BoardReplyService {
	@Autowired
	BoardReplyMapper map;

	@Override
	public int boardReplyInsert(BoardReplyVO brvo) {
		// TODO Auto-generated method stub
		return map.boardReplyInsert(brvo);
	}

	@Override
	public int boardReplyDelete(BoardReplyVO brvo) {
		// TODO Auto-generated method stub
		return map.boardReplyDelete(brvo);
	}

	@Override
	public int boardReplyUpdate(BoardReplyVO brvo) {
		// TODO Auto-generated method stub
		return map.boardReplyUpdate(brvo);
	}

	@Override
	public List<BoardReplyVO> boardReplyList(Search svo) {
		// TODO Auto-generated method stub
		return map.boardReplyList(svo);
	}

	@Override
	public int getReplyCnt(Search svo) {
		// TODO Auto-generated method stub
		return map.getReplyCnt(svo);
	}

	@Override
	public BoardReplyVO boardReplySelect(BoardReplyVO brvo) {
		// TODO Auto-generated method stub
		return map.boardReplySelect(brvo);
	}

	@Override
	public int boardReplyGroupUpdate(BoardReplyVO brvo) {
		// TODO Auto-generated method stub
		return map.boardReplyGroupUpdate(brvo);
	}
}
