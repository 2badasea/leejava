package co.bada.leejava.repair;

import lombok.Data;

@Data
public class RepairVO {
	private int rno;				// 글번호  
	private String rcategory;		// 카테고리(게시판 영역 select태그로 모든 페이지 선택) 
	private String rtitle;			// 제목 
	private String rcontent;		// 내용
	private String rwdate;			// 작성날짜 => 얘는 직접적인 페이징과는 관련이 업삳. 
	private String rfdate;			// 유지보수 완료 날짜.
	private String rstatus; 		// 유지보수 진행상황 ( 완료(초록)/ 진행중(노란색/ 시작전(회색 또는 빨강)() 
	private String m_email;			// 유지보수 신청자(기본적으로 관리자 )  ,  외래키로 구성된다.
	private String rgrade;			// 유지보수 우선순위 상중하 = radio버튼으로 구현하는 게 맞을까?
	private String rtimeorder; 		// 시간순서에 관한 값. => 디비에 저장되는 값은 아니다.
}
