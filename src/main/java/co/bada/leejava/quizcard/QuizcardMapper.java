package co.bada.leejava.quizcard;

import java.util.List;

import co.bada.leejava.Search;

public interface QuizcardMapper {
	
	//	quizcard_set_ 생성 
	int quizcardSetCreate(QuizcardVO qvo);
	// 	quizcard_set_no 마지막 시퀀스 번호 조회
	int quizcardSetNoGet();
	// 카테고리 테이블 insert
	int quizcardCategory(QuizcardVO qvo);
	// 퀴즈카드 문제 생성 폼 => join문으로 퀴즈카드, 퀴즈카드 카테고리 테이블의 데이터를 가져온다
	QuizcardVO quizcardSelect(QuizcardVO qvo);
	// 첫 기본 quizcard_question 데이터
	int firstQuestionInsert(QuizcardVO qvo);
	// 퀴즈카드 메인페이지 게시판 출력할 데이터
	List<QuizcardVO> quizcardList();
	// 퀴즈카드 아카이브 박스 내가 생성한 세트 리스트
	List<QuizcardVO> ajaxMyQuizcard(QuizcardVO qvo);
	// 퀴즈카드 set별 문제 총 갯수 
	int quizcardQuestionCount(QuizcardVO qvo); 
	
	// 퀴즈카드 set별 댓글 갯수
	int quizcardReplyCount(QuizcardVO qvo);
	// 퀴즈카드 세트 댓글 수 업데이트
	int replyCntUpdate(QuizcardVO qvo);
	
	// 퀴즈카드 대기실에서 출력시킬 정보들
	QuizcardVO quizcardBeforeInfo(QuizcardVO qvo);
	// 퀴즈카드 세트번호별 문제, 힌트, 답 조회
	List<QuizcardVO> quizcardQuestionList(QuizcardVO qvo); 
	// 퀴즈카드 blur이벤트에 의한 자동업데이트
	int ajaxQuestionUpdate(QuizcardVO qvo);
	// 퀴즈카드 마지막 수정일 업데이트
	int quizcardUdateChange(QuizcardVO qvo);
	// 신규 퀴즈카드 추가( 수정 페이지) 
	int ajaxQuestionNew(QuizcardVO qvo);
	// 퀴즈카드 삭제 이벤트(수정 페이지)	
	int ajaxQuestionDel(QuizcardVO qvo);
	// 퀴즈카드 삭제 후 넘버링 작업 (수정 페이지)
	int ajaxUpdateQuestionNo(QuizcardVO qvo);
	// 퀴즈카드 클릭 시 조회수 증가
	int quizcardHitUpdate(QuizcardVO qvo);
	// 퀴즈카드 학습 시작. 문제 호출
	QuizcardVO ajaxStudyStart(QuizcardVO qvo);
	// 퀴즈카드 세트 정보 수정
	int ajaxQuizInfoUpdate(QuizcardVO qvo);
	// 퀴즈카드 틀린 문제 조회
	QuizcardVO ajaxWrongQuestion(QuizcardVO qvo);
	// 스크랩 중복 조회
	boolean ajaxScrapSelect(QuizcardVO qvo);
	// 스크랩 추가
	int ajaxScrapAdd(QuizcardVO qvo);
	// 퀴즈카드 Before페이지, 문제 리스트 출력
	List<QuizcardVO> questionNameList(QuizcardVO qvo);
	// 퀴즈카드 즐겨찾기 추가
	int ajaxBookmarkAdd(QuizcardVO qvo);
	// 퀴즈카드 즐겨찾기 취소
	int ajaxBookmarkDelete(QuizcardVO qvo);
	// 퀴즈카드 즐겨찾기 추가여부 조회
	boolean ajaxBookmarkStatus(QuizcardVO qvo);
	// 퀴즈카드 좋아요 조회
	boolean ajaxLikeitCheck(QuizcardVO qvo);
	// 퀴즈카드 좋아요 추가
	int ajaxLikeitAdd(QuizcardVO qvo);
	// 퀴즈카드 좋아요 수 +1 업데이트
	int quizcardLikeitUpdate(QuizcardVO qvo);
	// 퀴즈카드 아카이브 박스 즐겨찾기 리스트 호출
	List<QuizcardVO> ajaxBookmark(QuizcardVO qvo);
	// 학습중인 세트 있는지 조회
	boolean ajaxHistory(QuizcardVO qvo);
	// 학습주인 세트 최초 insert
	int ajaxHistoryInsert(QuizcardVO qvo);
	// 학습중인 세트 update
	int ajaxHistoryUpdate(QuizcardVO qvo);
	// 퀴즈카드 히스토리 아카이브에 출력시킬 리스트 조회
	List<QuizcardVO> ajaxHistorySelect(QuizcardVO qvo);
	// 퀴즈카드 스크랩 문제 아카이브 영역 출력
	List<QuizcardVO> ajaxArchiveScrapSelect(QuizcardVO qvo);
	// 퀴즈카드 스크랩(아카이브 박스) 삭제 구현
	int ajaxScrapDelete(QuizcardVO qvo);
	// 아카이브 스크랩 문제 모달창 호출
	QuizcardVO scrapQuestionSelect(QuizcardVO qvo);
	
	// 페이징 처리를 위한 퀴즈카드 총 갯수를 구한다. (검색항목 3개 반영된 것) 
	int getQuizcardListCnt(Search svo) throws Exception;
	// 페이징 처리가 된 퀴즈카드 리스트 메인리스트에 출력
	List<QuizcardVO> quizcardSearchSelect(Search svo) throws Exception;
}
