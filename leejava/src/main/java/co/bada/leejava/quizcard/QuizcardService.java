package co.bada.leejava.quizcard;

public interface QuizcardService {
	
	//	quizcard_set_ 생성 
	int quizcardSetCreate(QuizcardVO qvo);
	// 	quizcard_set_no 마지막 시퀀스 번호 조회
	int quizcardSetNoGet();
	// 카테고리 테이블 insert
	int quizcardCategory(QuizcardVO qvo);
}
