package co.bada.leejava.repair;

import lombok.Data;

@Data
public class RepairVO {
	private int rno;				// 글번호  
	private String rCategory;		// 카테고리(게시판 영역 select태그로 모든 페이지 선택) 
	private String rTitle;			// 제목 
	private String rContent;		// 내용
	private String rWdate;			// 작성날짜
	private String rFdate;			// 유지보수 완료 날짜.
	private String rStatus; 		// 유지보수 진행상황 ( 완료(초록)/ 진행중(노란색/ 시작전(회색 또는 빨강)() 
	private String m_email;			// 유지보수 신청자(기본적으로 관리자 )  ,  외래키로 구성된다.
	
}
