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
		return map.boardSelect(bvo);
	}

	@Override
	public int boardInsert(BoardVO bvo) {
		// TODO Auto-generated method stub
		return map.boardInsert(bvo);
	}

	@Override
	public int boardUpdate(BoardVO bvo) {
		// TODO Auto-generated method stub
		return map.boardUpdate(bvo);
	}

	@Override
	public int boardDelete(BoardVO bvo) {
		// TODO Auto-generated method stub
		return map.boardDelete(bvo);
	}

	@Override
	public int getBoardListCnt(Search svo) {
		// TODO Auto-generated method stub
		return map.getBoardListCnt(svo);
	}

	@Override
	public List<BoardVO> boardSearchSelect(Search svo) {
		// TODO Auto-generated method stub
		return map.boardSearchSelect(svo);
	}

	@Override
	public int getBno() {
		// TODO Auto-generated method stub
		return map.getBno();
	}

	@Override
	public int boardHitUpdate(BoardVO bvo) {
		// TODO Auto-generated method stub
		return map.boardHitUpdate(bvo);
		
	}

	@Override
	public String boardLikeCheck(BoardVO bvo) {
		// TODO Auto-generated method stub
		return map.boardLikeCheck(bvo);
	}

	@Override
	public int boardLikeitInsert(BoardVO bvo) {
		// TODO Auto-generated method stub
		return map.boardLikeitInsert(bvo);
	}

	@Override
	public int boardLikeitUpdate(BoardVO bvo) {
		// TODO Auto-generated method stub
		return map.boardLikeitUpdate(bvo);
	}

	@Override
	public int boardLikeitDelete(BoardVO bvo) {
		// TODO Auto-generated method stub
		return map.boardLikeitDelete(bvo);
	}

}
