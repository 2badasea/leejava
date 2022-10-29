package co.bada.leejava.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import co.bada.leejava.Search;

@Repository("boardDao")
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardMapper map;

	@Override
	public BoardVO boardSelect(BoardVO bvo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int boardInsert(BoardVO bvo) {
		// TODO Auto-generated method stub
		return map.boardInsert(bvo);
	}

	@Override
	public int boardUpdate(BoardVO bvo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int boardDelete(BoardVO bvo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getBoardListCnt(Search svo) {
		// TODO Auto-generated method stub
		return map.getBoardListCnt(svo);
	}

	@Override
	public List<BoardVO> boardSearchSelect(Search svo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getBno() {
		// TODO Auto-generated method stub
		return map.getBno();
	}

}
