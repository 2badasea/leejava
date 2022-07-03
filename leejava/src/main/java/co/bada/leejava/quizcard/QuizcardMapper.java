package co.bada.leejava.quizcard;

import java.util.List;

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
	QuizcardVO ajaxMyQuizcard(QuizcardVO qvo);
	// 퀴즈카드 set별 문제 총 갯수 
	int quizcardQuestionCount(QuizcardVO qvo); 
	// 퀴즈카드 set별 댓글 갯수
	int quizcardReplyCount(QuizcardVO qvo);
	// 퀴즈카드 대기실에서 출력시킬 정보들
	QuizcardVO quizcardBeforeInfo(QuizcardVO qvo);
}
