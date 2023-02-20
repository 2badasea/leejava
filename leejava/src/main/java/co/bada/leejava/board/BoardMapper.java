package co.bada.leejava.board;

import java.util.List;

import co.bada.leejava.Search;

public interface BoardMapper {
	// 자유게시판 페이징 처리를 위한 게시글의 총 갯수
	int getBoardListCnt(Search svo); 
	// 페이징 처리가 완료된 view단에 뿌려질 게시글 리스트
	List<BoardVO> boardSearchSelect(Search svo); 
	// 자유게시판 개별 게시글 조회
	BoardVO boardSelect(BoardVO bvo);
	// 자유게시판 등록
	int boardInsert(BoardVO bvo); 
	// 자유게시판 수정
	int boardUpdate(BoardVO bvo); 
	// 자유게시판 삭제
	int boardDelete(BoardVO bvo);
	// 파일업로드 테이블에 전달할 최근에 생성된 게시글 번호
	int getBno();
	// 자유게시판 조회수 업데이트
	int boardHitUpdate(BoardVO bvo);
	// 자유게시판 추천 클릭여부
	String boardLikeCheck(BoardVO bvo);
	// 자유게시판 추천테이블 insert
	int boardLikeitInsert(BoardVO bvo);
	// 자유게시판 추천수 업데이트 
	int boardLikeitUpdate(BoardVO bvo);
	// 자유게시판 추천테이블 delete
	int boardLikeitDelete(BoardVO bvo);
}
