package co.bada.leejava.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("boardDao")
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardMapper map;
	
	@Override
	public List<BoardVO> boardSelectList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BoardVO boardSelect(BoardVO bvo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int boardInsert(BoardVO bvo) {
		// TODO Auto-generated method stub
		return 0;
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

}
