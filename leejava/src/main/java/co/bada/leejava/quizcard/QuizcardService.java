package co.bada.leejava.quizcard;

public interface QuizcardService {
	
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
}
