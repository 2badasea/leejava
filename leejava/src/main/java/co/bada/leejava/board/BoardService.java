package co.bada.leejava.board;

import java.util.List;

public interface BoardService {
	List<BoardVO> boardSelectList();
	BoardVO boardSelect(BoardVO bvo);
	int boardInsert(BoardVO bvo);
	int boardUpdate(BoardVO bvo);
	int boardDelete(BoardVO bvo);
}
