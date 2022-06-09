package co.bada.leejava.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import co.bada.leejava.Pagination;

@Repository("boardDao")
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardMapper map;
	
	@Override
	public List<BoardVO> getBoardList(Pagination pagination) {
		// TODO Auto-generated method stub
		return map.getBoardList(pagination);
	}

	@Override
	public BoardVO boardSelect(BoardVO bvo) {
		// TODO Auto-generated method stub
		return map.boardSelect(bvo);
	}

	@Override
	public int deleteBoard(BoardVO bvo) {
		// TODO Auto-generated method stub
		return map.deleteBoard(bvo);
	}

	@Override
	public int updateBoard(BoardVO bvo) {
		// TODO Auto-generated method stub
		return map.updateBoard(bvo);
	}

	@Override
	public int insertBoard(BoardVO bvo) {
		// TODO Auto-generated method stub
		return map.insertBoard(bvo);
	}

	@Override
	public int updateHitCount(BoardVO bvo) {
		// TODO Auto-generated method stub
		return map.updateHitCount(bvo);
	}

	@Override
	public int getBoardListCnt() throws Exception {
		// TODO Auto-generated method stub
		return map.getBoardListCnt();
	}
	
}
