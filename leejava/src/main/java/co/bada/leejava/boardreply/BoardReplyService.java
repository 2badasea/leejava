package co.bada.leejava.boardreply;

import java.util.List;

import co.bada.leejava.Search;

public interface BoardReplyService {
	// 댓글 1개 조회
	BoardReplyVO boardReplySelect(BoardReplyVO brvo);
	// 댓글 등록
	int boardReplyInsert(BoardReplyVO brvo);
	// 댓글 삭제
	int boardReplyDelete(BoardReplyVO brvo);
	// 댓글 수정
	int boardReplyUpdate(BoardReplyVO brvo);
	// 특정 게시글 댓글 조회
	List<BoardReplyVO> boardReplyList(Search svo);
	// 특정 게시글 댓글 수
	int getReplyCnt(Search svo);
}
